Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7121D58B4CB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 11:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241777AbiHFJl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 05:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiHFJlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 05:41:53 -0400
Received: from ns3.fnarfbargle.com (ns3.fnarfbargle.com [103.4.19.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C0865C9
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 02:41:48 -0700 (PDT)
Received: from [10.8.0.1] (helo=srv.home)
        by ns3.fnarfbargle.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1oKGJU-0002ed-CI; Sat, 06 Aug 2022 19:41:45 +1000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fnarfbargle.com; s=mail; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gjZSigcRsapij8elFNDSd4ZGVvCrdFNU6BRZxwuMlXg=; b=LVay197+G0nTCih1tKkuPuhEtN
        sBmfeSY0ZcVVD5c27q5U74q22hQkQIsXs5TLLaqDku+shRKbjrjuSoUsyK0E3Rug0heGgPSaFLEDO
        HZjD6y8PYf4cGssRvQs8V7BmZaZeW78gi7eIF7VXM3CUvnfKDzANLqrFch9ZfI3QzGcY=;
Message-ID: <42e81a8e-e393-7a69-7339-a020ebb57935@fnarfbargle.com>
Date:   Sat, 6 Aug 2022 17:41:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   Brad Campbell <lists2009@fnarfbargle.com>
Subject: Re: Apple Thunderbolt Display chaining
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
References: <YkrqL/wnACNVOpSi@lahna>
 <ae336e2d-8e7c-9167-ab3d-8d642cd4fb2c@fnarfbargle.com>
 <Yk2qMt568oEeTj8H@lahna>
 <49183e52-2e73-b32f-11ad-6036b1040d7c@fnarfbargle.com>
 <Yuz/Q3MTVIhCZU+0@lahna>
 <f5c8b9f0-0d6d-c6db-ae0b-894acb58d078@fnarfbargle.com>
 <Yu0UuOVGeIv/U+jU@lahna>
 <d484d7e5-f1aa-1096-e6fb-bbf16ce28699@fnarfbargle.com>
 <Yu0nWro4xXURbSX6@lahna>
 <87c1a001-ef79-6390-dfe2-06d2850f6e84@fnarfbargle.com>
 <Yu4Gmkous7asng6h@lahna>
Content-Language: en-AU
In-Reply-To: <Yu4Gmkous7asng6h@lahna>
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

On 6/8/22 14:13, Mika Westerberg wrote:
> Hi Brad,
> 
> On Fri, Aug 05, 2022 at 10:43:54PM +0800, Brad Campbell wrote:
>> On 5/8/22 22:21, Mika Westerberg wrote:
>>
>>> They are pretty standard so I suspect myself the display side of things.
>>> Not sure if it is possible (I think it is from sysfs /sys/class/drm/*)
>>> to disable the tunneled DP connections and see if that makes it not
>>> hang. Alternatively you can try to comment out the call to
>>> tb_tunnel_dp() from the driver. Let me know if you want me to make hack
>>> patch that does it for you.
>>>
>>
>> I used this :
>>
>> iff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
>> index 9a3214fb5038..eae7523af78b 100644
>> --- a/drivers/thunderbolt/tb.c
>> +++ b/drivers/thunderbolt/tb.c
>> @@ -865,7 +865,7 @@ static void tb_tunnel_dp(struct tb *tb)
>>          struct tb_cm *tcm = tb_priv(tb);
>>          struct tb_port *port, *in, *out;
>>          struct tb_tunnel *tunnel;
>> -
>> +       return;
>>          if (!tb_acpi_may_tunnel_dp()) {
>>                  tb_dbg(tb, "DP tunneling disabled, not creating tunnel\n");
>>                  return;
>>
>> I'm now using Linus GIT head. No change in behaviour really.
>>
>> No tunnels were created. None of the TB displays light up in Linux or BIOS. System still locks
>> up on reboot and the first time I attempted to compose this reply it locked up hard before I
>> had a chance to finish it because I attempted to verify the devices were present with an lspci -tv.
>>
>> If I do an lspci -tv after the module load, it locks hard instantly and reproducibly.
> 
> Okay, let's try to deal with one issue at the time so first the hang
> that appears after the OS is booted up. Do you still have the
> "pcie_port_pm=off" in the kernel command line? 

Yes, I still have/had that present.

> The hang that happens
> afterwards sounds exactly like that the runtime PM would kick in but the
> parameter should prevent that from happening. Since you are connecting
> Thunderbolt 1 devices there is really no PM we can do for them at all
> and the TBT driver should block it too.
> 
> Is it possible to narrow this down to a single device connected and then
> get me the full dmesg output (with CONFIG_PCI_DEBUG=y) and output of
> 'sudo lspci -vv'?
> 

I've left in the patch to not set up the DP tunnel and recompiled with CONFIG_PCI_DEBUG=y

The minimum I can use to reproduce the fault is a single Thunderbolt display. The Apple TB->GBe dongle doesn't do it
and I have a TB->USB3+eSATA dongle that won't run on the TB3->TB1 adapter due to insufficient power.

This is captured with serial console. It's a cold boot with a single TB display connected. Boots to desktop and I immediately issue a reboot.

 From -> [   15.337689] xhci_hcd 0000:53:00.3: xHCI Host Controller <- on the second boot, the console output slows to
about 1-2 characters per second (nothing updates on the monitor) and eventually the machine reboots by itself. I don't have reboot on panic set.

[    0.000000] Linux version 5.19.0+ (brad@bkd) (gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2) #55 SMP PREEMPT_DYNAMIC Sat Aug 6 16:55:17 AWST 2022
[    0.000000] Command line: ro root=UUID=c6cf971d-5412-4826-851d-5677ad7997c0 thunderbolt.dyndbg pcie_port_pm=off console=ttyS0,115200 console=tty0 nogpu initrd=\initrd.img-5.19.0+
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
[    0.000000] x86/fpu: Enabled xstate features 0x207, context size is 840 bytes, using 'compacted' format.
[    0.000000] signal: max sigframe size: 3376
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009c3efff] usable
[    0.000000] BIOS-e820: [mem 0x0000000009c3f000-0x0000000009ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000000a000000-0x000000000a1fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000000a200000-0x000000000a20cfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000000a20d000-0x000000000affffff] usable
[    0.000000] BIOS-e820: [mem 0x000000000b000000-0x000000000b01ffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000000b020000-0x000000007a076fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007a077000-0x000000007a077fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007a078000-0x000000007a098fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007a099000-0x000000007a099fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007a09a000-0x000000009754cfff] usable
[    0.000000] BIOS-e820: [mem 0x000000009754d000-0x000000009a086fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000009a087000-0x000000009a0ddfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000009a0de000-0x000000009bb5bfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000009bb5c000-0x000000009cdfefff] reserved
[    0.000000] BIOS-e820: [mem 0x000000009cdff000-0x000000009dffffff] usable
[    0.000000] BIOS-e820: [mem 0x000000009e000000-0x000000009fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f0000000-0x00000000f7ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fd200000-0x00000000fd2fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fd600000-0x00000000fd6fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fea00000-0x00000000fea0ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feb80000-0x00000000fec01fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec30000-0x00000000fec30fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedc2000-0x00000000fedcffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedd4000-0x00000000fedd5fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000083e2fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000083e300000-0x000000085fffffff] reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] reserve setup_data: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x0000000009c3efff] usable
[    0.000000] reserve setup_data: [mem 0x0000000009c3f000-0x0000000009ffffff] reserved
[    0.000000] reserve setup_data: [mem 0x000000000a000000-0x000000000a1fffff] usable
[    0.000000] reserve setup_data: [mem 0x000000000a200000-0x000000000a20cfff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000000a20d000-0x000000000affffff] usable
[    0.000000] reserve setup_data: [mem 0x000000000b000000-0x000000000b01ffff] reserved
[    0.000000] reserve setup_data: [mem 0x000000000b020000-0x000000007a076fff] usable
[    0.000000] reserve setup_data: [mem 0x000000007a077000-0x000000007a077fff] reserved
[    0.000000] reserve setup_data: [mem 0x000000007a078000-0x000000007a098fff] usable
[    0.000000] reserve setup_data: [mem 0x000000007a099000-0x000000007a099fff] reserved
[    0.000000] reserve setup_data: [mem 0x000000007a09a000-0x00000000936f5017] usable
[    0.000000] reserve setup_data: [mem 0x00000000936f5018-0x0000000093702857] usable
[    0.000000] reserve setup_data: [mem 0x0000000093702858-0x0000000093732017] usable
[    0.000000] reserve setup_data: [mem 0x0000000093732018-0x0000000093741057] usable
[    0.000000] reserve setup_data: [mem 0x0000000093741058-0x0000000093cbf017] usable
[    0.000000] reserve setup_data: [mem 0x0000000093cbf018-0x0000000093ccc857] usable
[    0.000000] reserve setup_data: [mem 0x0000000093ccc858-0x000000009754cfff] usable
[    0.000000] reserve setup_data: [mem 0x000000009754d000-0x000000009a086fff] reserved
[    0.000000] reserve setup_data: [mem 0x000000009a087000-0x000000009a0ddfff] ACPI data
[    0.000000] reserve setup_data: [mem 0x000000009a0de000-0x000000009bb5bfff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000009bb5c000-0x000000009cdfefff] reserved
[    0.000000] reserve setup_data: [mem 0x000000009cdff000-0x000000009dffffff] usable
[    0.000000] reserve setup_data: [mem 0x000000009e000000-0x000000009fffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000f0000000-0x00000000f7ffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fd200000-0x00000000fd2fffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fd600000-0x00000000fd6fffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fea00000-0x00000000fea0ffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000feb80000-0x00000000fec01fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec30000-0x00000000fec30fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed40000-0x00000000fed44fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed80000-0x00000000fed8ffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fedc2000-0x00000000fedcffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fedd4000-0x00000000fedd5fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000083e2fffff] usable
[    0.000000] reserve setup_data: [mem 0x000000083e300000-0x000000085fffffff] reserved
[    0.000000] efi: EFI v2.70 by American Megatrends
[    0.000000] efi: ACPI=0x9bb45000 ACPI 2.0=0x9bb45014 SMBIOS=0x9cc2b000 SMBIOS 3.0=0x9cc2a000 MEMATTR=0x93ccd018 ESRT=0x96088c18 RNG=0x9cc27498
[    0.000000] efi: seeding entropy pool
[    0.000000] SMBIOS 3.3.0 present.
[    0.000000] DMI: Gigabyte Technology Co., Ltd. B550 VISION D-P/B550 VISION D-P, BIOS F15d 07/20/2022
[    0.000000] last_pfn = 0x83e300 max_arch_pfn = 0x400000000
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.000000] last_pfn = 0x9e000 max_arch_pfn = 0x400000000
[    0.000000] esrt: Reserving ESRT space from 0x0000000096088c18 to 0x0000000096088c50.
[    0.000000] Using GB pages for direct mapping
[    0.000000] Secure boot disabled
[    0.000000] RAMDISK: [mem 0x7f171000-0x7fffffff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x000000009BB45014 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x000000009BB44728 0000D4 (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.000000] ACPI: FACP 0x000000009A0C5000 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 0x000000009A096000 006227 (v02 ALASKA A M I    01072009 INTL 20190509)
[    0.000000] ACPI: FACS 0x000000009AB3F000 000040
[    0.000000] ACPI: SSDT 0x000000009A0D4000 009FFD (v02 GBT    GSWApp   00000001 INTL 20190509)
[    0.000000] ACPI: IVRS 0x000000009A0D3000 0000D0 (v02 AMD    AmdTable 00000001 AMD  00000001)
[    0.000000] ACPI: SSDT 0x000000009A0CB000 0072B0 (v02 AMD    Artic    00000002 MSFT 04000000)
[    0.000000] ACPI: SSDT 0x000000009A0C7000 003D74 (v01 AMD    AMD AOD  00000001 INTL 20190509)
[    0.000000] ACPI: SSDT 0x000000009A0C6000 0001AD (v02 ALASKA CPUSSDT  01072009 AMI  01072009)
[    0.000000] ACPI: FIDT 0x000000009A0BE000 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 0x000000009A0BD000 00003C (v01 ALASKA A M I    01072009 MSFT 00010013)
[    0.000000] ACPI: HPET 0x000000009A0BC000 000038 (v01 ALASKA A M I    01072009 AMI  00000005)
[    0.000000] ACPI: FPDT 0x000000009A0BB000 000044 (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.000000] ACPI: VFCT 0x000000009A0AD000 00D884 (v01 ALASKA A M I    00000001 AMD  31504F47)
[    0.000000] ACPI: SSDT 0x000000009A0A9000 003E88 (v02 AMD    AmdTable 00000001 AMD  00000001)
[    0.000000] ACPI: CRAT 0x000000009A0A8000 000B68 (v01 AMD    AmdTable 00000001 AMD  00000001)
[    0.000000] ACPI: CDIT 0x000000009A0A7000 000029 (v01 AMD    AmdTable 00000001 AMD  00000001)
[    0.000000] ACPI: SSDT 0x000000009A0A5000 001486 (v01 AMD    ArticIG2 00000001 INTL 20190509)
[    0.000000] ACPI: SSDT 0x000000009A0A3000 0014FD (v01 AMD    ArticTPX 00000001 INTL 20190509)
[    0.000000] ACPI: SSDT 0x000000009A09F000 0039F7 (v01 AMD    ArticN   00000001 INTL 20190509)
[    0.000000] ACPI: WSMT 0x000000009A09E000 000028 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: APIC 0x000000009A09D000 00015E (v04 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x000000009A0C4000 0008A4 (v01 AMD    ArticPRN 00000001 INTL 20190509)
[    0.000000] ACPI: SSDT 0x000000009A0C2000 00147F (v01 AMD    ArticC   00000001 INTL 20190509)
[    0.000000] ACPI: SSDT 0x000000009A0C1000 0000BF (v01 AMD    AmdTable 00001000 INTL 20190509)
[    0.000000] ACPI: Reserving FACP table memory at [mem 0x9a0c5000-0x9a0c5113]
[    0.000000] ACPI: Reserving DSDT table memory at [mem 0x9a096000-0x9a09c226]
[    0.000000] ACPI: Reserving FACS table memory at [mem 0x9ab3f000-0x9ab3f03f]
[    0.000000] ACPI: Reserving SSDT table memory at [mem 0x9a0d4000-0x9a0ddffc]
[    0.000000] ACPI: Reserving IVRS table memory at [mem 0x9a0d3000-0x9a0d30cf]
[    0.000000] ACPI: Reserving SSDT table memory at [mem 0x9a0cb000-0x9a0d22af]
[    0.000000] ACPI: Reserving SSDT table memory at [mem 0x9a0c7000-0x9a0cad73]
[    0.000000] ACPI: Reserving SSDT table memory at [mem 0x9a0c6000-0x9a0c61ac]
[    0.000000] ACPI: Reserving FIDT table memory at [mem 0x9a0be000-0x9a0be09b]
[    0.000000] ACPI: Reserving MCFG table memory at [mem 0x9a0bd000-0x9a0bd03b]
[    0.000000] ACPI: Reserving HPET table memory at [mem 0x9a0bc000-0x9a0bc037]
[    0.000000] ACPI: Reserving FPDT table memory at [mem 0x9a0bb000-0x9a0bb043]
[    0.000000] ACPI: Reserving VFCT table memory at [mem 0x9a0ad000-0x9a0ba883]
[    0.000000] ACPI: Reserving SSDT table memory at [mem 0x9a0a9000-0x9a0ace87]
[    0.000000] ACPI: Reserving CRAT table memory at [mem 0x9a0a8000-0x9a0a8b67]
[    0.000000] ACPI: Reserving CDIT table memory at [mem 0x9a0a7000-0x9a0a7028]
[    0.000000] ACPI: Reserving SSDT table memory at [mem 0x9a0a5000-0x9a0a6485]
[    0.000000] ACPI: Reserving SSDT table memory at [mem 0x9a0a3000-0x9a0a44fc]
[    0.000000] ACPI: Reserving SSDT table memory at [mem 0x9a09f000-0x9a0a29f6]
[    0.000000] ACPI: Reserving WSMT table memory at [mem 0x9a09e000-0x9a09e027]
[    0.000000] ACPI: Reserving APIC table memory at [mem 0x9a09d000-0x9a09d15d]
[    0.000000] ACPI: Reserving SSDT table memory at [mem 0x9a0c4000-0x9a0c48a3]
[    0.000000] ACPI: Reserving SSDT table memory at [mem 0x9a0c2000-0x9a0c347e]
[    0.000000] ACPI: Reserving SSDT table memory at [mem 0x9a0c1000-0x9a0c10be]
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000083e2fffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x83e2fe000-0x83e2fffff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000083e2fffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x0000000009c3efff]
[    0.000000]   node   0: [mem 0x000000000a000000-0x000000000a1fffff]
[    0.000000]   node   0: [mem 0x000000000a20d000-0x000000000affffff]
[    0.000000]   node   0: [mem 0x000000000b020000-0x000000007a076fff]
[    0.000000]   node   0: [mem 0x000000007a078000-0x000000007a098fff]
[    0.000000]   node   0: [mem 0x000000007a09a000-0x000000009754cfff]
[    0.000000]   node   0: [mem 0x000000009cdff000-0x000000009dffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000083e2fffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000083e2fffff]
[    0.000000] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.000000] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.000000] On node 0, zone DMA32: 961 pages in unavailable ranges
[    0.000000] On node 0, zone DMA32: 13 pages in unavailable ranges
[    0.000000] On node 0, zone DMA32: 32 pages in unavailable ranges
[    0.000000] On node 0, zone DMA32: 1 pages in unavailable ranges
[    0.000000] On node 0, zone DMA32: 1 pages in unavailable ranges
[    0.000000] On node 0, zone DMA32: 22706 pages in unavailable ranges
[    0.000000] On node 0, zone Normal: 8192 pages in unavailable ranges
[    0.000000] On node 0, zone Normal: 7424 pages in unavailable ranges
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 13, version 33, address 0xfec00000, GSI 0-23
[    0.000000] IOAPIC[1]: apic_id 14, version 33, address 0xfec01000, GSI 24-55
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    0.000000] smpboot: 32 Processors exceeds NR_CPUS limit of 16
[    0.000000] smpboot: Allowing 16 CPUs, 4 hotplug CPUs
[    0.000000] [mem 0xa0000000-0xefffffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.000000] setup_percpu: NR_CPUS:16 nr_cpumask_bits:16 nr_cpu_ids:16 nr_node_ids:1
[    0.000000] percpu: Embedded 44 pages/cpu s139880 r8192 d32152 u262144
[    0.000000] Fallback order for Node 0: 0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 8089540
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: ro root=UUID=c6cf971d-5412-4826-851d-5677ad7997c0 thunderbolt.dyndbg pcie_port_pm=off console=ttyS0,115200 console=tty0 nogpu initrd=\initrd.img-5.19.0+
[    0.000000] Unknown kernel command line parameters "nogpu", will be passed to user space.
[    0.000000] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.000000] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 32128216K/32872436K available (8192K kernel code, 2309K rwdata, 1868K rodata, 952K init, 944K bss, 743964K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.000000] Dynamic Preempt: voluntary
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu: 	RCU event tracing is enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.000000] NR_IRQS: 4352, nr_irqs: 1096, preallocated irqs: 16
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] Console: colour dummy device 80x25
[    0.000000] printk: console [tty0] enabled
[    0.000000] printk: console [ttyS0] enabled
[    0.000000] ACPI: Core revision 20220331
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.000000] APIC: Switch to symmetric I/O mode setup
[    0.000000] Switched APIC routing to physical flat.
[    0.010000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.070000] tsc: PIT calibration matches HPET. 1 loops
[    0.070000] tsc: Detected 3900.162 MHz processor
[    0.000002] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x706fe8311dd, max_idle_ns: 881591200866 ns
[    0.010494] Calibrating delay loop (skipped), value calculated using timer frequency.. 7800.32 BogoMIPS (lpj=39001620)
[    0.020493] pid_max: default: 32768 minimum: 301
[    0.026329] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.030523] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.040576] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.047092] LVT offset 1 assigned for vector 0xf9
[    0.050555] LVT offset 2 assigned for vector 0xf4
[    0.055258] process: using mwait in idle threads
[    0.060493] Last level iTLB entries: 4KB 512, 2MB 512, 4MB 256
[    0.066307] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 1GB 0
[    0.070494] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.080493] Spectre V2 : Kernel not compiled with retpoline; no mitigation available!
[    0.080494] Spectre V2 : Vulnerable
[    0.093975] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.100493] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.110493] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.118899] Spectre V2 : User space: Mitigation: STIBP always-on protection
[    0.120493] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.130654] Freeing SMP alternatives memory: 24K
[    0.259642] smpboot: CPU0: AMD Ryzen 5 5600G with Radeon Graphics (family: 0x19, model: 0x50, stepping: 0x0)
[    0.260492] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
[    0.260493] ... version:                0
[    0.270493] ... bit width:              48
[    0.274578] ... generic registers:      6
[    0.278571] ... value mask:             0000ffffffffffff
[    0.280493] ... max period:             00007fffffffffff
[    0.285789] ... fixed-purpose events:   0
[    0.290493] ... event mask:             000000000000003f
[    0.295822] rcu: Hierarchical SRCU implementation.
[    0.300493] rcu: 	Max phase no-delay instances is 1000.
[    0.305908] smp: Bringing up secondary CPUs ...
[    0.310550] x86: Booting SMP configuration:
[    0.314719] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6
[    0.330523] Spectre V2 : Update user space SMT mitigation: STIBP always-on
[    0.340567]   #7  #8  #9 #10 #11
[    0.352640] smp: Brought up 1 node, 12 CPUs
[    0.360494] smpboot: Max logical packages: 3
[    0.364752] smpboot: Total of 12 processors activated (93603.88 BogoMIPS)
[    0.371121] devtmpfs: initialized
[    0.373879] ACPI: PM: Registering ACPI NVS region [mem 0x0a200000-0x0a20cfff] (53248 bytes)
[    0.380494] ACPI: PM: Registering ACPI NVS region [mem 0x9a0de000-0x9bb5bfff] (27779072 bytes)
[    0.390717] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.400495] futex hash table entries: 4096 (order: 6, 262144 bytes, linear)
[    0.410708] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.416660] thermal_sys: Registered thermal governor 'step_wise'
[    0.416661] thermal_sys: Registered thermal governor 'user_space'
[    0.420504] cpuidle: using governor ladder
[    0.430502] cpuidle: using governor menu
[    0.434418] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.440510] PCI: MMCONFIG for domain 0000 [bus 00-7f] at [mem 0xf0000000-0xf7ffffff] (base 0xf0000000)
[    0.450494] PCI: MMCONFIG at [mem 0xf0000000-0xf7ffffff] reserved in E820
[    0.457264] PCI: Using configuration type 1 for base access
[    0.460951] ACPI: Added _OSI(Module Device)
[    0.464686] ACPI: Added _OSI(Processor Device)
[    0.470493] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.475186] ACPI: Added _OSI(Processor Aggregator Device)
[    0.480493] ACPI: Added _OSI(Linux-Dell-Video)
[    0.484924] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.490493] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.504626] ACPI: 12 ACPI AML tables successfully acquired and loaded
[    0.511195] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.521914] ACPI: Interpreter enabled
[    0.524503] ACPI: PM: (supports S0 S3 S5)
[    0.528499] ACPI: Using IOAPIC for interrupt routing
[    0.530657] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.540493] PCI: Using E820 reservations for host bridge windows
[    0.546664] ACPI: Enabled 7 GPEs in block 00 to 1F
[    0.554327] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.560495] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.570547] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability LTR]
[    0.580498] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-7f] only partially covers this bridge
[    0.590609] PCI host bridge to bus 0000:00
[    0.594692] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.600493] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.610493] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.617250] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.620493] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000dffff window]
[    0.630493] pci_bus 0000:00: root bus resource [mem 0xa0000000-0xefffffff window]
[    0.637941] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.640502] pci 0000:00:00.0: [1022:1630] type 00 class 0x060000
[    0.650547] pci 0000:00:00.2: [1022:1631] type 00 class 0x080600
[    0.656594] pci 0000:00:01.0: [1022:1632] type 00 class 0x060000
[    0.660533] pci 0000:00:02.0: [1022:1632] type 00 class 0x060000
[    0.666549] pci 0000:00:02.1: [1022:1634] type 01 class 0x060400
[    0.670513] pci 0000:00:02.1: enabling Extended Tags
[    0.675496] pci 0000:00:02.1: PME# supported from D0 D3hot D3cold
[    0.680538] pci 0000:00:02.2: [1022:1634] type 01 class 0x060400
[    0.690541] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
[    0.696651] pci 0000:00:08.0: [1022:1632] type 00 class 0x060000
[    0.700526] pci 0000:00:08.1: [1022:1635] type 01 class 0x060400
[    0.706523] pci 0000:00:08.1: enabling Extended Tags
[    0.710518] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.720549] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
[    0.726623] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
[    0.730592] pci 0000:00:18.0: [1022:166a] type 00 class 0x060000
[    0.736594] pci 0000:00:18.1: [1022:166b] type 00 class 0x060000
[    0.740508] pci 0000:00:18.2: [1022:166c] type 00 class 0x060000
[    0.750509] pci 0000:00:18.3: [1022:166d] type 00 class 0x060000
[    0.756504] pci 0000:00:18.4: [1022:166e] type 00 class 0x060000
[    0.760508] pci 0000:00:18.5: [1022:166f] type 00 class 0x060000
[    0.766505] pci 0000:00:18.6: [1022:1670] type 00 class 0x060000
[    0.770509] pci 0000:00:18.7: [1022:1671] type 00 class 0x060000
[    0.780553] pci 0000:01:00.0: [1022:43ee] type 00 class 0x0c0330
[    0.786553] pci 0000:01:00.0: reg 0x10: [mem 0xef7a0000-0xef7a7fff 64bit]
[    0.790528] pci 0000:01:00.0: enabling Extended Tags
[    0.795525] pci 0000:01:00.0: PME# supported from D3hot D3cold
[    0.800557] pci 0000:01:00.1: [1022:43eb] type 00 class 0x010601
[    0.810534] pci 0000:01:00.1: reg 0x24: [mem 0xef780000-0xef79ffff]
[    0.816783] pci 0000:01:00.1: reg 0x30: [mem 0xef700000-0xef77ffff pref]
[    0.820498] pci 0000:01:00.1: enabling Extended Tags
[    0.825481] pci 0000:01:00.1: PME# supported from D3hot D3cold
[    0.830540] pci 0000:01:00.2: [1022:43e9] type 01 class 0x060400
[    0.840531] pci 0000:01:00.2: enabling Extended Tags
[    0.845520] pci 0000:01:00.2: PME# supported from D3hot D3cold
[    0.850544] pci 0000:00:02.1: PCI bridge to [bus 01-51]
[    0.855749] pci 0000:00:02.1:   bridge window [io  0xf000-0xffff]
[    0.860494] pci 0000:00:02.1:   bridge window [mem 0xdf000000-0xef7fffff]
[    0.867260] pci 0000:00:02.1:   bridge window [mem 0xa0000000-0xb1ffffff 64bit pref]
[    0.870553] pci 0000:02:00.0: [1022:43ea] type 01 class 0x060400
[    0.880534] pci 0000:02:00.0: enabling Extended Tags
[    0.885529] pci 0000:02:00.0: PME# supported from D3hot D3cold
[    0.890549] pci 0000:02:04.0: [1022:43ea] type 01 class 0x060400
[    0.896574] pci 0000:02:04.0: enabling Extended Tags
[    0.900543] pci 0000:02:04.0: PME# supported from D3hot D3cold
[    0.910547] pci 0000:02:08.0: [1022:43ea] type 01 class 0x060400
[    0.916576] pci 0000:02:08.0: enabling Extended Tags
[    0.920543] pci 0000:02:08.0: PME# supported from D3hot D3cold
[    0.926406] pci 0000:02:09.0: [1022:43ea] type 01 class 0x060400
[    0.930535] pci 0000:02:09.0: enabling Extended Tags
[    0.935536] pci 0000:02:09.0: PME# supported from D3hot D3cold
[    0.940552] pci 0000:01:00.2: PCI bridge to [bus 02-51]
[    0.945758] pci 0000:01:00.2:   bridge window [io  0xf000-0xffff]
[    0.950495] pci 0000:01:00.2:   bridge window [mem 0xdf000000-0xef6fffff]
[    0.960496] pci 0000:01:00.2:   bridge window [mem 0xa0000000-0xb1ffffff 64bit pref]
[    0.970550] pci 0000:03:00.0: [8086:15ea] type 01 class 0x060400
[    0.976598] pci 0000:03:00.0: enabling Extended Tags
[    0.980624] pci 0000:03:00.0: supports D1 D2
[    0.984882] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.990583] pci 0000:02:00.0: PCI bridge to [bus 03-4a]
[    0.995796] pci 0000:02:00.0:   bridge window [mem 0xdf000000-0xef1fffff]
[    1.000497] pci 0000:02:00.0:   bridge window [mem 0xa0000000-0xb1ffffff 64bit pref]
[    1.010565] pci 0000:04:00.0: [8086:15ea] type 01 class 0x060400
[    1.016620] pci 0000:04:00.0: enabling Extended Tags
[    1.020627] pci 0000:04:00.0: supports D1 D2
[    1.024884] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.030589] pci 0000:04:01.0: [8086:15ea] type 01 class 0x060400
[    1.040562] pci 0000:04:01.0: enabling Extended Tags
[    1.045638] pci 0000:04:01.0: supports D1 D2
[    1.049894] pci 0000:04:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.050588] pci 0000:04:02.0: [8086:15ea] type 01 class 0x060400
[    1.060562] pci 0000:04:02.0: enabling Extended Tags
[    1.065646] pci 0000:04:02.0: supports D1 D2
[    1.070493] pci 0000:04:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.077184] pci 0000:04:04.0: [8086:15ea] type 01 class 0x060400
[    1.080562] pci 0000:04:04.0: enabling Extended Tags
[    1.085643] pci 0000:04:04.0: supports D1 D2
[    1.090493] pci 0000:04:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.100600] pci 0000:03:00.0: PCI bridge to [bus 04-4a]
[    1.105815] pci 0000:03:00.0:   bridge window [mem 0xdf000000-0xef1fffff]
[    1.110499] pci 0000:03:00.0:   bridge window [mem 0xa0000000-0xb1ffffff 64bit pref]
[    1.120572] pci 0000:05:00.0: [8086:15eb] type 00 class 0x088000
[    1.126580] pci 0000:05:00.0: reg 0x10: [mem 0xef100000-0xef13ffff]
[    1.130502] pci 0000:05:00.0: reg 0x14: [mem 0xef140000-0xef140fff]
[    1.136805] pci 0000:05:00.0: enabling Extended Tags
[    1.140625] pci 0000:05:00.0: supports D1 D2
[    1.144884] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.150604] pci 0000:04:00.0: PCI bridge to [bus 05]
[    1.155564] pci 0000:04:00.0:   bridge window [mem 0xef100000-0xef1fffff]
[    1.160548] pci 0000:04:01.0: PCI bridge to [bus 06-27]
[    1.170502] pci 0000:04:01.0:   bridge window [mem 0xe7000000-0xeeffffff]
[    1.177265] pci 0000:04:01.0:   bridge window [mem 0xb0000000-0xb1ffffff 64bit pref]
[    1.180577] pci 0000:28:00.0: [8086:15ec] type 00 class 0x0c0330
[    1.190519] pci 0000:28:00.0: reg 0x10: [mem 0xef000000-0xef00ffff]
[    1.196854] pci 0000:28:00.0: enabling Extended Tags
[    1.200642] pci 0000:28:00.0: supports D1 D2
[    1.204900] pci 0000:28:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.210552] pci 0000:28:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:04:02.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
[    1.220549] pci 0000:04:02.0: PCI bridge to [bus 28]
[    1.230502] pci 0000:04:02.0:   bridge window [mem 0xef000000-0xef0fffff]
[    1.240548] pci 0000:04:04.0: PCI bridge to [bus 29-4a]
[    1.245763] pci 0000:04:04.0:   bridge window [mem 0xdf000000-0xe6ffffff]
[    1.250499] pci 0000:04:04.0:   bridge window [mem 0xa0000000-0xa1ffffff 64bit pref]
[    1.260578] pci 0000:4b:00.0: [2646:2262] type 00 class 0x010802
[    1.266591] pci 0000:4b:00.0: reg 0x10: [mem 0xef600000-0xef603fff 64bit]
[    1.270712] pci 0000:02:04.0: PCI bridge to [bus 4b]
[    1.275668] pci 0000:02:04.0:   bridge window [mem 0xef600000-0xef6fffff]
[    1.280558] pci 0000:4c:00.0: [1b21:1806] type 01 class 0x060400
[    1.290562] pci 0000:4c:00.0: enabling Extended Tags
[    1.295622] pci 0000:4c:00.0: PME# supported from D0 D3hot D3cold
[    1.300533] pci 0000:4c:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x1 link at 0000:02:08.0 (capable of 15.752 Gb/s with 8.0 GT/s PCIe x2 link)
[    1.310543] pci 0000:02:08.0: PCI bridge to [bus 4c-50]
[    1.320497] pci 0000:02:08.0:   bridge window [io  0xf000-0xffff]
[    1.326567] pci 0000:02:08.0:   bridge window [mem 0xef500000-0xef5fffff]
[    1.330558] pci 0000:4d:00.0: [1b21:1806] type 01 class 0x060400
[    1.340564] pci 0000:4d:00.0: enabling Extended Tags
[    1.345618] pci 0000:4d:00.0: PME# supported from D0 D3hot D3cold
[    1.350588] pci 0000:4d:06.0: [1b21:1806] type 01 class 0x060400
[    1.356647] pci 0000:4d:06.0: enabling Extended Tags
[    1.360600] pci 0000:4d:06.0: PME# supported from D0 D3hot D3cold
[    1.370579] pci 0000:4d:0e.0: [1b21:1806] type 01 class 0x060400
[    1.376630] pci 0000:4d:0e.0: enabling Extended Tags
[    1.380600] pci 0000:4d:0e.0: PME# supported from D0 D3hot D3cold
[    1.386754] pci 0000:4c:00.0: PCI bridge to [bus 4d-50]
[    1.390499] pci 0000:4c:00.0:   bridge window [io  0xf000-0xffff]
[    1.396569] pci 0000:4c:00.0:   bridge window [mem 0xef500000-0xef5fffff]
[    1.400568] pci 0000:4e:00.0: [10ec:8125] type 00 class 0x020000
[    1.410522] pci 0000:4e:00.0: reg 0x10: [io  0xf000-0xf0ff]
[    1.416117] pci 0000:4e:00.0: reg 0x18: [mem 0xef500000-0xef50ffff 64bit]
[    1.420517] pci 0000:4e:00.0: reg 0x20: [mem 0xef510000-0xef513fff 64bit]
[    1.430678] pci 0000:4e:00.0: supports D1 D2
[    1.434935] pci 0000:4e:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.440642] pci 0000:4d:00.0: PCI bridge to [bus 4e]
[    1.445598] pci 0000:4d:00.0:   bridge window [io  0xf000-0xffff]
[    1.450496] pci 0000:4d:00.0:   bridge window [mem 0xef500000-0xef5fffff]
[    1.460543] pci 0000:4d:06.0: PCI bridge to [bus 4f]
[    1.465547] pci 0000:4d:0e.0: PCI bridge to [bus 50]
[    1.470601] pci 0000:51:00.0: [8086:15f3] type 00 class 0x020000
[    1.476608] pci 0000:51:00.0: reg 0x10: [mem 0xef300000-0xef3fffff]
[    1.480527] pci 0000:51:00.0: reg 0x1c: [mem 0xef400000-0xef403fff]
[    1.486917] pci 0000:51:00.0: PME# supported from D0 D3hot D3cold
[    1.490588] pci 0000:02:09.0: PCI bridge to [bus 51]
[    1.500498] pci 0000:02:09.0:   bridge window [mem 0xef300000-0xef4fffff]
[    1.507338] pci 0000:52:00.0: [c0a9:540a] type 00 class 0x010802
[    1.510535] pci 0000:52:00.0: reg 0x10: [mem 0xefd00000-0xefd03fff 64bit]
[    1.520663] pci 0000:00:02.2: PCI bridge to [bus 52]
[    1.525613] pci 0000:00:02.2:   bridge window [mem 0xefd00000-0xefdfffff]
[    1.530530] pci 0000:53:00.0: [1002:1638] type 00 class 0x030000
[    1.536525] pci 0000:53:00.0: reg 0x10: [mem 0xc0000000-0xcfffffff 64bit pref]
[    1.540498] pci 0000:53:00.0: reg 0x18: [mem 0xd0000000-0xd01fffff 64bit pref]
[    1.550496] pci 0000:53:00.0: reg 0x20: [io  0xe000-0xe0ff]
[    1.556052] pci 0000:53:00.0: reg 0x24: [mem 0xefc00000-0xefc7ffff]
[    1.560499] pci 0000:53:00.0: enabling Extended Tags
[    1.565453] pci 0000:53:00.0: BAR 0: assigned to efifb
[    1.570527] pci 0000:53:00.0: PME# supported from D1 D2 D3hot D3cold
[    1.580505] pci 0000:53:00.0: 126.016 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x16 link at 0000:00:08.1 (capable of 252.048 Gb/s with 16.0 GT/s PCIe x16 link)
[    1.590521] pci 0000:53:00.1: [1002:1637] type 00 class 0x040300
[    1.600498] pci 0000:53:00.1: reg 0x10: [mem 0xefc88000-0xefc8bfff]
[    1.606756] pci 0000:53:00.1: enabling Extended Tags
[    1.610517] pci 0000:53:00.1: PME# supported from D1 D2 D3hot D3cold
[    1.616884] pci 0000:53:00.2: [1022:15df] type 00 class 0x108000
[    1.620503] pci 0000:53:00.2: reg 0x18: [mem 0xefb00000-0xefbfffff]
[    1.630501] pci 0000:53:00.2: reg 0x24: [mem 0xefc8c000-0xefc8dfff]
[    1.636745] pci 0000:53:00.2: enabling Extended Tags
[    1.640550] pci 0000:53:00.3: [1022:1639] type 00 class 0x0c0330
[    1.646539] pci 0000:53:00.3: reg 0x10: [mem 0xefa00000-0xefafffff 64bit]
[    1.650513] pci 0000:53:00.3: enabling Extended Tags
[    1.660519] pci 0000:53:00.3: PME# supported from D0 D3hot D3cold
[    1.666626] pci 0000:53:00.4: [1022:1639] type 00 class 0x0c0330
[    1.670501] pci 0000:53:00.4: reg 0x10: [mem 0xef900000-0xef9fffff 64bit]
[    1.677285] pci 0000:53:00.4: enabling Extended Tags
[    1.680519] pci 0000:53:00.4: PME# supported from D0 D3hot D3cold
[    1.690529] pci 0000:53:00.6: [1022:15e3] type 00 class 0x040300
[    1.696521] pci 0000:53:00.6: reg 0x10: [mem 0xefc80000-0xefc87fff]
[    1.700511] pci 0000:53:00.6: enabling Extended Tags
[    1.705485] pci 0000:53:00.6: PME# supported from D0 D3hot D3cold
[    1.710541] pci 0000:00:08.1: PCI bridge to [bus 53]
[    1.715489] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
[    1.720494] pci 0000:00:08.1:   bridge window [mem 0xef900000-0xefcfffff]
[    1.730494] pci 0000:00:08.1:   bridge window [mem 0xc0000000-0xd01fffff 64bit pref]
[    1.738466] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    1.740518] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    1.750513] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    1.756437] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    1.760516] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    1.766431] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    1.770512] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    1.780512] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    1.786753] SCSI subsystem initialized
[    1.790518] Registered efivars operations
[    1.794561] PCI: Using ACPI for IRQ routing
[    1.804855] pci 0000:53:00.0: vgaarb: setting as boot VGA device
[    1.806479] pci 0000:53:00.0: vgaarb: bridge control possible
[    1.810492] pci 0000:53:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    1.810494] vgaarb: loaded
[    1.813203] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    1.820494] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    1.828336] clocksource: Switched to clocksource tsc-early
[    1.828336] VFS: Disk quotas dquot_6.6.0
[    1.829891] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.836758] pnp: PnP ACPI init
[    1.839839] system 00:00: [mem 0xf0000000-0xf7ffffff] has been reserved
[    1.846453] system 00:01: [mem 0x840000000-0x85fffffff window] has been reserved
[    1.853917] system 00:03: [io  0x0a00-0x0a2f] has been reserved
[    1.859819] system 00:03: [io  0x0a30-0x0a3f] has been reserved
[    1.865720] system 00:03: [io  0x0a40-0x0a4f] has been reserved
[    1.871623] system 00:03: [mem 0xfe000000-0xfe00ffff] has been reserved
[    1.878455] system 00:05: [io  0x04d0-0x04d1] has been reserved
[    1.884356] system 00:05: [io  0x040b] has been reserved
[    1.889652] system 00:05: [io  0x04d6] has been reserved
[    1.894941] system 00:05: [io  0x0c00-0x0c01] has been reserved
[    1.900842] system 00:05: [io  0x0c14] has been reserved
[    1.906137] system 00:05: [io  0x0c50-0x0c51] has been reserved
[    1.912031] system 00:05: [io  0x0c52] has been reserved
[    1.917326] system 00:05: [io  0x0c6c] has been reserved
[    1.922622] system 00:05: [io  0x0c6f] has been reserved
[    1.927910] system 00:05: [io  0x0cd8-0x0cdf] has been reserved
[    1.933805] system 00:05: [io  0x0800-0x089f] has been reserved
[    1.939705] system 00:05: [io  0x0b00-0x0b0f] has been reserved
[    1.945600] system 00:05: [io  0x0b20-0x0b3f] has been reserved
[    1.951500] system 00:05: [io  0x0900-0x090f] has been reserved
[    1.957394] system 00:05: [io  0x0910-0x091f] has been reserved
[    1.963296] system 00:05: [mem 0xfec00000-0xfec00fff] could not be reserved
[    1.970231] system 00:05: [mem 0xfec01000-0xfec01fff] could not be reserved
[    1.977164] system 00:05: [mem 0xfedc0000-0xfedc0fff] has been reserved
[    1.983756] system 00:05: [mem 0xfee00000-0xfee00fff] has been reserved
[    1.990345] system 00:05: [mem 0xfed80000-0xfed8ffff] could not be reserved
[    1.997275] system 00:05: [mem 0xfec10000-0xfec10fff] has been reserved
[    2.003874] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    2.010735] pnp: PnP ACPI: found 6 devices
[    2.020326] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    2.029179] NET: Registered PF_INET protocol family
[    2.034147] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    2.043518] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
[    2.052199] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    2.059916] TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    2.068102] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    2.075522] TCP: Hash tables configured (established 262144 bind 65536)
[    2.082120] UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    2.088999] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    2.096328] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    2.101970] pci 0000:04:01.0: bridge window [io  0x1000-0x0fff] to [bus 06-27] add_size 1000
[    2.110370] pci 0000:04:04.0: bridge window [io  0x1000-0x0fff] to [bus 29-4a] add_size 1000
[    2.118777] pci 0000:03:00.0: bridge window [io  0x1000-0x0fff] to [bus 04-4a] add_size 2000
[    2.127178] pci 0000:02:00.0: bridge window [io  0x1000-0x0fff] to [bus 03-4a] add_size 2000
[    2.135589] pci 0000:02:00.0: BAR 7: no space for [io  size 0x2000]
[    2.141832] pci 0000:02:00.0: BAR 7: failed to assign [io  size 0x2000]
[    2.148425] pci 0000:02:00.0: BAR 7: no space for [io  size 0x2000]
[    2.154672] pci 0000:02:00.0: BAR 7: failed to assign [io  size 0x2000]
[    2.161265] pci 0000:03:00.0: BAR 7: no space for [io  size 0x2000]
[    2.167509] pci 0000:03:00.0: BAR 7: failed to assign [io  size 0x2000]
[    2.174093] pci 0000:03:00.0: BAR 7: no space for [io  size 0x2000]
[    2.180342] pci 0000:03:00.0: BAR 7: failed to assign [io  size 0x2000]
[    2.186935] pci 0000:04:01.0: BAR 7: no space for [io  size 0x1000]
[    2.193181] pci 0000:04:01.0: BAR 7: failed to assign [io  size 0x1000]
[    2.199773] pci 0000:04:04.0: BAR 7: no space for [io  size 0x1000]
[    2.206019] pci 0000:04:04.0: BAR 7: failed to assign [io  size 0x1000]
[    2.212613] pci 0000:04:04.0: BAR 7: no space for [io  size 0x1000]
[    2.218860] pci 0000:04:04.0: BAR 7: failed to assign [io  size 0x1000]
[    2.225452] pci 0000:04:01.0: BAR 7: no space for [io  size 0x1000]
[    2.231700] pci 0000:04:01.0: BAR 7: failed to assign [io  size 0x1000]
[    2.238291] pci 0000:04:00.0: PCI bridge to [bus 05]
[    2.243248] pci 0000:04:00.0:   bridge window [mem 0xef100000-0xef1fffff]
[    2.250016] pci 0000:04:01.0: PCI bridge to [bus 06-27]
[    2.255223] pci 0000:04:01.0:   bridge window [mem 0xe7000000-0xeeffffff]
[    2.261985] pci 0000:04:01.0:   bridge window [mem 0xb0000000-0xb1ffffff 64bit pref]
[    2.269706] pci 0000:04:02.0: PCI bridge to [bus 28]
[    2.274654] pci 0000:04:02.0:   bridge window [mem 0xef000000-0xef0fffff]
[    2.281427] pci 0000:04:04.0: PCI bridge to [bus 29-4a]
[    2.286640] pci 0000:04:04.0:   bridge window [mem 0xdf000000-0xe6ffffff]
[    2.293403] pci 0000:04:04.0:   bridge window [mem 0xa0000000-0xa1ffffff 64bit pref]
[    2.301121] pci 0000:03:00.0: PCI bridge to [bus 04-4a]
[    2.306331] pci 0000:03:00.0:   bridge window [mem 0xdf000000-0xef1fffff]
[    2.313094] pci 0000:03:00.0:   bridge window [mem 0xa0000000-0xb1ffffff 64bit pref]
[    2.320817] pci 0000:02:00.0: PCI bridge to [bus 03-4a]
[    2.326020] pci 0000:02:00.0:   bridge window [mem 0xdf000000-0xef1fffff]
[    2.332786] pci 0000:02:00.0:   bridge window [mem 0xa0000000-0xb1ffffff 64bit pref]
[    2.340507] pci 0000:02:04.0: PCI bridge to [bus 4b]
[    2.345452] pci 0000:02:04.0:   bridge window [mem 0xef600000-0xef6fffff]
[    2.352223] pci 0000:4d:00.0: PCI bridge to [bus 4e]
[    2.357170] pci 0000:4d:00.0:   bridge window [io  0xf000-0xffff]
[    2.363248] pci 0000:4d:00.0:   bridge window [mem 0xef500000-0xef5fffff]
[    2.370020] pci 0000:4d:06.0: PCI bridge to [bus 4f]
[    2.374983] pci 0000:4d:0e.0: PCI bridge to [bus 50]
[    2.379942] pci 0000:4c:00.0: PCI bridge to [bus 4d-50]
[    2.385147] pci 0000:4c:00.0:   bridge window [io  0xf000-0xffff]
[    2.391224] pci 0000:4c:00.0:   bridge window [mem 0xef500000-0xef5fffff]
[    2.397992] pci 0000:02:08.0: PCI bridge to [bus 4c-50]
[    2.403198] pci 0000:02:08.0:   bridge window [io  0xf000-0xffff]
[    2.409271] pci 0000:02:08.0:   bridge window [mem 0xef500000-0xef5fffff]
[    2.416043] pci 0000:02:09.0: PCI bridge to [bus 51]
[    2.420990] pci 0000:02:09.0:   bridge window [mem 0xef300000-0xef4fffff]
[    2.427758] pci 0000:01:00.2: PCI bridge to [bus 02-51]
[    2.432964] pci 0000:01:00.2:   bridge window [io  0xf000-0xffff]
[    2.439037] pci 0000:01:00.2:   bridge window [mem 0xdf000000-0xef6fffff]
[    2.445804] pci 0000:01:00.2:   bridge window [mem 0xa0000000-0xb1ffffff 64bit pref]
[    2.453523] pci 0000:00:02.1: PCI bridge to [bus 01-51]
[    2.458728] pci 0000:00:02.1:   bridge window [io  0xf000-0xffff]
[    2.464804] pci 0000:00:02.1:   bridge window [mem 0xdf000000-0xef7fffff]
[    2.471567] pci 0000:00:02.1:   bridge window [mem 0xa0000000-0xb1ffffff 64bit pref]
[    2.479284] pci 0000:00:02.2: PCI bridge to [bus 52]
[    2.484234] pci 0000:00:02.2:   bridge window [mem 0xefd00000-0xefdfffff]
[    2.491002] pci 0000:00:08.1: PCI bridge to [bus 53]
[    2.495950] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
[    2.502025] pci 0000:00:08.1:   bridge window [mem 0xef900000-0xefcfffff]
[    2.508790] pci 0000:00:08.1:   bridge window [mem 0xc0000000-0xd01fffff 64bit pref]
[    2.516507] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    2.522668] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    2.528827] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    2.534982] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    2.541142] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff window]
[    2.547992] pci_bus 0000:00: resource 9 [mem 0xa0000000-0xefffffff window]
[    2.554837] pci_bus 0000:01: resource 0 [io  0xf000-0xffff]
[    2.560392] pci_bus 0000:01: resource 1 [mem 0xdf000000-0xef7fffff]
[    2.566633] pci_bus 0000:01: resource 2 [mem 0xa0000000-0xb1ffffff 64bit pref]
[    2.573829] pci_bus 0000:02: resource 0 [io  0xf000-0xffff]
[    2.579387] pci_bus 0000:02: resource 1 [mem 0xdf000000-0xef6fffff]
[    2.585634] pci_bus 0000:02: resource 2 [mem 0xa0000000-0xb1ffffff 64bit pref]
[    2.592830] pci_bus 0000:03: resource 1 [mem 0xdf000000-0xef1fffff]
[    2.599068] pci_bus 0000:03: resource 2 [mem 0xa0000000-0xb1ffffff 64bit pref]
[    2.606257] pci_bus 0000:04: resource 1 [mem 0xdf000000-0xef1fffff]
[    2.612495] pci_bus 0000:04: resource 2 [mem 0xa0000000-0xb1ffffff 64bit pref]
[    2.619684] pci_bus 0000:05: resource 1 [mem 0xef100000-0xef1fffff]
[    2.625934] pci_bus 0000:06: resource 1 [mem 0xe7000000-0xeeffffff]
[    2.632179] pci_bus 0000:06: resource 2 [mem 0xb0000000-0xb1ffffff 64bit pref]
[    2.639377] pci_bus 0000:28: resource 1 [mem 0xef000000-0xef0fffff]
[    2.645626] pci_bus 0000:29: resource 1 [mem 0xdf000000-0xe6ffffff]
[    2.651874] pci_bus 0000:29: resource 2 [mem 0xa0000000-0xa1ffffff 64bit pref]
[    2.659070] pci_bus 0000:4b: resource 1 [mem 0xef600000-0xef6fffff]
[    2.665311] pci_bus 0000:4c: resource 0 [io  0xf000-0xffff]
[    2.670867] pci_bus 0000:4c: resource 1 [mem 0xef500000-0xef5fffff]
[    2.677106] pci_bus 0000:4d: resource 0 [io  0xf000-0xffff]
[    2.682653] pci_bus 0000:4d: resource 1 [mem 0xef500000-0xef5fffff]
[    2.688891] pci_bus 0000:4e: resource 0 [io  0xf000-0xffff]
[    2.694440] pci_bus 0000:4e: resource 1 [mem 0xef500000-0xef5fffff]
[    2.700687] pci_bus 0000:51: resource 1 [mem 0xef300000-0xef4fffff]
[    2.706934] pci_bus 0000:52: resource 1 [mem 0xefd00000-0xefdfffff]
[    2.713181] pci_bus 0000:53: resource 0 [io  0xe000-0xefff]
[    2.718736] pci_bus 0000:53: resource 1 [mem 0xef900000-0xefcfffff]
[    2.724984] pci_bus 0000:53: resource 2 [mem 0xc0000000-0xd01fffff 64bit pref]
[    2.732418] pci 0000:53:00.1: D0 power state depends on 0000:53:00.0
[    2.738752] pci 0000:53:00.3: extending delay after power-on from D3hot to 20 msec
[    2.746369] pci 0000:53:00.4: extending delay after power-on from D3hot to 20 msec
[    2.753935] PCI: CLS 64 bytes, default 64
[    2.757934] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    2.757990] Trying to unpack rootfs image as initramfs...
[    2.764355] software IO TLB: mapped [mem 0x000000008d000000-0x0000000091000000] (64MB)
[    2.777623] LVT offset 0 assigned for vector 0x400
[    2.782456] perf: AMD IBS detected (0x000003ff)
[    2.787172] workingset: timestamp_bits=60 max_order=23 bucket_order=0
[    2.796064] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    2.803436] io scheduler mq-deadline registered
[    2.808079] pcieport 0000:00:02.1: PME: Signaling with IRQ 27
[    2.813904] pcieport 0000:00:02.2: PME: Signaling with IRQ 28
[    2.819709] pcieport 0000:00:08.1: PME: Signaling with IRQ 29
[    2.826376] pcieport 0000:04:01.0: pciehp: Slot #1 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    2.840228] pcieport 0000:04:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    2.854565] Estimated ratio of average max frequency by base frequency (times 1024): 1098
[    2.862728] ACPI: \_SB_.PLTF.C000: Found 3 idle states
[    2.867898] ACPI: \_SB_.PLTF.C002: Found 3 idle states
[    2.874070] Freeing initrd memory: 14908K
[    2.878073] ACPI: \_SB_.PLTF.C004: Found 3 idle states
[    2.883260] ACPI: \_SB_.PLTF.C006: Found 3 idle states
[    2.888433] ACPI: \_SB_.PLTF.C008: Found 3 idle states
[    2.893625] ACPI: \_SB_.PLTF.C00A: Found 3 idle states
[    2.898788] ACPI: \_SB_.PLTF.C001: Found 3 idle states
[    2.903973] ACPI: \_SB_.PLTF.C003: Found 3 idle states
[    2.909167] ACPI: \_SB_.PLTF.C005: Found 3 idle states
[    2.914350] ACPI: \_SB_.PLTF.C007: Found 3 idle states
[    2.919534] ACPI: \_SB_.PLTF.C009: Found 3 idle states
[    2.924726] ACPI: \_SB_.PLTF.C00B: Found 3 idle states
[    2.938277] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    2.965236] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    2.974007] brd: module loaded
[    2.977200] nvme nvme0: pci function 0000:4b:00.0
[    2.981937] nvme nvme1: pci function 0000:52:00.0
[    2.986703] Intel(R) 2.5G Ethernet Linux Driver
[    2.991233] Copyright(c) 2018 Intel Corporation.
[    2.995907] igc 0000:51:00.0: PCIe PTM not supported by PCIe bus/controller
[    3.002887] nvme nvme0: missing or invalid SUBNQN field.
[    3.010839] nvme nvme0: 15/0/0 default/read/poll queues
[    3.020347]  nvme0n1: p1 p2 p3
[    3.085754] igc 0000:51:00.0: 4.000 Gb/s available PCIe bandwidth (5.0 GT/s PCIe x1 link)
[    3.091454] nvme nvme1: missing or invalid SUBNQN field.
[    3.093909] igc 0000:51:00.0 eth0: MAC: d8:5e:d3:86:cc:c8
[    3.132361] r8169 0000:4e:00.0 eth1: RTL8125B, d8:5e:d3:86:cc:c6, XID 641, IRQ 68
[    3.139824] r8169 0000:4e:00.0 eth1: jumbo features [frames: 9194 bytes, tx checksumming: ko]
[    3.148344] i8042: PNP: No PS/2 controller found.
[    3.151532] nvme nvme1: allocated 128 MiB host memory buffer.
[    3.153066] rtc_cmos 00:02: RTC can wake from S4
[    3.163556] rtc_cmos 00:02: registered as rtc0
[    3.168012] rtc_cmos 00:02: setting system clock to 2022-08-06T09:30:15 UTC (1659778215)
[    3.176083] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    3.184432] efifb: probing for efifb
[    3.188002] efifb: framebuffer at 0xc0000000, using 3072k, total 3072k
[    3.194505] efifb: mode is 1024x768x32, linelength=4096, pages=1
[    3.200490] efifb: scrolling: redraw
[    3.204061] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    3.210108] Console: switching to colour frame buffer device 128x48
[    3.216810] fb0: EFI VGA frame buffer device
[    3.221103] ccp 0000:53:00.2: enabling device (0000 -> 0002)
[    3.236929] ccp 0000:53:00.2: tee enabled
[    3.240932] ccp 0000:53:00.2: psp enabled
[    3.245782] microcode: CPU0: patch_level=0x0a50000d
[    3.250651] microcode: CPU1: patch_level=0x0a50000d
[    3.255822] microcode: CPU2: patch_level=0x0a50000d
[    3.260868] microcode: CPU3: patch_level=0x0a50000d
[    3.265751] microcode: CPU4: patch_level=0x0a50000d
[    3.270822] microcode: CPU5: patch_level=0x0a50000d
[    3.275705] microcode: CPU6: patch_level=0x0a50000d
[    3.280577] microcode: CPU7: patch_level=0x0a50000d
[    3.285825] microcode: CPU8: patch_level=0x0a50000d
[    3.290820] microcode: CPU9: patch_level=0x0a50000d
[    3.295705] microcode: CPU10: patch_level=0x0a50000d
[    3.299750] nvme nvme1: 8/0/0 default/read/poll queues
[    3.300674] microcode: CPU11: patch_level=0x0a50000d
[    3.310746] microcode: Microcode Update Driver: v2.2.
[    3.310748] IPI shorthand broadcast: enabled
[    3.315666] nvme nvme1: Ignoring bogus Namespace Identifiers
[    3.315801] sched_clock: Marking stable (3380000455, -69507036)->(3339218003, -28724584)
[    3.321573]  nvme1n1: p1 p3 p4 p5
[    3.334203] registered taskstats version 1
[    3.341987] Freeing unused kernel image (initmem) memory: 952K
[    3.490756] Write protecting the kernel read-only data: 12288k
[    3.497378] Freeing unused kernel image (text/rodata gap) memory: 2044K
[    3.504561] Freeing unused kernel image (rodata/data gap) memory: 180K
[    3.511294] Run /init as init process
[    3.546751] udevd[941]: starting version 3.2.9
[    3.840516] tsc: Refined TSC clocksource calibration: 3899.998 MHz
[    3.846900] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x706eb38f3d8, max_idle_ns: 881591117856 ns
[    3.857444] clocksource: Switched to clocksource tsc
[    8.570501] random: crng init done
[    8.574788] udevd[943]: starting eudev-3.2.9
[    8.583856] ACPI: \_TZ_.UAD0: Invalid passive threshold
[    8.589440] thermal LNXTHERM:00: registered as thermal_zone0
[    8.595351] ACPI: thermal: Thermal Zone [UAD0] (17 C)
[    8.600751] cryptd: max_cpu_qlen set to 1000
[    8.605807] ACPI Warning: SystemIO range 0x0000000000000B00-0x0000000000000B08 conflicts with OpRegion 0x0000000000000B00-0x0000000000000B0F (\GSA1.SMBI) (20220331/utaddress-204)
[    8.622367] ACPI: OSL: Resource conflict; ACPI support missing from driver?
[    8.629730] AVX2 version of gcm_enc/dec engaged.
[    8.629731] ACPI: bus type USB registered
[    8.638862] usbcore: registered new interface driver usbfs
[    8.644580] usbcore: registered new interface driver hub
[    8.650137] usbcore: registered new device driver usb
[    8.655814] AES CTR mode by8 optimization enabled
[    8.662024] ACPI: bus type thunderbolt registered
[    8.666982] thunderbolt 0000:05:00.0: enabling device (0000 -> 0002)
[    8.667087] ahci 0000:01:00.1: SSS flag set, parallel bus scan disabled
[    8.667516] ahci 0000:01:00.1: AHCI 0001.0301 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
[    8.674002] ahci 0000:01:00.1: flags: 64bit ncq sntf stag pm led clo only pmp pio slum part sxs deso sadm sds apst
[    8.680637] ACPI: bus type drm_connector registered
[    8.681137] scsi host0: ahci
[    8.699773] scsi host1: ahci
[    8.704864] scsi host2: ahci
[    8.705319] scsi host3: ahci
[    8.708428] scsi host4: ahci
[    8.711580] scsi host5: ahci
[    8.714631] ata1: SATA max UDMA/133 abar m131072@0xef780000 port 0xef780100 irq 79
[    8.717735] ata2: SATA max UDMA/133 abar m131072@0xef780000 port 0xef780180 irq 79
[    8.720852] ata3: SATA max UDMA/133 abar m131072@0xef780000 port 0xef780200 irq 79
[    8.723968] ata4: SATA max UDMA/133 abar m131072@0xef780000 port 0xef780280 irq 79
[    8.731762] ata5: SATA max UDMA/133 abar m131072@0xef780000 port 0xef780300 irq 79
[    8.754659] ata6: SATA max UDMA/133 abar m131072@0xef780000 port 0xef780380 irq 79
[    8.770030] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    8.775470] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
[    8.838351] xhci_hcd 0000:01:00.0: hcc params 0x0200ef81 hci version 0x110 quirks 0x0000000000000410
[    8.848028] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    8.853481] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 2
[    8.853730] xhci_hcd 0000:01:00.0: Host supports USB 3.1 Enhanced SuperSpeed
[    8.861441] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.19
[    8.868581] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    8.884241] usb usb1: Product: xHCI Host Controller
[    8.889330] usb usb1: Manufacturer: Linux 5.19.0+ xhci-hcd
[    8.895026] usb usb1: SerialNumber: 0000:01:00.0
[    8.899921] hub 1-0:1.0: USB hub found
[    8.903905] hub 1-0:1.0: 10 ports detected
[    8.908375] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    8.916678] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.19
[    8.925137] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    8.925367] usb usb2: Product: xHCI Host Controller
[    8.937652] usb usb2: Manufacturer: Linux 5.19.0+ xhci-hcd
[    8.937877] usb usb2: SerialNumber: 0000:01:00.0
[    8.943662] hub 2-0:1.0: USB hub found
[    8.948415] hub 2-0:1.0: 4 ports detected
[    8.956476] xhci_hcd 0000:28:00.0: xHCI Host Controller
[    8.961905] xhci_hcd 0000:28:00.0: new USB bus registered, assigned bus number 3
[    8.963340] xhci_hcd 0000:28:00.0: hcc params 0x200077c1 hci version 0x110 quirks 0x0000000200009810
[    8.979057] xhci_hcd 0000:28:00.0: xHCI Host Controller
[    8.979277] xhci_hcd 0000:28:00.0: new USB bus registered, assigned bus number 4
[    8.984697] xhci_hcd 0000:28:00.0: Host supports USB 3.1 Enhanced SuperSpeed
[    8.992297] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.19
[    8.999516] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.007965] usb usb3: Product: xHCI Host Controller
[    9.020244] usb usb3: Manufacturer: Linux 5.19.0+ xhci-hcd
[    9.020465] usb usb3: SerialNumber: 0000:28:00.0
[    9.026240] hub 3-0:1.0: USB hub found
[    9.030987] hub 3-0:1.0: 2 ports detected
[    9.038981] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.19
[    9.047427] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.047648] usb usb4: Product: xHCI Host Controller
[    9.059922] usb usb4: Manufacturer: Linux 5.19.0+ xhci-hcd
[    9.060146] usb usb4: SerialNumber: 0000:28:00.0
[    9.066077] hub 4-0:1.0: USB hub found
[    9.074414] hub 4-0:1.0: 2 ports detected
[    9.078709] xhci_hcd 0000:53:00.3: xHCI Host Controller
[    9.084145] xhci_hcd 0000:53:00.3: new USB bus registered, assigned bus number 5
[    9.086213] ata1: SATA link down (SStatus 0 SControl 330)
[    9.091827] xhci_hcd 0000:53:00.3: hcc params 0x0268ffe5 hci version 0x110 quirks 0x0000020000000410
[    9.106840] xhci_hcd 0000:53:00.3: xHCI Host Controller
[    9.112305] xhci_hcd 0000:53:00.3: new USB bus registered, assigned bus number 6
[    9.119928] xhci_hcd 0000:53:00.3: Host supports USB 3.1 Enhanced SuperSpeed
[    9.127208] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.19
[    9.135713] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.143155] usb usb5: Product: xHCI Host Controller
[    9.148262] usb usb5: Manufacturer: Linux 5.19.0+ xhci-hcd
[    9.153975] usb usb5: SerialNumber: 0000:53:00.3
[    9.158873] hub 5-0:1.0: USB hub found
[    9.162871] hub 5-0:1.0: 4 ports detected
[    9.167179] usb usb6: We don't know the algorithms for LPM for this host, disabling LPM.
[    9.175504] usb usb6: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.19
[    9.183982] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.184246] usb usb6: Product: xHCI Host Controller
[    9.191708] usb usb6: Manufacturer: Linux 5.19.0+ xhci-hcd
[    9.196836] usb usb6: SerialNumber: 0000:53:00.3
[    9.202621] hub 6-0:1.0: USB hub found
[    9.207411] hub 6-0:1.0: 2 ports detected
[    9.211386] usb 1-6: new high-speed USB device number 2 using xhci_hcd
[    9.211589] xhci_hcd 0000:53:00.4: xHCI Host Controller
[    9.211592] xhci_hcd 0000:53:00.4: new USB bus registered, assigned bus number 7
[    9.211693] xhci_hcd 0000:53:00.4: hcc params 0x0268ffe5 hci version 0x110 quirks 0x0000020000000410
[    9.211867] xhci_hcd 0000:53:00.4: xHCI Host Controller
[    9.211868] xhci_hcd 0000:53:00.4: new USB bus registered, assigned bus number 8
[    9.211869] xhci_hcd 0000:53:00.4: Host supports USB 3.1 Enhanced SuperSpeed
[    9.211886] usb usb7: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.19
[    9.211887] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.211888] usb usb7: Product: xHCI Host Controller
[    9.211888] usb usb7: Manufacturer: Linux 5.19.0+ xhci-hcd
[    9.211889] usb usb7: SerialNumber: 0000:53:00.4
[    9.211941] hub 7-0:1.0: USB hub found
[    9.211948] hub 7-0:1.0: 4 ports detected
[    9.212040] usb usb8: We don't know the algorithms for LPM for this host, disabling LPM.
[    9.212051] usb usb8: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.19
[    9.212052] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.212053] usb usb8: Product: xHCI Host Controller
[    9.212053] usb usb8: Manufacturer: Linux 5.19.0+ xhci-hcd
[    9.212054] usb usb8: SerialNumber: 0000:53:00.4
[    9.212099] hub 8-0:1.0: USB hub found
[    9.212105] hub 8-0:1.0: 2 ports detected
[    9.419486] usb 1-6: New USB device found, idVendor=05e3, idProduct=0608, bcdDevice=85.36
[    9.421988] ata2: SATA link down (SStatus 0 SControl 330)
[    9.427902] usb 1-6: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    9.440917] usb 1-6: Product: USB2.0 Hub
[    9.451474] hub 1-6:1.0: USB hub found
[    9.458456] hub 1-6:1.0: 4 ports detected
[    9.480513] usb 5-2: new high-speed USB device number 2 using xhci_hcd
[    9.520498] usb 7-1: new low-speed USB device number 2 using xhci_hcd
[    9.630514] usb 1-7: new full-speed USB device number 3 using xhci_hcd
[    9.659063] thunderbolt 0-3: new device found, vendor=0x1 device=0x8002
[    9.665922] thunderbolt 0-3: Apple, Inc. Thunderbolt Display
[    9.681353] usb 5-2: New USB device found, idVendor=05e3, idProduct=0610, bcdDevice= 6.54
[    9.689768] usb 5-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    9.697143] usb 5-2: Product: USB2.1 Hub
[    9.701307] usb 5-2: Manufacturer: GenesysLogic
[    9.734994] usb 7-1: New USB device found, idVendor=047d, idProduct=1020, bcdDevice= 1.06
[    9.743410] usb 7-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    9.750788] usb 7-1: Product: Kensington Expert Mouse
[    9.752018] ata3: SATA link down (SStatus 0 SControl 330)
[    9.767771] hub 5-2:1.0: USB hub found
[    9.772224] hub 5-2:1.0: 4 ports detected
[    9.820993] usb 6-2: new SuperSpeed USB device number 2 using xhci_hcd
[    9.855339] usb 6-2: New USB device found, idVendor=05e3, idProduct=0626, bcdDevice= 6.54
[    9.863757] usb 6-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    9.871136] usb 6-2: Product: USB3.1 Hub
[    9.875308] usb 6-2: Manufacturer: GenesysLogic
[    9.912430] hub 6-2:1.0: USB hub found
[    9.916741] hub 6-2:1.0: 4 ports detected
[   10.000421] usb 1-7: New USB device found, idVendor=048d, idProduct=5702, bcdDevice= 0.01
[   10.008832] usb 1-7: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   10.016190] usb 1-7: Product: ITE Device
[   10.020343] usb 1-7: Manufacturer: ITE Tech. Inc.
[   10.025283] usb 1-6.3: new high-speed USB device number 4 using xhci_hcd
[   10.094140] ata4: SATA link down (SStatus 0 SControl 330)
[   10.130878] usb 5-2.3: new high-speed USB device number 3 using xhci_hcd
[   10.184617] usb 1-6.3: New USB device found, idVendor=2109, idProduct=2812, bcdDevice= b.e0
[   10.193213] usb 1-6.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   10.200753] usb 1-6.3: Product: USB2.0 Hub
[   10.206211] usb 1-6.3: Manufacturer: VIA Labs, Inc.
[   10.219452] hub 1-6.3:1.0: USB hub found
[   10.226436] hub 1-6.3:1.0: 4 ports detected
[   10.310882] usb 1-10: new high-speed USB device number 5 using xhci_hcd
[   10.323099] usb 5-2.3: New USB device found, idVendor=05e3, idProduct=0610, bcdDevice= 6.54
[   10.331683] usb 5-2.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   10.339215] usb 5-2.3: Product: USB2.1 Hub
[   10.343564] usb 5-2.3: Manufacturer: GenesysLogic
[   10.407926] hub 5-2.3:1.0: USB hub found
[   10.410755] usb 6-2.3: new SuperSpeed USB device number 3 using xhci_hcd
[   10.412602] hub 5-2.3:1.0: 4 ports detected
[   10.445583] usb 6-2.3: New USB device found, idVendor=05e3, idProduct=0626, bcdDevice= 6.54
[   10.454178] usb 6-2.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   10.461728] usb 6-2.3: Product: USB3.1 Hub
[   10.466067] usb 6-2.3: Manufacturer: GenesysLogic
[   10.504442] hub 6-2.3:1.0: USB hub found
[   10.508944] hub 6-2.3:1.0: 4 ports detected
[   10.520449] usb 1-10: New USB device found, idVendor=05e3, idProduct=0608, bcdDevice=85.36
[   10.528953] usb 1-10: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[   10.536410] usb 1-10: Product: USB2.0 Hub
[   10.549441] hub 1-10:1.0: USB hub found
[   10.557425] hub 1-10:1.0: 4 ports detected
[   10.610891] usb 1-6.3.2: new high-speed USB device number 6 using xhci_hcd
[   10.787601] usb 1-6.3.2: New USB device found, idVendor=05ac, idProduct=1006, bcdDevice=96.15
[   10.796364] usb 1-6.3.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   10.804076] usb 1-6.3.2: Product: Keyboard Hub
[   10.808750] usb 1-6.3.2: Manufacturer: Apple, Inc.
[   10.813773] usb 1-6.3.2: SerialNumber: 000000000000
[   10.827433] hub 1-6.3.2:1.0: USB hub found
[   10.834417] hub 1-6.3.2:1.0: 3 ports detected
[   10.970731] usb 1-6.3.4: new high-speed USB device number 7 using xhci_hcd
[   11.165614] usb 1-6.3.4: New USB device found, idVendor=0bda, idProduct=8153, bcdDevice=30.00
[   11.174366] usb 1-6.3.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   11.182073] usb 1-6.3.4: Product: USB 10/100/1000 LAN
[   11.187352] usb 1-6.3.4: Manufacturer: Realtek
[   11.192020] usb 1-6.3.4: SerialNumber: F01E341F8303
[   11.200509] ata5: failed to resume link (SControl 0)
[   11.205749] ata5: SATA link down (SStatus 0 SControl 0)
[   11.290733] usb 1-6.3.2.2: new low-speed USB device number 8 using xhci_hcd
[   11.572587] usb 1-6.3.2.2: New USB device found, idVendor=05ac, idProduct=0220, bcdDevice= 0.71
[   11.581527] usb 1-6.3.2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   11.589409] usb 1-6.3.2.2: Product: Apple Keyboard
[   11.594430] usb 1-6.3.2.2: Manufacturer: Apple, Inc
[   12.310792] ata6: failed to resume link (SControl 0)
[   12.316017] ata6: SATA link down (SStatus 0 SControl 0)
[   12.323496] hid: raw HID events driver (C) Jiri Kosina
[   12.341869] [drm] amdgpu kernel modesetting enabled.
[   12.349630] amdgpu: CRAT table disabled by module option
[   12.355159] amdgpu: Virtual CRAT table created for CPU
[   12.360523] amdgpu: Topology: Add CPU node
[   12.364916] Console: switching to colour dummy device 80x25
[   12.370498] amdgpu 0000:53:00.0: vgaarb: deactivate vga console
[   12.376427] amdgpu 0000:53:00.0: enabling device (0006 -> 0007)
[   12.382349] [drm] initializing kernel modesetting (RENOIR 0x1002:0x1638 0x1458:0xD000 0xC9).
[   12.390763] [drm] register mmio base: 0xEFC00000
[   12.395367] [drm] register mmio size: 524288
[   12.395408] usbcore: registered new interface driver usbhid
[   12.401637] [drm] add ip block number 0 <soc15_common>
[   12.405185] usbhid: USB HID core driver
[   12.410296] [drm] add ip block number 1 <gmc_v9_0>
[   12.418896] [drm] add ip block number 2 <vega10_ih>
[   12.423762] [drm] add ip block number 3 <psp>
[   12.428117] [drm] add ip block number 4 <smu>
[   12.432474] [drm] add ip block number 5 <dm>
[   12.432549] input: Kensington Expert Mouse as /devices/pci0000:00/0000:00:08.1/0000:53:00.4/usb7/7-1/7-1:1.0/0003:047D:1020.0001/input/input0
[   12.436732] [drm] add ip block number 6 <gfx_v9_0>
[   12.436733] [drm] add ip block number 7 <sdma_v4_0>
[   12.436825] hid-generic 0003:047D:1020.0001: input,hidraw0: USB HID v1.11 Mouse [Kensington Expert Mouse] on usb-0000:53:00.4-1/input0
[   12.449377] [drm] add ip block number 8 <vcn_v2_0>
[   12.449378] [drm] add ip block number 9 <jpeg_v2_0>
[   12.450506] amdgpu 0000:53:00.0: amdgpu: Fetched VBIOS from VFCT
[   12.454508] hid-generic 0003:048D:5702.0002: hiddev96,hidraw1: USB HID v1.12 Device [ITE Tech. Inc. ITE Device] on usb-0000:01:00.0-7/input0
[   12.459023] amdgpu: ATOM BIOS: 13-CEZANNE-019
[   12.503625] [drm] VCN decode is enabled in VM mode
[   12.508402] [drm] VCN encode is enabled in VM mode
[   12.513183] [drm] JPEG decode is enabled in VM mode
[   12.518048] amdgpu 0000:53:00.0: amdgpu: Trusted Memory Zone (TMZ) feature enabled
[   12.525595] amdgpu 0000:53:00.0: amdgpu: PCIE atomic ops is not supported
[   12.532367] amdgpu 0000:53:00.0: amdgpu: MODE2 reset
[   12.537742] input: Apple, Inc Apple Keyboard as /devices/pci0000:00/0000:00:02.1/0000:01:00.0/usb1/1-6/1-6.3/1-6.3.2/1-6.3.2.2/1-6.3.2.2:1.0/0003:05AC:0220.0003/input/input1
[   12.538220] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
[   12.561653] amdgpu 0000:53:00.0: amdgpu: VRAM: 512M 0x000000F400000000 - 0x000000F41FFFFFFF (512M used)
[   12.571010] amdgpu 0000:53:00.0: amdgpu: GART: 1024M 0x0000000000000000 - 0x000000003FFFFFFF
[   12.579416] amdgpu 0000:53:00.0: amdgpu: AGP: 267419648M 0x000000F800000000 - 0x0000FFFFFFFFFFFF
[   12.588169] [drm] Detected VRAM RAM=512M, BAR=512M
[   12.592945] [drm] RAM width 128bits DDR4
[   12.596882] [drm] amdgpu: 512M of VRAM memory ready
[   12.601742] [drm] amdgpu: 15733M of GTT memory ready.
[   12.606786] [drm] GART: num cpu pages 262144, num gpu pages 262144
[   12.613061] [drm] PCIE GART of 1024M enabled.
[   12.617403] [drm] PTB located at 0x000000F400A00000
[   12.620926] apple 0003:05AC:0220.0003: input,hidraw2: USB HID v1.11 Keyboard [Apple, Inc Apple Keyboard] on usb-0000:01:00.0-6.3.2.2/input0
[   12.622361] amdgpu 0000:53:00.0: amdgpu: PSP runtime database doesn't exist
[   12.634764] apple 0003:05AC:0220.0004: Fn key not found (Apple Wireless Keyboard clone?), disabling Fn key handling
[   12.641670] amdgpu 0000:53:00.0: amdgpu: PSP runtime database doesn't exist
[   12.641683] input: Apple, Inc Apple Keyboard as /devices/pci0000:00/0000:00:02.1/0000:01:00.0/usb1/1-6/1-6.3/1-6.3.2/1-6.3.2.2/1-6.3.2.2:1.1/0003:05AC:0220.0004/input/input2
[   12.652139] [drm] Loading DMUB firmware via PSP: version=0x0101001F
[   12.681013] [drm] Found VCN firmware Version ENC: 1.17 DEC: 5 VEP: 0 Revision: 2
[   12.688380] amdgpu 0000:53:00.0: amdgpu: Will use PSP to load VCN firmware
[   12.730919] apple 0003:05AC:0220.0004: input,hidraw3: USB HID v1.11 Device [Apple, Inc Apple Keyboard] on usb-0000:01:00.0-6.3.2.2/input1
[   13.411205] [drm] reserve 0x400000 from 0xf41f800000 for PSP TMR
[   13.497303] amdgpu 0000:53:00.0: amdgpu: RAS: optional ras ta ucode is not available
[   13.515593] amdgpu 0000:53:00.0: amdgpu: RAP: optional rap ta ucode is not available
[   13.523303] amdgpu 0000:53:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not available
[   13.532156] amdgpu 0000:53:00.0: amdgpu: SMU is initialized successfully!
[   13.539141] [drm] Display Core initialized with v3.2.196!
[   13.545072] [drm] DMUB hardware initialized: version=0x0101001F
[   13.598369] [drm] kiq ring mec 2 pipe 1 q 0
[   13.605153] [drm] VCN decode and encode initialized successfully(under DPG Mode).
[   13.612621] [drm] JPEG decode initialized successfully.
[   13.619030] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[   13.625031] amdgpu: sdma_bitmap: 3
[   13.628437] amdgpu: SRAT table not found
[   13.632349] amdgpu: Virtual CRAT table created for GPU
[   13.637993] amdgpu: Topology: Add dGPU node [0x1638:0x1002]
[   13.643548] kfd kfd: amdgpu: added device 1002:1638
[   13.648573] amdgpu 0000:53:00.0: amdgpu: SE 1, SH per SE 1, CU per SH 8, active_cu_number 7
[   13.656920] amdgpu 0000:53:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
[   13.663939] amdgpu 0000:53:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[   13.671570] amdgpu 0000:53:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[   13.679196] amdgpu 0000:53:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
[   13.686826] amdgpu 0000:53:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
[   13.694455] amdgpu 0000:53:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
[   13.702079] amdgpu 0000:53:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
[   13.709707] amdgpu 0000:53:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
[   13.717331] amdgpu 0000:53:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
[   13.725047] amdgpu 0000:53:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 11 on hub 0
[   13.732669] amdgpu 0000:53:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 1
[   13.739860] amdgpu 0000:53:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hub 1
[   13.747224] amdgpu 0000:53:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on hub 1
[   13.754673] amdgpu 0000:53:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on hub 1
[   13.762133] amdgpu 0000:53:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 1
[   13.770841] [drm] Initialized amdgpu 3.48.0 20150101 for 0000:53:00.0 on minor 0
[   13.780823] fbcon: amdgpudrmfb (fb0) is primary device
[   13.780861] [drm] DSC precompute is not needed.
[   13.871193] Console: switching to colour frame buffer device 320x90
[   13.904334] amdgpu 0000:53:00.0: [drm] fb0: amdgpudrmfb frame buffer device
[   14.162570] device-mapper: ioctl: 4.47.0-ioctl (2022-07-28) initialised: dm-devel@redhat.com
[   14.210716] RTL8226B_RTL8221B 2.5Gbps PHY r8169-0-4e00:00: attached PHY driver (mii_bus:phy_addr=r8169-0-4e00:00, irq=MAC)
[   14.500861] r8169 0000:4e:00.0 eth1: Link is Down
[   17.467352] r8169 0000:4e:00.0 eth1: Link is Up - 1Gbps/Full - flow control off
[   19.025128] r8169 0000:4e:00.0 eth1: Link is Down
[   21.550019] EXT4-fs (dm-0): mounted filesystem with ordered data mode. Quota mode: none.
[   21.844074] udevd[1392]: starting version 3.2.9
[   21.882626] udevd[1393]: starting eudev-3.2.9
[   21.899979] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input3
[   21.908523] ACPI: button: Power Button [PWRB]
[   21.912941] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input4
[   21.921036] pcieport 0000:04:04.0: pciehp: Slot(4): Card present
[   21.931567] mousedev: PS/2 mouse device common for all mice
[   21.937655] SVM: TSC scaling supported
[   21.941399] kvm: Nested Virtualization enabled
[   21.945866] SVM: kvm: Nested Paging enabled
[   21.950428] SVM: Virtual VMLOAD VMSAVE supported
[   21.955389] SVM: Virtual GIF supported
[   21.959485] SVM: LBR virtualization supported
[   21.960534] ACPI: button: Power Button [PWRF]
[   21.972892] snd_hda_intel 0000:53:00.1: enabling device (0000 -> 0002)
[   21.979922] snd_hda_intel 0000:53:00.6: enabling device (0000 -> 0002)
[   21.987217] snd_hda_intel 0000:53:00.1: bound 0000:53:00.0 (ops amdgpu_exit [amdgpu])
[   21.987636] input: HD-Audio Generic HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:08.1/0000:53:00.1/sound/card0/input5
[   21.987661] input: HD-Audio Generic HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:08.1/0000:53:00.1/sound/card0/input6
[   21.987678] input: HD-Audio Generic HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:08.1/0000:53:00.1/sound/card0/input7
[   21.987773] input: HD-Audio Generic HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:08.1/0000:53:00.1/sound/card0/input8
[   22.065703] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC1220: line_outs=3 (0x14/0x15/0x16/0x0/0x0) type:line
[   22.065706] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   22.065707] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[   22.065708] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
[   22.065708] snd_hda_codec_realtek hdaudioC1D0:    dig-out=0x1e/0x0
[   22.065709] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[   22.065709] snd_hda_codec_realtek hdaudioC1D0:      Front Mic=0x19
[   22.065710] snd_hda_codec_realtek hdaudioC1D0:      Rear Mic=0x18
[   22.065710] snd_hda_codec_realtek hdaudioC1D0:      Line=0x1a
[   22.090152] input: HD-Audio Generic Front Mic as /devices/pci0000:00/0000:00:08.1/0000:53:00.6/sound/card1/input9
[   22.153945] pci 0000:29:00.0: [8086:1513] type 01 class 0x060400
[   22.154045] pci 0000:29:00.0: enabling Extended Tags
[   22.154224] pci 0000:29:00.0: supports D1 D2
[   22.154225] pci 0000:29:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   22.154393] input: HD-Audio Generic Rear Mic as /devices/pci0000:00/0000:00:08.1/0000:53:00.6/sound/card1/input10
[   22.154408] input: HD-Audio Generic Line as /devices/pci0000:00/0000:00:08.1/0000:53:00.6/sound/card1/input11
[   22.154426] input: HD-Audio Generic Line Out Front as /devices/pci0000:00/0000:00:08.1/0000:53:00.6/sound/card1/input12
[   22.154442] input: HD-Audio Generic Line Out Surround as /devices/pci0000:00/0000:00:08.1/0000:53:00.6/sound/card1/input13
[   22.154456] input: HD-Audio Generic Line Out CLFE as /devices/pci0000:00/0000:00:08.1/0000:53:00.6/sound/card1/input14
[   22.154468] input: HD-Audio Generic Front Headphone as /devices/pci0000:00/0000:00:08.1/0000:53:00.6/sound/card1/input15
[   22.250263] pci 0000:29:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   22.258725] pci 0000:2a:00.0: [8086:1513] type 01 class 0x060400
[   22.265159] pci 0000:2a:00.0: enabling Extended Tags
[   22.270600] pci 0000:2a:00.0: supports D1 D2
[   22.275165] pci 0000:2a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   22.282224] pci 0000:2a:01.0: [8086:1513] type 01 class 0x060400
[   22.288629] pci 0000:2a:01.0: enabling Extended Tags
[   22.294061] pci 0000:2a:01.0: supports D1 D2
[   22.298620] pci 0000:2a:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[   22.305660] pci 0000:2a:02.0: [8086:1513] type 01 class 0x060400
[   22.312064] pci 0000:2a:02.0: enabling Extended Tags
[   22.317476] pci 0000:2a:02.0: supports D1 D2
[   22.322031] pci 0000:2a:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[   22.329076] pci 0000:2a:04.0: [8086:1513] type 01 class 0x060400
[   22.335473] pci 0000:2a:04.0: enabling Extended Tags
[   22.340917] pci 0000:2a:04.0: supports D1 D2
[   22.345461] pci 0000:2a:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[   22.352506] pci 0000:2a:05.0: [8086:1513] type 01 class 0x060400
[   22.358904] pci 0000:2a:05.0: enabling Extended Tags
[   22.364316] pci 0000:2a:05.0: supports D1 D2
[   22.368861] pci 0000:2a:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[   22.375927] pci 0000:29:00.0: PCI bridge to [bus 2a-4a]
[   22.381448] pci 0000:29:00.0:   bridge window [io  0x0000-0x0fff]
[   22.387819] pci 0000:29:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   22.394885] pci 0000:29:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   22.402891] pci 0000:2a:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   22.411161] pci 0000:2a:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   22.419431] pci 0000:2a:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   22.427704] pci 0000:2a:04.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   22.435969] pci 0000:2a:05.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   22.444377] pci 0000:2b:00.0: [12d8:400c] type 01 class 0x060400
[   22.451027] pci 0000:2b:00.0: supports D1 D2
[   22.455560] pci 0000:2b:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   22.490794] pci 0000:2a:00.0: PCI bridge to [bus 2b-4a]
[   22.496349] pci 0000:2a:00.0:   bridge window [io  0x0000-0x0fff]
[   22.502717] pci 0000:2a:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   22.509787] pci 0000:2a:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   22.517793] pci 0000:2b:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   22.526288] pci 0000:2c:03.0: [12d8:400c] type 01 class 0x060400
[   22.532888] pci 0000:2c:03.0: supports D1 D2
[   22.537426] pci 0000:2c:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[   22.544507] pci 0000:2b:00.0: PCI bridge to [bus 2c-4a]
[   22.550015] pci 0000:2b:00.0:   bridge window [io  0x0000-0x0fff]
[   22.556378] pci 0000:2b:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   22.563444] pci 0000:2b:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   22.571452] pci 0000:2c:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   22.579909] pci 0000:2d:00.0: [12d8:400e] type 00 class 0x0c0310
[   22.586232] pci 0000:2d:00.0: reg 0x10: [mem 0x00000000-0x00000fff]
[   22.593017] pci 0000:2d:00.0: supports D1 D2
[   22.597552] pci 0000:2d:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   22.604583] pci 0000:2d:00.1: [12d8:400e] type 00 class 0x0c0310
[   22.610962] pci 0000:2d:00.1: reg 0x10: [mem 0x00000000-0x00000fff]
[   22.611266] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   22.617748] pci 0000:2d:00.1: supports D1 D2
[   22.628807] pci 0000:2d:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[   22.635813] pci 0000:2d:00.2: [12d8:400f] type 00 class 0x0c0320
[   22.642122] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   22.642143] pci 0000:2d:00.2: reg 0x10: [mem 0x00000000-0x000000ff]
[   22.655387] pci 0000:2d:00.2: supports D1 D2
[   22.659944] pci 0000:2d:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[   22.667060] ehci-pci: EHCI PCI platform driver
[   22.671786] pci 0000:2c:03.0: PCI bridge to [bus 2d-4a]
[   22.677316] pci 0000:2c:03.0:   bridge window [io  0x0000-0x0fff]
[   22.683694] pci 0000:2c:03.0:   bridge window [mem 0x00000000-0x000fffff]
[   22.690799] ohci-pci: OHCI PCI platform driver
[   22.690799] pci 0000:2c:03.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   22.703569] pci_bus 0000:2d: busn_res: [bus 2d-4a] end is updated to 2d
[   22.710452] pci_bus 0000:2c: busn_res: [bus 2c-4a] end is updated to 2d
[   22.717331] pci_bus 0000:2b: busn_res: [bus 2b-4a] end is updated to 2d
[   22.724352] pci 0000:2e:00.0: [14e4:16b0] type 00 class 0x020000
[   22.730676] pci 0000:2e:00.0: reg 0x10: [mem 0x00000000-0x0000ffff 64bit pref]
[   22.738186] pci 0000:2e:00.0: reg 0x18: [mem 0x00000000-0x0000ffff 64bit pref]
[   22.745967] pci 0000:2e:00.0: PME# supported from D0 D3hot D3cold
[   22.780769] pci 0000:2a:01.0: PCI bridge to [bus 2e-4a]
[   22.786322] pci 0000:2a:01.0:   bridge window [io  0x0000-0x0fff]
[   22.792685] pci 0000:2a:01.0:   bridge window [mem 0x00000000-0x000fffff]
[   22.799748] pci 0000:2a:01.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   22.807751] pci_bus 0000:2e: busn_res: [bus 2e-4a] end is updated to 2e
[   22.814790] pci 0000:2f:00.0: [11c1:5901] type 00 class 0x0c0010
[   22.821117] pci 0000:2f:00.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[   22.828472] pci 0000:2f:00.0: supports D1 D2
[   22.833008] pci 0000:2f:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   22.860798] pci 0000:2a:02.0: PCI bridge to [bus 2f-4a]
[   22.866351] pci 0000:2a:02.0:   bridge window [io  0x0000-0x0fff]
[   22.872714] pci 0000:2a:02.0:   bridge window [mem 0x00000000-0x000fffff]
[   22.879769] pci 0000:2a:02.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   22.887762] pci_bus 0000:2f: busn_res: [bus 2f-4a] end is updated to 2f
[   22.894784] pci 0000:2a:04.0: PCI bridge to [bus 30-4a]
[   22.900282] pci 0000:2a:04.0:   bridge window [io  0x0000-0x0fff]
[   22.906639] pci 0000:2a:04.0:   bridge window [mem 0x00000000-0x000fffff]
[   22.913710] pci 0000:2a:04.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   22.921791] pci_bus 0000:30: busn_res: [bus 30-4a] end is updated to 3f
[   22.928758] pci 0000:2a:05.0: PCI bridge to [bus 40-4a]
[   22.934253] pci 0000:2a:05.0:   bridge window [io  0x0000-0x0fff]
[   22.940596] pci 0000:2a:05.0:   bridge window [mem 0x00000000-0x000fffff]
[   22.947645] pci 0000:2a:05.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   22.955628] pci_bus 0000:40: busn_res: [bus 40-4a] end is updated to 4a
[   22.962495] pci_bus 0000:2a: busn_res: [bus 2a-4a] end is updated to 4a
[   22.969367] pci 0000:2a:04.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 30-3f] add_size 100000 add_align 100000
[   22.981336] pci 0000:2a:04.0: bridge window [mem 0x00100000-0x001fffff] to [bus 30-3f] add_size 100000 add_align 100000
[   22.992356] pci 0000:2a:05.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 40-4a] add_size 100000 add_align 100000
[   23.004332] pci 0000:2a:05.0: bridge window [mem 0x00100000-0x001fffff] to [bus 40-4a] add_size 100000 add_align 100000
[   23.015357] pci 0000:29:00.0: bridge window [mem 0x00100000-0x005fffff 64bit pref] to [bus 2a-4a] add_size 200000 add_align 100000
[   23.027324] pci 0000:29:00.0: bridge window [mem 0x00100000-0x005fffff] to [bus 2a-4a] add_size 200000 add_align 100000
[   23.038348] pcieport 0000:04:04.0: BAR 7: no space for [io  size 0x5000]
[   23.045307] pcieport 0000:04:04.0: BAR 7: failed to assign [io  size 0x5000]
[   23.052608] pci 0000:29:00.0: BAR 8: assigned [mem 0xdf000000-0xe6ffffff]
[   23.059652] pci 0000:29:00.0: BAR 9: assigned [mem 0xa0000000-0xa1ffffff 64bit pref]
[   23.067643] pci 0000:29:00.0: BAR 7: no space for [io  size 0x5000]
[   23.074166] pci 0000:29:00.0: BAR 7: failed to assign [io  size 0x5000]
[   23.081038] pci 0000:2a:00.0: BAR 8: assigned [mem 0xdf000000-0xdf0fffff]
[   23.088081] pci 0000:2a:00.0: BAR 9: assigned [mem 0xa0000000-0xa00fffff 64bit pref]
[   23.096075] pci 0000:2a:01.0: BAR 8: assigned [mem 0xdf100000-0xdf1fffff]
[   23.103116] pci 0000:2a:01.0: BAR 9: assigned [mem 0xa0100000-0xa01fffff 64bit pref]
[   23.111118] pci 0000:2a:02.0: BAR 8: assigned [mem 0xdf200000-0xdf2fffff]
[   23.118171] pci 0000:2a:02.0: BAR 9: assigned [mem 0xa0200000-0xa02fffff 64bit pref]
[   23.126164] pci 0000:2a:04.0: BAR 8: assigned [mem 0xdf300000-0xe317ffff]
[   23.133214] pci 0000:2a:04.0: BAR 9: assigned [mem 0xa0300000-0xa117ffff 64bit pref]
[   23.141217] pci 0000:2a:05.0: BAR 8: assigned [mem 0xe3200000-0xe6ffffff]
[   23.148269] pci 0000:2a:05.0: BAR 9: assigned [mem 0xa1200000-0xa1ffffff 64bit pref]
[   23.156270] pci 0000:2a:00.0: BAR 7: no space for [io  size 0x1000]
[   23.162804] pci 0000:2a:00.0: BAR 7: failed to assign [io  size 0x1000]
[   23.169680] pci 0000:2a:01.0: BAR 7: no space for [io  size 0x1000]
[   23.176206] pci 0000:2a:01.0: BAR 7: failed to assign [io  size 0x1000]
[   23.183085] pci 0000:2a:02.0: BAR 7: no space for [io  size 0x1000]
[   23.189620] pci 0000:2a:02.0: BAR 7: failed to assign [io  size 0x1000]
[   23.196499] pci 0000:2a:04.0: BAR 7: no space for [io  size 0x1000]
[   23.203033] pci 0000:2a:04.0: BAR 7: failed to assign [io  size 0x1000]
[   23.209910] pci 0000:2a:05.0: BAR 7: no space for [io  size 0x1000]
[   23.216435] pci 0000:2a:05.0: BAR 7: failed to assign [io  size 0x1000]
[   23.223309] pci 0000:2b:00.0: BAR 8: assigned [mem 0xdf000000-0xdf0fffff]
[   23.230360] pci 0000:2b:00.0: BAR 9: assigned [mem 0xa0000000-0xa00fffff 64bit pref]
[   23.238361] pci 0000:2b:00.0: BAR 7: no space for [io  size 0x1000]
[   23.244888] pci 0000:2b:00.0: BAR 7: failed to assign [io  size 0x1000]
[   23.251767] pci 0000:2c:03.0: BAR 8: assigned [mem 0xdf000000-0xdf0fffff]
[   23.258817] pci 0000:2c:03.0: BAR 9: assigned [mem 0xa0000000-0xa00fffff 64bit pref]
[   23.266811] pci 0000:2c:03.0: BAR 7: no space for [io  size 0x1000]
[   23.273336] pci 0000:2c:03.0: BAR 7: failed to assign [io  size 0x1000]
[   23.280207] pci 0000:2d:00.0: BAR 0: assigned [mem 0xdf000000-0xdf000fff]
[   23.287257] pci 0000:2d:00.1: BAR 0: assigned [mem 0xdf001000-0xdf001fff]
[   23.294309] pci 0000:2d:00.2: BAR 0: assigned [mem 0xdf002000-0xdf0020ff]
[   23.301359] pci 0000:2c:03.0: PCI bridge to [bus 2d]
[   23.306600] pci 0000:2c:03.0:   bridge window [mem 0xdf000000-0xdf0fffff]
[   23.313646] pci 0000:2c:03.0:   bridge window [mem 0xa0000000-0xa00fffff 64bit pref]
[   23.321650] pci 0000:2b:00.0: PCI bridge to [bus 2c-2d]
[   23.327142] pci 0000:2b:00.0:   bridge window [mem 0xdf000000-0xdf0fffff]
[   23.334193] pci 0000:2b:00.0:   bridge window [mem 0xa0000000-0xa00fffff 64bit pref]
[   23.342203] pci 0000:2a:00.0: PCI bridge to [bus 2b-2d]
[   23.347692] pci 0000:2a:00.0:   bridge window [mem 0xdf000000-0xdf0fffff]
[   23.354739] pci 0000:2a:00.0:   bridge window [mem 0xa0000000-0xa00fffff 64bit pref]
[   23.362741] pci 0000:2e:00.0: BAR 0: assigned [mem 0xa0100000-0xa010ffff 64bit pref]
[   23.370765] pci 0000:2e:00.0: BAR 2: assigned [mem 0xa0110000-0xa011ffff 64bit pref]
[   23.378779] pci 0000:2a:01.0: PCI bridge to [bus 2e]
[   23.384005] pci 0000:2a:01.0:   bridge window [mem 0xdf100000-0xdf1fffff]
[   23.391046] pci 0000:2a:01.0:   bridge window [mem 0xa0100000-0xa01fffff 64bit pref]
[   23.399046] pci 0000:2f:00.0: BAR 0: assigned [mem 0xdf200000-0xdf200fff 64bit]
[   23.406628] pci 0000:2a:02.0: PCI bridge to [bus 2f]
[   23.411850] pci 0000:2a:02.0:   bridge window [mem 0xdf200000-0xdf2fffff]
[   23.418899] pci 0000:2a:02.0:   bridge window [mem 0xa0200000-0xa02fffff 64bit pref]
[   23.426898] pci 0000:2a:04.0: PCI bridge to [bus 30-3f]
[   23.432380] pci 0000:2a:04.0:   bridge window [mem 0xdf300000-0xe317ffff]
[   23.439420] pci 0000:2a:04.0:   bridge window [mem 0xa0300000-0xa117ffff 64bit pref]
[   23.447422] pci 0000:2a:05.0: PCI bridge to [bus 40-4a]
[   23.452904] pci 0000:2a:05.0:   bridge window [mem 0xe3200000-0xe6ffffff]
[   23.459945] pci 0000:2a:05.0:   bridge window [mem 0xa1200000-0xa1ffffff 64bit pref]
[   23.467946] pci 0000:29:00.0: PCI bridge to [bus 2a-4a]
[   23.473437] pci 0000:29:00.0:   bridge window [mem 0xdf000000-0xe6ffffff]
[   23.480478] pci 0000:29:00.0:   bridge window [mem 0xa0000000-0xa1ffffff 64bit pref]
[   23.488477] pcieport 0000:04:04.0: PCI bridge to [bus 29-4a]
[   23.494398] pcieport 0000:04:04.0:   bridge window [mem 0xdf000000-0xe6ffffff]
[   23.501872] pcieport 0000:04:04.0:   bridge window [mem 0xa0000000-0xa1ffffff 64bit pref]
[   23.510303] pcieport 0000:04:04.0: BAR 7: no space for [io  size 0x5000]
[   23.517251] pcieport 0000:04:04.0: BAR 7: failed to assign [io  size 0x5000]
[   23.524545] pci 0000:29:00.0: BAR 7: no space for [io  size 0x5000]
[   23.531058] pci 0000:29:00.0: BAR 7: failed to assign [io  size 0x5000]
[   23.537928] pci 0000:2a:00.0: BAR 7: no space for [io  size 0x1000]
[   23.544446] pci 0000:2a:00.0: BAR 7: failed to assign [io  size 0x1000]
[   23.551306] pci 0000:2a:01.0: BAR 7: no space for [io  size 0x1000]
[   23.557821] pci 0000:2a:01.0: BAR 7: failed to assign [io  size 0x1000]
[   23.564682] pci 0000:2a:02.0: BAR 7: no space for [io  size 0x1000]
[   23.571199] pci 0000:2a:02.0: BAR 7: failed to assign [io  size 0x1000]
[   23.578069] pci 0000:2a:04.0: BAR 7: no space for [io  size 0x1000]
[   23.584586] pci 0000:2a:04.0: BAR 7: failed to assign [io  size 0x1000]
[   23.591447] pci 0000:2a:05.0: BAR 7: no space for [io  size 0x1000]
[   23.597963] pci 0000:2a:05.0: BAR 7: failed to assign [io  size 0x1000]
[   23.604824] pci 0000:2b:00.0: BAR 7: no space for [io  size 0x1000]
[   23.611341] pci 0000:2b:00.0: BAR 7: failed to assign [io  size 0x1000]
[   23.618201] pci 0000:2c:03.0: BAR 7: no space for [io  size 0x1000]
[   23.624717] pci 0000:2c:03.0: BAR 7: failed to assign [io  size 0x1000]
[   23.631581] pci 0000:2c:03.0: PCI bridge to [bus 2d]
[   23.636811] pci 0000:2c:03.0:   bridge window [mem 0xdf000000-0xdf0fffff]
[   23.643851] pci 0000:2c:03.0:   bridge window [mem 0xa0000000-0xa00fffff 64bit pref]
[   23.651848] pci 0000:2b:00.0: PCI bridge to [bus 2c-2d]
[   23.657383] pci 0000:2b:00.0:   bridge window [mem 0xdf000000-0xdf0fffff]
[   23.664426] pci 0000:2b:00.0:   bridge window [mem 0xa0000000-0xa00fffff 64bit pref]
[   23.672418] pci 0000:2a:00.0: PCI bridge to [bus 2b-2d]
[   23.677888] pci 0000:2a:00.0:   bridge window [mem 0xdf000000-0xdf0fffff]
[   23.684921] pci 0000:2a:00.0:   bridge window [mem 0xa0000000-0xa00fffff 64bit pref]
[   23.692904] pci 0000:2a:01.0: PCI bridge to [bus 2e]
[   23.698120] pci 0000:2a:01.0:   bridge window [mem 0xdf100000-0xdf1fffff]
[   23.705142] pci 0000:2a:01.0:   bridge window [mem 0xa0100000-0xa01fffff 64bit pref]
[   23.713133] pci 0000:2a:02.0: PCI bridge to [bus 2f]
[   23.718349] pci 0000:2a:02.0:   bridge window [mem 0xdf200000-0xdf2fffff]
[   23.725381] pci 0000:2a:02.0:   bridge window [mem 0xa0200000-0xa02fffff 64bit pref]
[   23.733371] pci 0000:2a:04.0: PCI bridge to [bus 30-3f]
[   23.738852] pci 0000:2a:04.0:   bridge window [mem 0xdf300000-0xe317ffff]
[   23.745885] pci 0000:2a:04.0:   bridge window [mem 0xa0300000-0xa117ffff 64bit pref]
[   23.753867] pci 0000:2a:05.0: PCI bridge to [bus 40-4a]
[   23.759343] pci 0000:2a:05.0:   bridge window [mem 0xe3200000-0xe6ffffff]
[   23.766372] pci 0000:2a:05.0:   bridge window [mem 0xa1200000-0xa1ffffff 64bit pref]
[   23.774363] pci 0000:29:00.0: PCI bridge to [bus 2a-4a]
[   23.779837] pci 0000:29:00.0:   bridge window [mem 0xdf000000-0xe6ffffff]
[   23.786870] pci 0000:29:00.0:   bridge window [mem 0xa0000000-0xa1ffffff 64bit pref]
[   23.794861] pcieport 0000:04:04.0: PCI bridge to [bus 29-4a]
[   23.800772] pcieport 0000:04:04.0:   bridge window [mem 0xdf000000-0xe6ffffff]
[   23.808245] pcieport 0000:04:04.0:   bridge window [mem 0xa0000000-0xa1ffffff 64bit pref]
[   23.816688] pcieport 0000:29:00.0: enabling device (0000 -> 0002)
[   23.823360] pcieport 0000:2a:00.0: enabling device (0000 -> 0002)
[   23.829982] pcieport 0000:2a:01.0: enabling device (0000 -> 0002)
[   23.836634] pcieport 0000:2a:02.0: enabling device (0000 -> 0002)
[   23.843260] pcieport 0000:2a:04.0: enabling device (0000 -> 0002)
[   23.849665] pcieport 0000:2a:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[   23.865838] pcieport 0000:2a:05.0: enabling device (0000 -> 0002)
[   23.872192] sched: RT throttling activated
[   23.921187] pcieport 0000:2a:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[   23.937469] pcieport 0000:2b:00.0: enabling device (0000 -> 0002)
[   23.943922] pcieport 0000:2c:03.0: enabling device (0000 -> 0002)
[   23.950405] pci 0000:2d:00.0: MSI is not implemented on this device, disabling it
[   23.958155] pci 0000:2d:00.0: PME# is unreliable, disabling it
[   23.964245] pci 0000:2d:00.0: pci_fixup_no_msi_no_pme+0x0/0x3b took 13516 usecs
[   23.971832] pci 0000:2d:00.0: enabling device (0000 -> 0002)
[   23.977881] ohci-pci 0000:2d:00.0: OHCI PCI host controller
[   23.983719] ohci-pci 0000:2d:00.0: new USB bus registered, assigned bus number 9
[   23.991419] ohci-pci 0000:2d:00.0: irq 122, io mem 0xdf000000
[   24.064845] usb usb9: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.19
[   24.073419] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   24.080906] usb usb9: Product: OHCI PCI host controller
[   24.086401] usb usb9: Manufacturer: Linux 5.19.0+ ohci_hcd
[   24.092159] usb usb9: SerialNumber: 0000:2d:00.0
[   24.097139] hub 9-0:1.0: USB hub found
[   24.101170] hub 9-0:1.0: 2 ports detected
[   24.105531] pci 0000:2d:00.1: MSI is not implemented on this device, disabling it
[   24.113275] pci 0000:2d:00.1: PME# is unreliable, disabling it
[   24.119376] pci 0000:2d:00.1: pci_fixup_no_msi_no_pme+0x0/0x3b took 13520 usecs
[   24.126967] pci 0000:2d:00.1: enabling device (0000 -> 0002)
[   24.133052] ohci-pci 0000:2d:00.1: OHCI PCI host controller
[   24.138924] ohci-pci 0000:2d:00.1: new USB bus registered, assigned bus number 10
[   24.146695] ohci-pci 0000:2d:00.1: irq 25, io mem 0xdf001000
[   24.224859] usb usb10: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.19
[   24.233531] usb usb10: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   24.241106] usb usb10: Product: OHCI PCI host controller
[   24.246698] usb usb10: Manufacturer: Linux 5.19.0+ ohci_hcd
[   24.252548] usb usb10: SerialNumber: 0000:2d:00.1
[   24.257622] hub 10-0:1.0: USB hub found
[   24.261753] hub 10-0:1.0: 2 ports detected
[   24.266182] pci 0000:2d:00.2: MSI is not implemented on this device, disabling it
[   24.273937] pci 0000:2d:00.2: PME# is unreliable, disabling it
[   24.280044] pci 0000:2d:00.2: pci_fixup_no_msi_no_pme+0x0/0x3b took 13537 usecs
[   24.287969] pci 0000:2d:00.2: enabling device (0000 -> 0002)
[   24.293978] pci 0000:2d:00.2: EHCI: unrecognized capability 00
[   24.300110] pci 0000:2d:00.2: quirk_usb_early_handoff+0x0/0x770 took 12193 usecs
[   24.307919] ehci-pci 0000:2d:00.2: EHCI Host Controller
[   24.313439] ehci-pci 0000:2d:00.2: new USB bus registered, assigned bus number 11
[   24.321355] ehci-pci 0000:2d:00.2: irq 34, io mem 0xdf002000
[   24.350726] ehci-pci 0000:2d:00.2: USB 2.0 started, EHCI 1.00
[   24.356841] usb usb11: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.19
[   24.365471] usb usb11: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   24.373055] usb usb11: Product: EHCI Host Controller
[   24.378309] usb usb11: Manufacturer: Linux 5.19.0+ ehci_hcd
[   24.384167] usb usb11: SerialNumber: 0000:2d:00.2
[   24.389244] hub 11-0:1.0: USB hub found
[   24.393371] hub 11-0:1.0: 4 ports detected
[   24.510576] hub 9-0:1.0: USB hub found
[   24.514685] hub 9-0:1.0: 2 ports detected
[   24.630751] hub 10-0:1.0: USB hub found
[   24.634943] hub 10-0:1.0: 2 ports detected
[   24.639409] tg3 0000:2e:00.0: enabling device (0000 -> 0002)
[   24.690501] usb 11-1: new high-speed USB device number 2 using ehci-pci
[   24.699687] tg3 0000:2e:00.0 eth2: Tigon3 [partno(BCM957761) rev 57785100] (PCI Express) MAC address c8:2a:14:4f:80:3e
[   24.700858] tg3 0000:2e:00.0 eth4: renamed from eth2
[   24.710651] tg3 0000:2e:00.0 eth4: attached PHY is 57765 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[   24.726014] tg3 0000:2e:00.0 eth4: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[   24.734133] tg3 0000:2e:00.0 eth4: dma_rwctrl[00000001] dma_mask[64-bit]
[   24.920892] usb 11-1: New USB device found, idVendor=05ac, idProduct=9127, bcdDevice= 1.00
[   24.929495] usb 11-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   24.937362] hub 11-1:1.0: USB hub found
[   24.941643] hub 11-1:1.0: 7 ports detected
[   25.147080] EXT4-fs (dm-0): re-mounted. Quota mode: none.
[   25.270745] usb 11-1.4: new full-speed USB device number 3 using ehci-pci
[   25.439933] usb 11-1.4: New USB device found, idVendor=05ac, idProduct=1107, bcdDevice= 2.09
[   25.448691] usb 11-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   25.448692] usb 11-1.4: Product: Display Audio
[   25.448693] usb 11-1.4: Manufacturer: Apple Inc.
[   25.448693] usb 11-1.4: SerialNumber: 152303D9
[   25.449340] EXT4-fs (nvme0n1p2): mounted filesystem with ordered data mode. Quota mode: none.
[   25.460044] input: Apple Inc. Display Audio as /devices/pci0000:00/0000:00:02.1/0000:01:00.2/0000:02:00.0/0000:03:00.0/0000:04:04.0/0000:29:00.0/0000:2a:00.0/0000:2b:00.0/0000:2c:03.0/0000:2d:00.2/usb11/11-1/11-1.4/11-1.4:1.3/0003:05AC:1107.0005/input/input16
[   25.466613] EXT4-fs (dm-1): mounted filesystem with ordered data mode. Quota mode: none.
[   25.466667] hid-generic 0003:05AC:1107.0005: input,hidraw4: USB HID v1.11 Device [Apple Inc. Display Audio] on usb-0000:2d:00.2-1.4/input3
[   25.476018] Adding 134217724k swap on /dev/mapper/swap.  Priority:-2 extents:1 across:134217724k SS
[   25.550072] usb 11-1.4: 1:1: cannot get freq at ep 0x4
[   25.590730] usb 11-1.5: new high-speed USB device number 4 using ehci-pci
[   25.718274] usb 11-1.4: 1:2: cannot get freq at ep 0x4
[   25.732102] usb 11-1.4: 2:1: cannot get freq at ep 0x84
[   25.758282] usb 11-1.5: New USB device found, idVendor=05ac, idProduct=1112, bcdDevice=71.60
[   25.767119] usb 11-1.5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   25.774850] usb 11-1.5: Product: FaceTime HD Camera (Display)
[   25.775129] usb 11-1.4: Warning! Unlikely big volume range (=16384), cval->res is probably wrong.
[   25.775212] usb 11-1.5: Manufacturer: Apple Inc.
[   25.775671] usb 11-1.4: [2] FU [PCM Playback Volume] ch = 2, val = -16384/0/1
[   25.776033] usb 11-1.5: SerialNumber: CCGB690CKUDJ9DFX
[   25.810134] usb 11-1.4: Warning! Unlikely big volume range (=15872), cval->res is probably wrong.
[   25.819451] usb 11-1.4: [5] FU [Mic Capture Volume] ch = 1, val = -11264/4608/1
[   25.827240] usbcore: registered new interface driver snd-usb-audio
[   25.987546] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[   26.002720] br1: port 1(eth0) entered blocking state
[   26.008052] br1: port 1(eth0) entered disabled state
[   26.013404] device eth0 entered promiscuous mode
[   26.070746] usb 11-1.7: new full-speed USB device number 5 using ehci-pci
[   26.095131] br1: port 2(eth1) entered blocking state
[   26.100541] br1: port 2(eth1) entered disabled state
[   26.105903] device eth1 entered promiscuous mode
[   26.150712] RTL8226B_RTL8221B 2.5Gbps PHY r8169-0-4e00:00: attached PHY driver (mii_bus:phy_addr=r8169-0-4e00:00, irq=MAC)
[   26.254413] usb 11-1.7: New USB device found, idVendor=05ac, idProduct=9227, bcdDevice= 1.37
[   26.263274] usb 11-1.7: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   26.271029] usb 11-1.7: Product: Apple Thunderbolt Display
[   26.276879] usb 11-1.7: Manufacturer: Apple Inc.
[   26.281863] usb 11-1.7: SerialNumber: 152303D9
[   26.288232] hid-generic 0003:05AC:9227.0006: hiddev97,hidraw5: USB HID v1.11 Device [Apple Inc. Apple Thunderbolt Display] on usb-0000:2d:00.2-1.7/input0
[   26.430872] r8169 0000:4e:00.0 eth1: Link is Down
[   26.458567] NET: Registered PF_PACKET protocol family
[   29.298793] r8169 0000:4e:00.0 eth1: Link is Up - 1Gbps/Full - flow control off
[   29.306538] br1: port 2(eth1) entered blocking state
[   29.311875] br1: port 2(eth1) entered forwarding state
[   37.119715] RPC: Registered named UNIX socket transport module.
[   37.126020] RPC: Registered udp transport module.
[   37.131100] RPC: Registered tcp transport module.
[   37.136169] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   37.146613] FS-Cache: Loaded
[   37.169925] Key type dns_resolver registered
[   37.177860] NFS: Registering the id_resolver key type
[   37.183286] Key type id_resolver registered
[   37.187835] Key type id_legacy registered
[   44.330649] fuse: init (API version 7.36)
[   54.881506] br1: port 2(eth1) entered disabled state
[   54.928324] device eth0 left promiscuous mode
[   54.932685] br1: port 1(eth0) entered disabled state
[   55.021435] r8169 0000:4e:00.0 eth1: Link is Down
[   55.026955] device eth1 left promiscuous mode
[   55.031359] br1: port 2(eth1) entered disabled state
[   55.459255] EXT4-fs (dm-1): unmounting filesystem.
[   55.491405] EXT4-fs (nvme0n1p2): unmounting filesystem.
[   55.850740] EXT4-fs (dm-0): re-mounted. Quota mode: none.
[   55.864100] kvm: exiting hardware virtualization
[   57.751966] [drm] free PSP TMR buffer
[   58.521458] thunderbolt 0-3: device disconnected
[   58.527324] reboot: Restarting system
[   58.530986] reboot: machine restart
[    0.000000] Linux version 5.19.0+ (brad@bkd) (gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2) #55 SMP PREEMPT_DYNAMIC Sat Aug 6 16:55:17 AWST 2022
[    0.000000] Command line: ro root=UUID=c6cf971d-5412-4826-851d-5677ad7997c0 thunderbolt.dyndbg pcie_port_pm=off console=ttyS0,115200 console=tty0 nogpu initrd=\initrd.img-5.19.0+
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
[    0.000000] x86/fpu: Enabled xstate features 0x207, context size is 840 bytes, using 'compacted' format.
[    0.000000] signal: max sigframe size: 3376
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009c3efff] usable
[    0.000000] BIOS-e820: [mem 0x0000000009c3f000-0x0000000009ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000000a000000-0x000000000a1fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000000a200000-0x000000000a20cfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000000a20d000-0x000000000affffff] usable
[    0.000000] BIOS-e820: [mem 0x000000000b000000-0x000000000b01ffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000000b020000-0x000000007a076fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007a077000-0x000000007a077fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007a078000-0x000000007a098fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007a099000-0x000000007a099fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007a09a000-0x000000009754cfff] usable
[    0.000000] BIOS-e820: [mem 0x000000009754d000-0x000000009a086fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000009a087000-0x000000009a0ddfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000009a0de000-0x000000009bb5bfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000009bb5c000-0x000000009cdfefff] reserved
[    0.000000] BIOS-e820: [mem 0x000000009cdff000-0x000000009dffffff] usable
[    0.000000] BIOS-e820: [mem 0x000000009e000000-0x000000009fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f0000000-0x00000000f7ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fd200000-0x00000000fd2fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fd600000-0x00000000fd6fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fea00000-0x00000000fea0ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feb80000-0x00000000fec01fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec30000-0x00000000fec30fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedc2000-0x00000000fedcffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedd4000-0x00000000fedd5fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000083e2fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000083e300000-0x000000085fffffff] reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] reserve setup_data: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x0000000009c3efff] usable
[    0.000000] reserve setup_data: [mem 0x0000000009c3f000-0x0000000009ffffff] reserved
[    0.000000] reserve setup_data: [mem 0x000000000a000000-0x000000000a1fffff] usable
[    0.000000] reserve setup_data: [mem 0x000000000a200000-0x000000000a20cfff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000000a20d000-0x000000000affffff] usable
[    0.000000] reserve setup_data: [mem 0x000000000b000000-0x000000000b01ffff] reserved
[    0.000000] reserve setup_data: [mem 0x000000000b020000-0x000000007a076fff] usable
[    0.000000] reserve setup_data: [mem 0x000000007a077000-0x000000007a077fff] reserved
[    0.000000] reserve setup_data: [mem 0x000000007a078000-0x000000007a098fff] usable
[    0.000000] reserve setup_data: [mem 0x000000007a099000-0x000000007a099fff] reserved
[    0.000000] reserve setup_data: [mem 0x000000007a09a000-0x00000000936da017] usable
[    0.000000] reserve setup_data: [mem 0x00000000936da018-0x00000000936e7857] usable
[    0.000000] reserve setup_data: [mem 0x00000000936e7858-0x0000000093717017] usable
[    0.000000] reserve setup_data: [mem 0x0000000093717018-0x0000000093726057] usable
[    0.000000] reserve setup_data: [mem 0x0000000093726058-0x0000000093ca5017] usable
[    0.000000] reserve setup_data: [mem 0x0000000093ca5018-0x0000000093cb2857] usable
[    0.000000] reserve setup_data: [mem 0x0000000093cb2858-0x000000009754cfff] usable
[    0.000000] reserve setup_data: [mem 0x000000009754d000-0x000000009a086fff] reserved
[    0.000000] reserve setup_data: [mem 0x000000009a087000-0x000000009a0ddfff] ACPI data
[    0.000000] reserve setup_data: [mem 0x000000009a0de000-0x000000009bb5bfff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000009bb5c000-0x000000009cdfefff] reserved
[    0.000000] reserve setup_data: [mem 0x000000009cdff000-0x000000009dffffff] usable
[    0.000000] reserve setup_data: [mem 0x000000009e000000-0x000000009fffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000f0000000-0x00000000f7ffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fd200000-0x00000000fd2fffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fd600000-0x00000000fd6fffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fea00000-0x00000000fea0ffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000feb80000-0x00000000fec01fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec30000-0x00000000fec30fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed40000-0x00000000fed44fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed80000-0x00000000fed8ffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fedc2000-0x00000000fedcffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fedd4000-0x00000000fedd5fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000083e2fffff] usable
[    0.000000] reserve setup_data: [mem 0x000000083e300000-0x000000085fffffff] reserved
[    0.000000] efi: EFI v2.70 by American Megatrends
[    0.000000] efi: ACPI=0x9bb45000 ACPI 2.0=0x9bb45014 SMBIOS=0x9cc2b000 SMBIOS 3.0=0x9cc2a000 MEMATTR=0x93cb3018 ESRT=0x96088c18 RNG=0x9cc27498
[    0.000000] efi: seeding entropy pool
[    0.000000] SMBIOS 3.3.0 present.
[    0.000000] DMI: Gigabyte Technology Co., Ltd. B550 VISION D-P/B550 VISION D-P, BIOS F15d 07/20/2022
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3900.238 MHz processor
[    0.000132] last_pfn = 0x83e300 max_arch_pfn = 0x400000000
[    0.000272] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.000401] last_pfn = 0x9e000 max_arch_pfn = 0x400000000
[    0.000407] esrt: Reserving ESRT space from 0x0000000096088c18 to 0x0000000096088c50.
[    0.000461] Using GB pages for direct mapping
[    0.001215] Secure boot disabled
[    0.001216] RAMDISK: [mem 0x7f171000-0x7fffffff]
[    0.001219] ACPI: Early table checksum verification disabled
[    0.001220] ACPI: RSDP 0x000000009BB45014 000024 (v02 ALASKA)
[    0.001222] ACPI: XSDT 0x000000009BB44728 0000D4 (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.001225] ACPI: FACP 0x000000009A0C5000 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
[    0.001228] ACPI: DSDT 0x000000009A096000 006227 (v02 ALASKA A M I    01072009 INTL 20190509)
[    0.001229] ACPI: FACS 0x000000009AB3F000 000040
[    0.001230] ACPI: SSDT 0x000000009A0D4000 009FFD (v02 GBT    GSWApp   00000001 INTL 20190509)
[    0.001231] ACPI: IVRS 0x000000009A0D3000 0000D0 (v02 AMD    AmdTable 00000001 AMD  00000001)
[    0.001232] ACPI: SSDT 0x000000009A0CB000 0072B0 (v02 AMD    Artic    00000002 MSFT 04000000)
[    0.001233] ACPI: SSDT 0x000000009A0C7000 003D74 (v01 AMD    AMD AOD  00000001 INTL 20190509)
[    0.001234] ACPI: SSDT 0x000000009A0C6000 0001AD (v02 ALASKA CPUSSDT  01072009 AMI  01072009)
[    0.001235] ACPI: FIDT 0x000000009A0BE000 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.001236] ACPI: MCFG 0x000000009A0BD000 00003C (v01 ALASKA A M I    01072009 MSFT 00010013)
[    0.001237] ACPI: HPET 0x000000009A0BC000 000038 (v01 ALASKA A M I    01072009 AMI  00000005)
[    0.001238] ACPI: FPDT 0x000000009A0BB000 000044 (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.001240] ACPI: VFCT 0x000000009A0AD000 00D884 (v01 ALASKA A M I    00000001 AMD  31504F47)
[    0.001241] ACPI: SSDT 0x000000009A0A9000 003E88 (v02 AMD    AmdTable 00000001 AMD  00000001)
[    0.001242] ACPI: CRAT 0x000000009A0A8000 000B68 (v01 AMD    AmdTable 00000001 AMD  00000001)
[    0.001243] ACPI: CDIT 0x000000009A0A7000 000029 (v01 AMD    AmdTable 00000001 AMD  00000001)
[    0.001244] ACPI: SSDT 0x000000009A0A5000 001486 (v01 AMD    ArticIG2 00000001 INTL 20190509)
[    0.001245] ACPI: SSDT 0x000000009A0A3000 0014FD (v01 AMD    ArticTPX 00000001 INTL 20190509)
[    0.001246] ACPI: SSDT 0x000000009A09F000 0039F7 (v01 AMD    ArticN   00000001 INTL 20190509)
[    0.001247] ACPI: WSMT 0x000000009A09E000 000028 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.001248] ACPI: APIC 0x000000009A09D000 00015E (v04 ALASKA A M I    01072009 AMI  00010013)
[    0.001249] ACPI: SSDT 0x000000009A0C4000 0008A4 (v01 AMD    ArticPRN 00000001 INTL 20190509)
[    0.001250] ACPI: SSDT 0x000000009A0C2000 00147F (v01 AMD    ArticC   00000001 INTL 20190509)
[    0.001251] ACPI: SSDT 0x000000009A0C1000 0000BF (v01 AMD    AmdTable 00001000 INTL 20190509)
[    0.001252] ACPI: Reserving FACP table memory at [mem 0x9a0c5000-0x9a0c5113]
[    0.001252] ACPI: Reserving DSDT table memory at [mem 0x9a096000-0x9a09c226]
[    0.001253] ACPI: Reserving FACS table memory at [mem 0x9ab3f000-0x9ab3f03f]
[    0.001253] ACPI: Reserving SSDT table memory at [mem 0x9a0d4000-0x9a0ddffc]
[    0.001254] ACPI: Reserving IVRS table memory at [mem 0x9a0d3000-0x9a0d30cf]
[    0.001254] ACPI: Reserving SSDT table memory at [mem 0x9a0cb000-0x9a0d22af]
[    0.001254] ACPI: Reserving SSDT table memory at [mem 0x9a0c7000-0x9a0cad73]
[    0.001255] ACPI: Reserving SSDT table memory at [mem 0x9a0c6000-0x9a0c61ac]
[    0.001255] ACPI: Reserving FIDT table memory at [mem 0x9a0be000-0x9a0be09b]
[    0.001256] ACPI: Reserving MCFG table memory at [mem 0x9a0bd000-0x9a0bd03b]
[    0.001256] ACPI: Reserving HPET table memory at [mem 0x9a0bc000-0x9a0bc037]
[    0.001256] ACPI: Reserving FPDT table memory at [mem 0x9a0bb000-0x9a0bb043]
[    0.001257] ACPI: Reserving VFCT table memory at [mem 0x9a0ad000-0x9a0ba883]
[    0.001257] ACPI: Reserving SSDT table memory at [mem 0x9a0a9000-0x9a0ace87]
[    0.001258] ACPI: Reserving CRAT table memory at [mem 0x9a0a8000-0x9a0a8b67]
[    0.001258] ACPI: Reserving CDIT table memory at [mem 0x9a0a7000-0x9a0a7028]
[    0.001258] ACPI: Reserving SSDT table memory at [mem 0x9a0a5000-0x9a0a6485]
[    0.001259] ACPI: Reserving SSDT table memory at [mem 0x9a0a3000-0x9a0a44fc]
[    0.001259] ACPI: Reserving SSDT table memory at [mem 0x9a09f000-0x9a0a29f6]
[    0.001260] ACPI: Reserving WSMT table memory at [mem 0x9a09e000-0x9a09e027]
[    0.001260] ACPI: Reserving APIC table memory at [mem 0x9a09d000-0x9a09d15d]
[    0.001260] ACPI: Reserving SSDT table memory at [mem 0x9a0c4000-0x9a0c48a3]
[    0.001261] ACPI: Reserving SSDT table memory at [mem 0x9a0c2000-0x9a0c347e]
[    0.001261] ACPI: Reserving SSDT table memory at [mem 0x9a0c1000-0x9a0c10be]
[    0.001278] No NUMA configuration found
[    0.001278] Faking a node at [mem 0x0000000000000000-0x000000083e2fffff]
[    0.001280] NODE_DATA(0) allocated [mem 0x83e2fe000-0x83e2fffff]
[    0.001295] Zone ranges:
[    0.001296]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.001297]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.001297]   Normal   [mem 0x0000000100000000-0x000000083e2fffff]
[    0.001298] Movable zone start for each node
[    0.001298] Early memory node ranges
[    0.001298]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.001299]   node   0: [mem 0x0000000000100000-0x0000000009c3efff]
[    0.001300]   node   0: [mem 0x000000000a000000-0x000000000a1fffff]
[    0.001300]   node   0: [mem 0x000000000a20d000-0x000000000affffff]
[    0.001300]   node   0: [mem 0x000000000b020000-0x000000007a076fff]
[    0.001301]   node   0: [mem 0x000000007a078000-0x000000007a098fff]
[    0.001301]   node   0: [mem 0x000000007a09a000-0x000000009754cfff]
[    0.001301]   node   0: [mem 0x000000009cdff000-0x000000009dffffff]
[    0.001302]   node   0: [mem 0x0000000100000000-0x000000083e2fffff]
[    0.001303] Initmem setup node 0 [mem 0x0000000000001000-0x000000083e2fffff]
[    0.001305] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.001314] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.001391] On node 0, zone DMA32: 961 pages in unavailable ranges
[    0.001399] On node 0, zone DMA32: 13 pages in unavailable ranges
[    0.002748] On node 0, zone DMA32: 32 pages in unavailable ranges
[    0.002748] On node 0, zone DMA32: 1 pages in unavailable ranges
[    0.003219] On node 0, zone DMA32: 1 pages in unavailable ranges
[    0.003338] On node 0, zone DMA32: 22706 pages in unavailable ranges
[    0.032275] On node 0, zone Normal: 8192 pages in unavailable ranges
[    0.032309] On node 0, zone Normal: 7424 pages in unavailable ranges
[    0.034090] ACPI: PM-Timer IO Port: 0x808
[    0.034094] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.034104] IOAPIC[0]: apic_id 13, version 33, address 0xfec00000, GSI 0-23
[    0.034109] IOAPIC[1]: apic_id 14, version 33, address 0xfec01000, GSI 24-55
[    0.034111] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.034112] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.034114] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.034114] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    0.034116] smpboot: 32 Processors exceeds NR_CPUS limit of 16
[    0.034117] smpboot: Allowing 16 CPUs, 4 hotplug CPUs
[    0.034138] [mem 0xa0000000-0xefffffff] available for PCI devices
[    0.034140] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.035481] setup_percpu: NR_CPUS:16 nr_cpumask_bits:16 nr_cpu_ids:16 nr_node_ids:1
[    0.035712] percpu: Embedded 44 pages/cpu s139880 r8192 d32152 u262144
[    0.035733] Fallback order for Node 0: 0
[    0.035735] Built 1 zonelists, mobility grouping on.  Total pages: 8089540
[    0.035735] Policy zone: Normal
[    0.035736] Kernel command line: ro root=UUID=c6cf971d-5412-4826-851d-5677ad7997c0 thunderbolt.dyndbg pcie_port_pm=off console=ttyS0,115200 console=tty0 nogpu initrd=\initrd.img-5.19.0+
[    0.035759] Unknown kernel command line parameters "nogpu", will be passed to user space.
[    0.036423] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.036756] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.036779] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.074914] Memory: 32128108K/32872436K available (8192K kernel code, 2309K rwdata, 1868K rodata, 952K init, 944K bss, 744072K reserved, 0K cma-reserved)
[    0.074939] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.075134] Dynamic Preempt: voluntary
[    0.075157] rcu: Preemptible hierarchical RCU implementation.
[    0.075158] rcu: 	RCU event tracing is enabled.
[    0.075159] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.075171] NR_IRQS: 4352, nr_irqs: 1096, preallocated irqs: 16
[    0.075359] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.075411] Console: colour dummy device 80x25
[    0.075577] printk: console [tty0] enabled
[    1.565032] printk: console [ttyS0] enabled
[    1.569209] ACPI: Core revision 20220331
[    1.573245] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    1.582358] APIC: Switch to symmetric I/O mode setup
[    1.587304] Switched APIC routing to physical flat.
[    1.592751] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    1.642359] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x7070762be1e, max_idle_ns: 881590686392 ns
[    1.652841] Calibrating delay loop (skipped), value calculated using timer frequency.. 7800.47 BogoMIPS (lpj=39002380)
[    1.662839] pid_max: default: 32768 minimum: 301
[    1.668748] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    1.672869] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    1.682921] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    1.689441] LVT offset 1 assigned for vector 0xf9
[    1.692894] LVT offset 2 assigned for vector 0xf4
[    1.697595] process: using mwait in idle threads
[    1.702839] Last level iTLB entries: 4KB 512, 2MB 512, 4MB 256
[    1.708647] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 1GB 0
[    1.712840] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    1.722839] Spectre V2 : Kernel not compiled with retpoline; no mitigation available!
[    1.722840] Spectre V2 : Vulnerable
[    1.736313] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    1.742839] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    1.752839] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    1.761245] Spectre V2 : User space: Mitigation: STIBP always-on protection
[    1.762839] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    1.773001] Freeing SMP alternatives memory: 24K
[    1.902284] smpboot: CPU0: AMD Ryzen 5 5600G with Radeon Graphics (family: 0x19, model: 0x50, stepping: 0x0)
[    1.902838] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
[    1.902839] ... version:                0
[    1.912839] ... bit width:              48
[    1.916916] ... generic registers:      6
[    1.920907] ... value mask:             0000ffffffffffff
[    1.922839] ... max period:             00007fffffffffff
[    1.928135] ... fixed-purpose events:   0
[    1.932839] ... event mask:             000000000000003f
[    1.938167] rcu: Hierarchical SRCU implementation.
[    1.942839] rcu: 	Max phase no-delay instances is 1000.
[    1.948253] smp: Bringing up secondary CPUs ...
[    1.952895] x86: Booting SMP configuration:
[    1.957064] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6
[    1.972868] Spectre V2 : Update user space SMT mitigation: STIBP always-on
[    1.982911]   #7  #8  #9 #10 #11
[    1.994985] smp: Brought up 1 node, 12 CPUs
[    2.002840] smpboot: Max logical packages: 3
[    2.007097] smpboot: Total of 12 processors activated (93605.71 BogoMIPS)
[    2.013464] devtmpfs: initialized
[    2.016226] ACPI: PM: Registering ACPI NVS region [mem 0x0a200000-0x0a20cfff] (53248 bytes)
[    2.022840] ACPI: PM: Registering ACPI NVS region [mem 0x9a0de000-0x9bb5bfff] (27779072 bytes)
[    2.033062] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    2.042841] futex hash table entries: 4096 (order: 6, 262144 bytes, linear)
[    2.053054] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    2.059005] thermal_sys: Registered thermal governor 'step_wise'
[    2.059005] thermal_sys: Registered thermal governor 'user_space'
[    2.062849] cpuidle: using governor ladder
[    2.072848] cpuidle: using governor menu
[    2.076765] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    2.082855] PCI: MMCONFIG for domain 0000 [bus 00-7f] at [mem 0xf0000000-0xf7ffffff] (base 0xf0000000)
[    2.092840] PCI: MMCONFIG at [mem 0xf0000000-0xf7ffffff] reserved in E820
[    2.099612] PCI: Using configuration type 1 for base access
[    2.103301] ACPI: Added _OSI(Module Device)
[    2.107034] ACPI: Added _OSI(Processor Device)
[    2.112839] ACPI: Added _OSI(3.0 _SCP Extensions)
[    2.117521] ACPI: Added _OSI(Processor Aggregator Device)
[    2.122839] ACPI: Added _OSI(Linux-Dell-Video)
[    2.127262] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    2.132839] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    2.146919] ACPI: 12 ACPI AML tables successfully acquired and loaded
[    2.153537] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    2.164556] ACPI: Interpreter enabled
[    2.168215] ACPI: PM: (supports S0 S3 S5)
[    2.172211] ACPI: Using IOAPIC for interrupt routing
[    2.173003] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    2.182839] PCI: Using E820 reservations for host bridge windows
[    2.189019] ACPI: Enabled 7 GPEs in block 00 to 1F
[    2.196656] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    2.202841] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    2.212893] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability LTR]
[    2.222843] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-7f] only partially covers this bridge
[    2.232954] PCI host bridge to bus 0000:00
[    2.237037] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    2.242839] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    2.252839] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    2.259603] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    2.262839] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000dffff window]
[    2.272839] pci_bus 0000:00: root bus resource [mem 0xa0000000-0xefffffff window]
[    2.280293] pci_bus 0000:00: root bus resource [bus 00-ff]
[    2.282848] pci 0000:00:00.0: [1022:1630] type 00 class 0x060000
[    2.292894] pci 0000:00:00.2: [1022:1631] type 00 class 0x080600
[    2.298944] pci 0000:00:01.0: [1022:1632] type 00 class 0x060000
[    2.302878] pci 0000:00:02.0: [1022:1632] type 00 class 0x060000
[    2.308893] pci 0000:00:02.1: [1022:1634] type 01 class 0x060400
[    2.312859] pci 0000:00:02.1: enabling Extended Tags
[    2.317840] pci 0000:00:02.1: PME# supported from D0 D3hot D3cold
[    2.322884] pci 0000:00:02.2: [1022:1634] type 01 class 0x060400
[    2.332887] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
[    2.338999] pci 0000:00:08.0: [1022:1632] type 00 class 0x060000
[    2.342872] pci 0000:00:08.1: [1022:1635] type 01 class 0x060400
[    2.348867] pci 0000:00:08.1: enabling Extended Tags
[    2.352864] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    2.362896] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
[    2.368970] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
[    2.372936] pci 0000:00:18.0: [1022:166a] type 00 class 0x060000
[    2.378935] pci 0000:00:18.1: [1022:166b] type 00 class 0x060000
[    2.382854] pci 0000:00:18.2: [1022:166c] type 00 class 0x060000
[    2.392855] pci 0000:00:18.3: [1022:166d] type 00 class 0x060000
[    2.398849] pci 0000:00:18.4: [1022:166e] type 00 class 0x060000
[    2.402854] pci 0000:00:18.5: [1022:166f] type 00 class 0x060000
[    2.408852] pci 0000:00:18.6: [1022:1670] type 00 class 0x060000
[    2.412854] pci 0000:00:18.7: [1022:1671] type 00 class 0x060000
[    2.422899] pci 0000:01:00.0: [1022:43ee] type 00 class 0x0c0330
[    2.428902] pci 0000:01:00.0: reg 0x10: [mem 0xef7a0000-0xef7a7fff 64bit]
[    2.432874] pci 0000:01:00.0: enabling Extended Tags
[    2.437865] pci 0000:01:00.0: PME# supported from D3hot D3cold
[    2.442902] pci 0000:01:00.1: [1022:43eb] type 00 class 0x010601
[    2.452880] pci 0000:01:00.1: reg 0x24: [mem 0xef780000-0xef79ffff]
[    2.459125] pci 0000:01:00.1: reg 0x30: [mem 0xef700000-0xef77ffff pref]
[    2.462843] pci 0000:01:00.1: enabling Extended Tags
[    2.467827] pci 0000:01:00.1: PME# supported from D3hot D3cold
[    2.472885] pci 0000:01:00.2: [1022:43e9] type 01 class 0x060400
[    2.482876] pci 0000:01:00.2: enabling Extended Tags
[    2.487864] pci 0000:01:00.2: PME# supported from D3hot D3cold
[    2.492890] pci 0000:00:02.1: PCI bridge to [bus 01-51]
[    2.498102] pci 0000:00:02.1:   bridge window [io  0xf000-0xffff]
[    2.502840] pci 0000:00:02.1:   bridge window [mem 0xdf000000-0xef7fffff]
[    2.509605] pci 0000:00:02.1:   bridge window [mem 0xa0000000-0xb1ffffff 64bit pref]
[    2.512898] pci 0000:02:00.0: [1022:43ea] type 01 class 0x060400
[    2.522880] pci 0000:02:00.0: enabling Extended Tags
[    2.527872] pci 0000:02:00.0: PME# supported from D3hot D3cold
[    2.532894] pci 0000:02:04.0: [1022:43ea] type 01 class 0x060400
[    2.538916] pci 0000:02:04.0: enabling Extended Tags
[    2.542888] pci 0000:02:04.0: PME# supported from D3hot D3cold
[    2.552892] pci 0000:02:08.0: [1022:43ea] type 01 class 0x060400
[    2.558920] pci 0000:02:08.0: enabling Extended Tags
[    2.562888] pci 0000:02:08.0: PME# supported from D3hot D3cold
[    2.568747] pci 0000:02:09.0: [1022:43ea] type 01 class 0x060400
[    2.572880] pci 0000:02:09.0: enabling Extended Tags
[    2.577873] pci 0000:02:09.0: PME# supported from D3hot D3cold
[    2.582898] pci 0000:01:00.2: PCI bridge to [bus 02-51]
[    2.588105] pci 0000:01:00.2:   bridge window [io  0xf000-0xffff]
[    2.592840] pci 0000:01:00.2:   bridge window [mem 0xdf000000-0xef6fffff]
[    2.602842] pci 0000:01:00.2:   bridge window [mem 0xa0000000-0xb1ffffff 64bit pref]
[    2.612895] pci 0000:03:00.0: [8086:15ea] type 01 class 0x060400
[    2.618942] pci 0000:03:00.0: enabling Extended Tags
[    2.622969] pci 0000:03:00.0: supports D1 D2
[    2.627221] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    2.632928] pci 0000:02:00.0: PCI bridge to [bus 03-4a]
[    2.638140] pci 0000:02:00.0:   bridge window [mem 0xdf000000-0xef1fffff]
[    2.642842] pci 0000:02:00.0:   bridge window [mem 0xa0000000-0xb1ffffff 64bit pref]
[    2.652910] pci 0000:04:00.0: [8086:15ea] type 01 class 0x060400
[    2.658962] pci 0000:04:00.0: enabling Extended Tags
[    2.662972] pci 0000:04:00.0: supports D1 D2
[    2.667228] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    2.672935] pci 0000:04:01.0: [8086:15ea] type 01 class 0x060400
[    2.682907] pci 0000:04:01.0: enabling Extended Tags
[    2.687982] pci 0000:04:01.0: supports D1 D2
[    2.692239] pci 0000:04:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    2.692933] pci 0000:04:02.0: [8086:15ea] type 01 class 0x060400
[    2.702907] pci 0000:04:02.0: enabling Extended Tags
[    2.707980] pci 0000:04:02.0: supports D1 D2
[    2.712839] pci 0000:04:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    2.719526] pci 0000:04:04.0: [8086:15ea] type 01 class 0x060400
[    2.722907] pci 0000:04:04.0: enabling Extended Tags
[    2.727979] pci 0000:04:04.0: supports D1 D2
[    2.732839] pci 0000:04:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    2.742946] pci 0000:03:00.0: PCI bridge to [bus 04-4a]
[    2.748160] pci 0000:03:00.0:   bridge window [mem 0xdf000000-0xef1fffff]
[    2.752845] pci 0000:03:00.0:   bridge window [mem 0xa0000000-0xb1ffffff 64bit pref]
[    2.762876] pci 0000:05:00.0: [8086:15eb] type 00 class 0x088000
[    2.768883] pci 0000:05:00.0: reg 0x10: [mem 0xef100000-0xef13ffff]
[    2.772848] pci 0000:05:00.0: reg 0x14: [mem 0xef140000-0xef140fff]
[    2.779148] pci 0000:05:00.0: enabling Extended Tags
[    2.782970] pci 0000:05:00.0: supports D1 D2
[    2.787227] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    2.792949] pci 0000:04:00.0: PCI bridge to [bus 05]
[    2.797903] pci 0000:04:00.0:   bridge window [mem 0xef100000-0xef1fffff]
[    2.802894] pci 0000:04:01.0: PCI bridge to [bus 06-27]
[    2.812848] pci 0000:04:01.0:   bridge window [mem 0xe7000000-0xeeffffff]
[    2.819619] pci 0000:04:01.0:   bridge window [mem 0xb0000000-0xb1ffffff 64bit pref]
[    2.822922] pci 0000:28:00.0: [8086:15ec] type 00 class 0x0c0330
[    2.832864] pci 0000:28:00.0: reg 0x10: [mem 0xef000000-0xef00ffff]
[    2.839196] pci 0000:28:00.0: enabling Extended Tags
[    2.842987] pci 0000:28:00.0: supports D1 D2
[    2.847246] pci 0000:28:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    2.852898] pci 0000:28:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:04:02.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
[    2.862894] pci 0000:04:02.0: PCI bridge to [bus 28]
[    2.872848] pci 0000:04:02.0:   bridge window [mem 0xef000000-0xef0fffff]
[    2.882941] pci 0000:29:00.0: [8086:1513] type 01 class 0x060400
[    2.889040] pci 0000:29:00.0: enabling Extended Tags
[    2.893007] pci 0000:29:00.0: supports D1 D2
[    2.897260] pci 0000:29:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    2.902970] pci 0000:04:04.0: PCI bridge to [bus 29-4a]
[    2.908185] pci 0000:04:04.0:   bridge window [mem 0xdf000000-0xe6ffffff]
[    2.912845] pci 0000:04:04.0:   bridge window [mem 0xa0000000-0xa1ffffff 64bit pref]
[    2.922951] pci 0000:2a:00.0: [8086:1513] type 01 class 0x060400
[    2.929056] pci 0000:2a:00.0: enabling Extended Tags
[    2.933010] pci 0000:2a:00.0: supports D1 D2
[    2.937264] pci 0000:2a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    2.942981] pci 0000:2a:01.0: [8086:1513] type 01 class 0x060400
[    2.952955] pci 0000:2a:01.0: enabling Extended Tags
[    2.958072] pci 0000:2a:01.0: supports D1 D2
[    2.962839] pci 0000:2a:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    2.969563] pci 0000:2a:02.0: [8086:1513] type 01 class 0x060400
[    2.972956] pci 0000:2a:02.0: enabling Extended Tags
[    2.978073] pci 0000:2a:02.0: supports D1 D2
[    2.982839] pci 0000:2a:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    2.989575] pci 0000:2a:04.0: [8086:1513] type 01 class 0x060400
[    2.992956] pci 0000:2a:04.0: enabling Extended Tags
[    3.003010] pci 0000:2a:04.0: supports D1 D2
[    3.007261] pci 0000:2a:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.012985] pci 0000:2a:05.0: [8086:1513] type 01 class 0x060400
[    3.019082] pci 0000:2a:05.0: enabling Extended Tags
[    3.023010] pci 0000:2a:05.0: supports D1 D2
[    3.027261] pci 0000:2a:05.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.033005] pci 0000:29:00.0: PCI bridge to [bus 2a-31]
[    3.038226] pci 0000:29:00.0:   bridge window [mem 0xdf000000-0xdf1fffff]
[    3.042849] pci 0000:29:00.0:   bridge window [mem 0xa0000000-0xa00fffff 64bit pref]
[    3.052953] pci 0000:2b:00.0: [12d8:400c] type 01 class 0x060400
[    3.063213] pci 0000:2b:00.0: supports D1 D2
[    3.067468] pci 0000:2b:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.073006] pci 0000:2a:00.0: PCI bridge to [bus 2b-2d]
[    3.078228] pci 0000:2a:00.0:   bridge window [mem 0xdf100000-0xdf1fffff]
[    3.083014] pci 0000:2c:03.0: [12d8:400c] type 01 class 0x060400
[    3.089321] pci 0000:2c:03.0: supports D1 D2
[    3.092839] pci 0000:2c:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.103027] pci 0000:2b:00.0: PCI bridge to [bus 2c-2d]
[    3.108251] pci 0000:2b:00.0:   bridge window [mem 0xdf100000-0xdf1fffff]
[    3.113000] pci 0000:2d:00.0: [12d8:400e] type 00 class 0x0c0310
[    3.119022] pci 0000:2d:00.0: reg 0x10: [mem 0xdf102000-0xdf102fff]
[    3.123095] pci 0000:2d:00.0: supports D1 D2
[    3.127345] pci 0000:2d:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.132982] pci 0000:2d:00.1: [12d8:400e] type 00 class 0x0c0310
[    3.142879] pci 0000:2d:00.1: reg 0x10: [mem 0xdf101000-0xdf101fff]
[    3.149377] pci 0000:2d:00.1: supports D1 D2
[    3.152839] pci 0000:2d:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[    3.162954] pci 0000:2d:00.2: [12d8:400f] type 00 class 0x0c0320
[    3.168986] pci 0000:2d:00.2: reg 0x10: [mem 0xdf100000-0xdf1000ff]
[    3.173139] pci 0000:2d:00.2: supports D1 D2
[    3.177393] pci 0000:2d:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[    3.183084] pci 0000:2c:03.0: PCI bridge to [bus 2d]
[    3.188054] pci 0000:2c:03.0:   bridge window [mem 0xdf100000-0xdf1fffff]
[    3.193008] pci 0000:2e:00.0: [14e4:16b0] type 00 class 0x020000
[    3.202896] pci 0000:2e:00.0: reg 0x10: [mem 0xa0010000-0xa001ffff 64bit pref]
[    3.210122] pci 0000:2e:00.0: reg 0x18: [mem 0xa0000000-0xa000ffff 64bit pref]
[    3.213145] pci 0000:2e:00.0: PME# supported from D0 D3hot D3cold
[    3.223040] pci 0000:2a:01.0: PCI bridge to [bus 2e]
[    3.228015] pci 0000:2a:01.0:   bridge window [mem 0xa0000000-0xa00fffff 64bit pref]
[    3.232951] pci 0000:2f:00.0: [11c1:5901] type 00 class 0x0c0010
[    3.242896] pci 0000:2f:00.0: reg 0x10: [mem 0xdf000000-0xdf000fff 64bit]
[    3.249957] pci 0000:2f:00.0: supports D1 D2
[    3.252839] pci 0000:2f:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.259609] pci 0000:2a:02.0: PCI bridge to [bus 2f]
[    3.262855] pci 0000:2a:02.0:   bridge window [mem 0xdf000000-0xdf0fffff]
[    3.272915] pci 0000:2a:04.0: PCI bridge to [bus 30]
[    3.277956] pci 0000:2a:05.0: PCI bridge to [bus 31]
[    3.283024] pci 0000:4b:00.0: [2646:2262] type 00 class 0x010802
[    3.289031] pci 0000:4b:00.0: reg 0x10: [mem 0xef600000-0xef603fff 64bit]
[    3.293055] pci 0000:02:04.0: PCI bridge to [bus 4b]
[    3.298002] pci 0000:02:04.0:   bridge window [mem 0xef600000-0xef6fffff]
[    3.302905] pci 0000:4c:00.0: [1b21:1806] type 01 class 0x060400
[    3.312907] pci 0000:4c:00.0: enabling Extended Tags
[    3.317955] pci 0000:4c:00.0: PME# supported from D0 D3hot D3cold
[    3.322878] pci 0000:4c:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x1 link at 0000:02:08.0 (capable of 15.752 Gb/s with 8.0 GT/s PCIe x2 link)
[    3.332888] pci 0000:02:08.0: PCI bridge to [bus 4c-50]
[    3.342842] pci 0000:02:08.0:   bridge window [io  0xf000-0xffff]
[    3.348913] pci 0000:02:08.0:   bridge window [mem 0xef500000-0xef5fffff]
[    3.352903] pci 0000:4d:00.0: [1b21:1806] type 01 class 0x060400
[    3.362909] pci 0000:4d:00.0: enabling Extended Tags
[    3.367964] pci 0000:4d:00.0: PME# supported from D0 D3hot D3cold
[    3.372932] pci 0000:4d:06.0: [1b21:1806] type 01 class 0x060400
[    3.378984] pci 0000:4d:06.0: enabling Extended Tags
[    3.382944] pci 0000:4d:06.0: PME# supported from D0 D3hot D3cold
[    3.392924] pci 0000:4d:0e.0: [1b21:1806] type 01 class 0x060400
[    3.398979] pci 0000:4d:0e.0: enabling Extended Tags
[    3.402944] pci 0000:4d:0e.0: PME# supported from D0 D3hot D3cold
[    3.409097] pci 0000:4c:00.0: PCI bridge to [bus 4d-50]
[    3.412845] pci 0000:4c:00.0:   bridge window [io  0xf000-0xffff]
[    3.418914] pci 0000:4c:00.0:   bridge window [mem 0xef500000-0xef5fffff]
[    3.422913] pci 0000:4e:00.0: [10ec:8125] type 00 class 0x020000
[    3.432868] pci 0000:4e:00.0: reg 0x10: [io  0xf000-0xf0ff]
[    3.438459] pci 0000:4e:00.0: reg 0x18: [mem 0xef500000-0xef50ffff 64bit]
[    3.442863] pci 0000:4e:00.0: reg 0x20: [mem 0xef510000-0xef513fff 64bit]
[    3.453023] pci 0000:4e:00.0: supports D1 D2
[    3.457281] pci 0000:4e:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.462987] pci 0000:4d:00.0: PCI bridge to [bus 4e]
[    3.467943] pci 0000:4d:00.0:   bridge window [io  0xf000-0xffff]
[    3.472842] pci 0000:4d:00.0:   bridge window [mem 0xef500000-0xef5fffff]
[    3.482889] pci 0000:4d:06.0: PCI bridge to [bus 4f]
[    3.487891] pci 0000:4d:0e.0: PCI bridge to [bus 50]
[    3.492946] pci 0000:51:00.0: [8086:15f3] type 00 class 0x020000
[    3.498949] pci 0000:51:00.0: reg 0x10: [mem 0xef300000-0xef3fffff]
[    3.502873] pci 0000:51:00.0: reg 0x1c: [mem 0xef400000-0xef403fff]
[    3.509259] pci 0000:51:00.0: PME# supported from D0 D3hot D3cold
[    3.512934] pci 0000:02:09.0: PCI bridge to [bus 51]
[    3.522844] pci 0000:02:09.0:   bridge window [mem 0xef300000-0xef4fffff]
[    3.529678] pci 0000:52:00.0: [c0a9:540a] type 00 class 0x010802
[    3.532880] pci 0000:52:00.0: reg 0x10: [mem 0xefd00000-0xefd03fff 64bit]
[    3.543169] pci 0000:00:02.2: PCI bridge to [bus 52]
[    3.548122] pci 0000:00:02.2:   bridge window [mem 0xefd00000-0xefdfffff]
[    3.552874] pci 0000:53:00.0: [1002:1638] type 00 class 0x030000
[    3.558870] pci 0000:53:00.0: reg 0x10: [mem 0xc0000000-0xcfffffff 64bit pref]
[    3.562844] pci 0000:53:00.0: reg 0x18: [mem 0xd0000000-0xd01fffff 64bit pref]
[    3.572843] pci 0000:53:00.0: reg 0x20: [io  0xe000-0xe0ff]
[    3.578396] pci 0000:53:00.0: reg 0x24: [mem 0xefc00000-0xefc7ffff]
[    3.582845] pci 0000:53:00.0: enabling Extended Tags
[    3.587795] pci 0000:53:00.0: BAR 0: assigned to efifb
[    3.592873] pci 0000:53:00.0: PME# supported from D1 D2 D3hot D3cold
[    3.602851] pci 0000:53:00.0: 126.016 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x16 link at 0000:00:08.1 (capable of 252.048 Gb/s with 16.0 GT/s PCIe x16 link)
[    3.612867] pci 0000:53:00.1: [1002:1637] type 00 class 0x040300
[    3.622844] pci 0000:53:00.1: reg 0x10: [mem 0xefc88000-0xefc8bfff]
[    3.629104] pci 0000:53:00.1: enabling Extended Tags
[    3.632863] pci 0000:53:00.1: PME# supported from D1 D2 D3hot D3cold
[    3.639228] pci 0000:53:00.2: [1022:15df] type 00 class 0x108000
[    3.642849] pci 0000:53:00.2: reg 0x18: [mem 0xefb00000-0xefbfffff]
[    3.652846] pci 0000:53:00.2: reg 0x24: [mem 0xefc8c000-0xefc8dfff]
[    3.659090] pci 0000:53:00.2: enabling Extended Tags
[    3.662907] pci 0000:53:00.3: [1022:1639] type 00 class 0x0c0330
[    3.668903] pci 0000:53:00.3: reg 0x10: [mem 0xefa00000-0xefafffff 64bit]
[    3.672859] pci 0000:53:00.3: enabling Extended Tags
[    3.682865] pci 0000:53:00.3: PME# supported from D0 D3hot D3cold
[    3.688973] pci 0000:53:00.4: [1022:1639] type 00 class 0x0c0330
[    3.692847] pci 0000:53:00.4: reg 0x10: [mem 0xef900000-0xef9fffff 64bit]
[    3.702859] pci 0000:53:00.4: enabling Extended Tags
[    3.707832] pci 0000:53:00.4: PME# supported from D0 D3hot D3cold
[    3.712874] pci 0000:53:00.6: [1022:15e3] type 00 class 0x040300
[    3.718867] pci 0000:53:00.6: reg 0x10: [mem 0xefc80000-0xefc87fff]
[    3.722856] pci 0000:53:00.6: enabling Extended Tags
[    3.727830] pci 0000:53:00.6: PME# supported from D0 D3hot D3cold
[    3.732885] pci 0000:00:08.1: PCI bridge to [bus 53]
[    3.737832] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
[    3.742839] pci 0000:00:08.1:   bridge window [mem 0xef900000-0xefcfffff]
[    3.752840] pci 0000:00:08.1:   bridge window [mem 0xc0000000-0xd01fffff 64bit pref]
[    3.763074] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    3.768997] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    3.772859] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    3.778781] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    3.782862] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    3.788775] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    3.792857] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    3.802857] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    3.809097] SCSI subsystem initialized
[    3.812865] Registered efivars operations
[    3.816911] PCI: Using ACPI for IRQ routing
[    3.828163] pci 0000:53:00.0: vgaarb: setting as boot VGA device
[    3.828825] pci 0000:53:00.0: vgaarb: bridge control possible
[    3.832838] pci 0000:53:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    3.832839] vgaarb: loaded
[    3.835543] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    3.842840] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    3.852860] clocksource: Switched to clocksource tsc-early
[    3.858350] VFS: Disk quotas dquot_6.6.0
[    3.862247] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    3.869108] pnp: PnP ACPI init
[    3.872188] system 00:00: [mem 0xf0000000-0xf7ffffff] has been reserved
[    3.878807] system 00:01: [mem 0x840000000-0x85fffffff window] has been reserved
[    3.886273] system 00:03: [io  0x0a00-0x0a2f] has been reserved
[    3.892171] system 00:03: [io  0x0a30-0x0a3f] has been reserved
[    3.898072] system 00:03: [io  0x0a40-0x0a4f] has been reserved
[    3.903974] system 00:03: [mem 0xfe000000-0xfe00ffff] has been reserved
[    3.910810] system 00:05: [io  0x04d0-0x04d1] has been reserved
[    3.916710] system 00:05: [io  0x040b] has been reserved
[    3.922006] system 00:05: [io  0x04d6] has been reserved
[    3.927297] system 00:05: [io  0x0c00-0x0c01] has been reserved
[    3.933198] system 00:05: [io  0x0c14] has been reserved
[    3.938495] system 00:05: [io  0x0c50-0x0c51] has been reserved
[    3.944396] system 00:05: [io  0x0c52] has been reserved
[    3.949683] system 00:05: [io  0x0c6c] has been reserved
[    3.954976] system 00:05: [io  0x0c6f] has been reserved
[    3.960271] system 00:05: [io  0x0cd8-0x0cdf] has been reserved
[    3.966174] system 00:05: [io  0x0800-0x089f] has been reserved
[    3.972074] system 00:05: [io  0x0b00-0x0b0f] has been reserved
[    3.977967] system 00:05: [io  0x0b20-0x0b3f] has been reserved
[    3.983862] system 00:05: [io  0x0900-0x090f] has been reserved
[    3.989763] system 00:05: [io  0x0910-0x091f] has been reserved
[    3.995666] system 00:05: [mem 0xfec00000-0xfec00fff] could not be reserved
[    4.002604] system 00:05: [mem 0xfec01000-0xfec01fff] could not be reserved
[    4.009533] system 00:05: [mem 0xfedc0000-0xfedc0fff] has been reserved
[    4.016118] system 00:05: [mem 0xfee00000-0xfee00fff] has been reserved
[    4.022711] system 00:05: [mem 0xfed80000-0xfed8ffff] could not be reserved
[    4.029650] system 00:05: [mem 0xfec10000-0xfec10fff] has been reserved
[    4.036235] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    4.043105] pnp: PnP ACPI: found 6 devices
[    4.052721] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    4.061577] NET: Registered PF_INET protocol family
[    4.066541] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    4.075907] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
[    4.084587] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    4.092302] TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    4.100488] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    4.107913] TCP: Hash tables configured (established 262144 bind 65536)
[    4.114511] UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    4.121389] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    4.128719] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    4.134360] pci 0000:04:01.0: bridge window [io  0x1000-0x0fff] to [bus 06-27] add_size 1000
[    4.142763] pci 0000:2a:04.0: bridge window [io  0x1000-0x0fff] to [bus 30] add_size 1000
[    4.150913] pci 0000:2a:04.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 30] add_size 200000 add_align 100000
[    4.162345] pci 0000:2a:04.0: bridge window [mem 0x00100000-0x000fffff] to [bus 30] add_size 200000 add_align 100000
[    4.172829] pci 0000:2a:05.0: bridge window [io  0x1000-0x0fff] to [bus 31] add_size 1000
[    4.180977] pci 0000:2a:05.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 31] add_size 200000 add_align 100000
[    4.192408] pci 0000:2a:05.0: bridge window [mem 0x00100000-0x000fffff] to [bus 31] add_size 200000 add_align 100000
[    4.202890] pci 0000:29:00.0: bridge window [io  0x1000-0x0fff] to [bus 2a-31] add_size 2000
[    4.211298] pci 0000:04:04.0: bridge window [io  0x1000-0x0fff] to [bus 29-4a] add_size 3000
[    4.219700] pci 0000:03:00.0: bridge window [io  0x1000-0x0fff] to [bus 04-4a] add_size 4000
[    4.228107] pci 0000:02:00.0: bridge window [io  0x1000-0x0fff] to [bus 03-4a] add_size 4000
[    4.236517] pci 0000:02:00.0: BAR 7: no space for [io  size 0x4000]
[    4.242762] pci 0000:02:00.0: BAR 7: failed to assign [io  size 0x4000]
[    4.249349] pci 0000:02:00.0: BAR 7: no space for [io  size 0x4000]
[    4.255596] pci 0000:02:00.0: BAR 7: failed to assign [io  size 0x4000]
[    4.262189] pci 0000:03:00.0: BAR 7: no space for [io  size 0x4000]
[    4.268430] pci 0000:03:00.0: BAR 7: failed to assign [io  size 0x4000]
[    4.275025] pci 0000:03:00.0: BAR 7: no space for [io  size 0x4000]
[    4.281270] pci 0000:03:00.0: BAR 7: failed to assign [io  size 0x4000]
[    4.287858] pci 0000:04:01.0: BAR 7: no space for [io  size 0x1000]
[    4.294103] pci 0000:04:01.0: BAR 7: failed to assign [io  size 0x1000]
[    4.300695] pci 0000:04:04.0: BAR 7: no space for [io  size 0x3000]
[    4.306936] pci 0000:04:04.0: BAR 7: failed to assign [io  size 0x3000]
[    4.313528] pci 0000:04:04.0: BAR 7: no space for [io  size 0x3000]
[    4.319766] pci 0000:04:04.0: BAR 7: failed to assign [io  size 0x3000]
[    4.326353] pci 0000:04:01.0: BAR 7: no space for [io  size 0x1000]
[    4.332599] pci 0000:04:01.0: BAR 7: failed to assign [io  size 0x1000]
[    4.339185] pci 0000:04:00.0: PCI bridge to [bus 05]
[    4.344141] pci 0000:04:00.0:   bridge window [mem 0xef100000-0xef1fffff]
[    4.350910] pci 0000:04:01.0: PCI bridge to [bus 06-27]
[    4.356117] pci 0000:04:01.0:   bridge window [mem 0xe7000000-0xeeffffff]
[    4.362882] pci 0000:04:01.0:   bridge window [mem 0xb0000000-0xb1ffffff 64bit pref]
[    4.370598] pci 0000:04:02.0: PCI bridge to [bus 28]
[    4.375549] pci 0000:04:02.0:   bridge window [mem 0xef000000-0xef0fffff]
[    4.382321] pci 0000:29:00.0: BAR 7: no space for [io  size 0x2000]
[    4.388568] pci 0000:29:00.0: BAR 7: failed to assign [io  size 0x2000]
[    4.395152] pci 0000:29:00.0: BAR 7: no space for [io  size 0x2000]
[    4.401398] pci 0000:29:00.0: BAR 7: failed to assign [io  size 0x2000]
[    4.407985] pci 0000:2a:04.0: BAR 8: no space for [mem size 0x00200000]
[    4.414577] pci 0000:2a:04.0: BAR 8: failed to assign [mem size 0x00200000]
[    4.421515] pci 0000:2a:04.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    4.429059] pci 0000:2a:04.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    4.436949] pci 0000:2a:05.0: BAR 8: no space for [mem size 0x00200000]
[    4.443541] pci 0000:2a:05.0: BAR 8: failed to assign [mem size 0x00200000]
[    4.450481] pci 0000:2a:05.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    4.458023] pci 0000:2a:05.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    4.465910] pci 0000:2a:04.0: BAR 7: no space for [io  size 0x1000]
[    4.472157] pci 0000:2a:04.0: BAR 7: failed to assign [io  size 0x1000]
[    4.478743] pci 0000:2a:05.0: BAR 7: no space for [io  size 0x1000]
[    4.484981] pci 0000:2a:05.0: BAR 7: failed to assign [io  size 0x1000]
[    4.491573] pci 0000:2a:05.0: BAR 8: no space for [mem size 0x00200000]
[    4.498166] pci 0000:2a:05.0: BAR 8: failed to assign [mem size 0x00200000]
[    4.505105] pci 0000:2a:05.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    4.512648] pci 0000:2a:05.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    4.520529] pci 0000:2a:05.0: BAR 7: no space for [io  size 0x1000]
[    4.526777] pci 0000:2a:05.0: BAR 7: failed to assign [io  size 0x1000]
[    4.533370] pci 0000:2a:04.0: BAR 8: no space for [mem size 0x00200000]
[    4.539962] pci 0000:2a:04.0: BAR 8: failed to assign [mem size 0x00200000]
[    4.546901] pci 0000:2a:04.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
[    4.554443] pci 0000:2a:04.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref]
[    4.562330] pci 0000:2a:04.0: BAR 7: no space for [io  size 0x1000]
[    4.568571] pci 0000:2a:04.0: BAR 7: failed to assign [io  size 0x1000]
[    4.575157] pci 0000:2c:03.0: PCI bridge to [bus 2d]
[    4.580119] pci 0000:2c:03.0:   bridge window [mem 0xdf100000-0xdf1fffff]
[    4.586906] pci 0000:2b:00.0: PCI bridge to [bus 2c-2d]
[    4.592120] pci 0000:2b:00.0:   bridge window [mem 0xdf100000-0xdf1fffff]
[    4.598905] pci 0000:2a:00.0: PCI bridge to [bus 2b-2d]
[    4.604120] pci 0000:2a:00.0:   bridge window [mem 0xdf100000-0xdf1fffff]
[    4.610896] pci 0000:2a:01.0: PCI bridge to [bus 2e]
[    4.615861] pci 0000:2a:01.0:   bridge window [mem 0xa0000000-0xa00fffff 64bit pref]
[    4.623584] pci 0000:2a:02.0: PCI bridge to [bus 2f]
[    4.628540] pci 0000:2a:02.0:   bridge window [mem 0xdf000000-0xdf0fffff]
[    4.635315] pci 0000:2a:04.0: PCI bridge to [bus 30]
[    4.640290] pci 0000:2a:05.0: PCI bridge to [bus 31]
[    4.645258] pci 0000:29:00.0: PCI bridge to [bus 2a-31]
[    4.650470] pci 0000:29:00.0:   bridge window [mem 0xdf000000-0xdf1fffff]
[    4.657232] pci 0000:29:00.0:   bridge window [mem 0xa0000000-0xa00fffff 64bit pref]
[    4.664953] pci 0000:04:04.0: PCI bridge to [bus 29-4a]
[    4.670168] pci 0000:04:04.0:   bridge window [mem 0xdf000000-0xe6ffffff]
[    4.676933] pci 0000:04:04.0:   bridge window [mem 0xa0000000-0xa1ffffff 64bit pref]
[    4.684652] pci 0000:03:00.0: PCI bridge to [bus 04-4a]
[    4.689861] pci 0000:03:00.0:   bridge window [mem 0xdf000000-0xef1fffff]
[    4.696626] pci 0000:03:00.0:   bridge window [mem 0xa0000000-0xb1ffffff 64bit pref]
[    4.704347] pci 0000:02:00.0: PCI bridge to [bus 03-4a]
[    4.709552] pci 0000:02:00.0:   bridge window [mem 0xdf000000-0xef1fffff]
[    4.716318] pci 0000:02:00.0:   bridge window [mem 0xa0000000-0xb1ffffff 64bit pref]
[    4.724038] pci 0000:02:04.0: PCI bridge to [bus 4b]
[    4.728986] pci 0000:02:04.0:   bridge window [mem 0xef600000-0xef6fffff]
[    4.735756] pci 0000:4d:00.0: PCI bridge to [bus 4e]
[    4.740702] pci 0000:4d:00.0:   bridge window [io  0xf000-0xffff]
[    4.746781] pci 0000:4d:00.0:   bridge window [mem 0xef500000-0xef5fffff]
[    4.753551] pci 0000:4d:06.0: PCI bridge to [bus 4f]
[    4.758516] pci 0000:4d:0e.0: PCI bridge to [bus 50]
[    4.763477] pci 0000:4c:00.0: PCI bridge to [bus 4d-50]
[    4.768682] pci 0000:4c:00.0:   bridge window [io  0xf000-0xffff]
[    4.774759] pci 0000:4c:00.0:   bridge window [mem 0xef500000-0xef5fffff]
[    4.781530] pci 0000:02:08.0: PCI bridge to [bus 4c-50]
[    4.786742] pci 0000:02:08.0:   bridge window [io  0xf000-0xffff]
[    4.792817] pci 0000:02:08.0:   bridge window [mem 0xef500000-0xef5fffff]
[    4.799586] pci 0000:02:09.0: PCI bridge to [bus 51]
[    4.804536] pci 0000:02:09.0:   bridge window [mem 0xef300000-0xef4fffff]
[    4.811302] pci 0000:01:00.2: PCI bridge to [bus 02-51]
[    4.816507] pci 0000:01:00.2:   bridge window [io  0xf000-0xffff]
[    4.822582] pci 0000:01:00.2:   bridge window [mem 0xdf000000-0xef6fffff]
[    4.829347] pci 0000:01:00.2:   bridge window [mem 0xa0000000-0xb1ffffff 64bit pref]
[    4.837066] pci 0000:00:02.1: PCI bridge to [bus 01-51]
[    4.842275] pci 0000:00:02.1:   bridge window [io  0xf000-0xffff]
[    4.848348] pci 0000:00:02.1:   bridge window [mem 0xdf000000-0xef7fffff]
[    4.855115] pci 0000:00:02.1:   bridge window [mem 0xa0000000-0xb1ffffff 64bit pref]
[    4.862831] pci 0000:00:02.2: PCI bridge to [bus 52]
[    4.867783] pci 0000:00:02.2:   bridge window [mem 0xefd00000-0xefdfffff]
[    4.874549] pci 0000:00:08.1: PCI bridge to [bus 53]
[    4.879498] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
[    4.885573] pci 0000:00:08.1:   bridge window [mem 0xef900000-0xefcfffff]
[    4.892337] pci 0000:00:08.1:   bridge window [mem 0xc0000000-0xd01fffff 64bit pref]
[    4.900055] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    4.906215] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    4.912375] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    4.918536] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    4.924697] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff window]
[    4.931547] pci_bus 0000:00: resource 9 [mem 0xa0000000-0xefffffff window]
[    4.938391] pci_bus 0000:01: resource 0 [io  0xf000-0xffff]
[    4.943948] pci_bus 0000:01: resource 1 [mem 0xdf000000-0xef7fffff]
[    4.950195] pci_bus 0000:01: resource 2 [mem 0xa0000000-0xb1ffffff 64bit pref]
[    4.957392] pci_bus 0000:02: resource 0 [io  0xf000-0xffff]
[    4.962940] pci_bus 0000:02: resource 1 [mem 0xdf000000-0xef6fffff]
[    4.969185] pci_bus 0000:02: resource 2 [mem 0xa0000000-0xb1ffffff 64bit pref]
[    4.976377] pci_bus 0000:03: resource 1 [mem 0xdf000000-0xef1fffff]
[    4.982623] pci_bus 0000:03: resource 2 [mem 0xa0000000-0xb1ffffff 64bit pref]
[    4.989820] pci_bus 0000:04: resource 1 [mem 0xdf000000-0xef1fffff]
[    4.996059] pci_bus 0000:04: resource 2 [mem 0xa0000000-0xb1ffffff 64bit pref]
[    5.003256] pci_bus 0000:05: resource 1 [mem 0xef100000-0xef1fffff]
[    5.009501] pci_bus 0000:06: resource 1 [mem 0xe7000000-0xeeffffff]
[    5.015742] pci_bus 0000:06: resource 2 [mem 0xb0000000-0xb1ffffff 64bit pref]
[    5.022940] pci_bus 0000:28: resource 1 [mem 0xef000000-0xef0fffff]
[    5.029186] pci_bus 0000:29: resource 1 [mem 0xdf000000-0xe6ffffff]
[    5.035426] pci_bus 0000:29: resource 2 [mem 0xa0000000-0xa1ffffff 64bit pref]
[    5.042626] pci_bus 0000:2a: resource 1 [mem 0xdf000000-0xdf1fffff]
[    5.048872] pci_bus 0000:2a: resource 2 [mem 0xa0000000-0xa00fffff 64bit pref]
[    5.056068] pci_bus 0000:2b: resource 1 [mem 0xdf100000-0xdf1fffff]
[    5.062309] pci_bus 0000:2c: resource 1 [mem 0xdf100000-0xdf1fffff]
[    5.068556] pci_bus 0000:2d: resource 1 [mem 0xdf100000-0xdf1fffff]
[    5.074802] pci_bus 0000:2e: resource 2 [mem 0xa0000000-0xa00fffff 64bit pref]
[    5.081998] pci_bus 0000:2f: resource 1 [mem 0xdf000000-0xdf0fffff]
[    5.088240] pci_bus 0000:4b: resource 1 [mem 0xef600000-0xef6fffff]
[    5.094486] pci_bus 0000:4c: resource 0 [io  0xf000-0xffff]
[    5.100040] pci_bus 0000:4c: resource 1 [mem 0xef500000-0xef5fffff]
[    5.106280] pci_bus 0000:4d: resource 0 [io  0xf000-0xffff]
[    5.111836] pci_bus 0000:4d: resource 1 [mem 0xef500000-0xef5fffff]
[    5.118085] pci_bus 0000:4e: resource 0 [io  0xf000-0xffff]
[    5.123640] pci_bus 0000:4e: resource 1 [mem 0xef500000-0xef5fffff]
[    5.129886] pci_bus 0000:51: resource 1 [mem 0xef300000-0xef4fffff]
[    5.136127] pci_bus 0000:52: resource 1 [mem 0xefd00000-0xefdfffff]
[    5.142372] pci_bus 0000:53: resource 0 [io  0xe000-0xefff]
[    5.147921] pci_bus 0000:53: resource 1 [mem 0xef900000-0xefcfffff]
[    5.154159] pci_bus 0000:53: resource 2 [mem 0xc0000000-0xd01fffff 64bit pref]
[    5.161599] pci 0000:2d:00.0: MSI is not implemented on this device, disabling it
[    5.169058] pci 0000:2d:00.0: PME# is unreliable, disabling it
[    5.174872] pci 0000:2d:00.0: pci_fixup_no_msi_no_pme+0x0/0x3b took 12961 usecs
[    5.182247] pci 0000:2d:00.0: enabling device (0000 -> 0002)
[    5.187947] pci 0000:2d:00.1: MSI is not implemented on this device, disabling it
[    5.195405] pci 0000:2d:00.1: PME# is unreliable, disabling it
[    5.201220] pci 0000:2d:00.1: pci_fixup_no_msi_no_pme+0x0/0x3b took 12962 usecs
[    5.208511] pci 0000:2d:00.1: enabling device (0000 -> 0002)
[    5.214203] pci 0000:2d:00.2: MSI is not implemented on this device, disabling it
[    5.221653] pci 0000:2d:00.2: PME# is unreliable, disabling it
[    5.227461] pci 0000:2d:00.2: pci_fixup_no_msi_no_pme+0x0/0x3b took 12947 usecs
[    5.234787] pci 0000:2d:00.2: EHCI: unrecognized capability 00
[    5.240654] pci 0000:53:00.1: D0 power state depends on 0000:53:00.0
[    5.246992] pci 0000:53:00.3: extending delay after power-on from D3hot to 20 msec
[    5.254605] pci 0000:53:00.4: extending delay after power-on from D3hot to 20 msec
[    5.262170] PCI: CLS 64 bytes, default 64
[    5.266173] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    5.266236] Trying to unpack rootfs image as initramfs...
[    5.272589] software IO TLB: mapped [mem 0x000000008d000000-0x0000000091000000] (64MB)
[    5.285860] LVT offset 0 assigned for vector 0x400
[    5.290694] perf: AMD IBS detected (0x000003ff)
[    5.295399] workingset: timestamp_bits=60 max_order=23 bucket_order=0
[    5.304179] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    5.311551] io scheduler mq-deadline registered
[    5.316186] pcieport 0000:00:02.1: PME: Signaling with IRQ 27
[    5.322002] pcieport 0000:00:02.2: PME: Signaling with IRQ 28
[    5.327800] pcieport 0000:00:08.1: PME: Signaling with IRQ 29
[    5.334443] pcieport 0000:04:01.0: pciehp: Slot #1 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    5.348249] pcieport 0000:04:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    5.362911] pcieport 0000:2a:04.0: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    5.378765] pcieport 0000:2a:05.0: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    5.395416] Freeing initrd memory: 14908K
[    5.399673] Estimated ratio of average max frequency by base frequency (times 1024): 1098
[    5.407832] ACPI: \_SB_.PLTF.C000: Found 3 idle states
[    5.413006] ACPI: \_SB_.PLTF.C002: Found 3 idle states
[    5.418170] ACPI: \_SB_.PLTF.C004: Found 3 idle states
[    5.423347] ACPI: \_SB_.PLTF.C006: Found 3 idle states
[    5.428526] ACPI: \_SB_.PLTF.C008: Found 3 idle states
[    5.433707] ACPI: \_SB_.PLTF.C00A: Found 3 idle states
[    5.438861] ACPI: \_SB_.PLTF.C001: Found 3 idle states
[    5.444038] ACPI: \_SB_.PLTF.C003: Found 3 idle states
[    5.449221] ACPI: \_SB_.PLTF.C005: Found 3 idle states
[    5.454421] ACPI: \_SB_.PLTF.C007: Found 3 idle states
[    5.459581] ACPI: \_SB_.PLTF.C009: Found 3 idle states
[    5.464741] ACPI: \_SB_.PLTF.C00B: Found 3 idle states
[    5.478225] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    5.505182] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    5.513873] brd: module loaded
[    5.517036] nvme nvme0: pci function 0000:4b:00.0
[    5.521758] nvme nvme1: pci function 0000:52:00.0
[    5.526520] Intel(R) 2.5G Ethernet Linux Driver
[    5.531051] Copyright(c) 2018 Intel Corporation.
[    5.531182] nvme nvme0: missing or invalid SUBNQN field.
[    5.533906] nvme nvme0: 15/0/0 default/read/poll queues
[    5.542721]  nvme0n1: p1 p2 p3
[    5.549249] igc 0000:51:00.0: PCIe PTM not supported by PCIe bus/controller
[    5.628078] igc 0000:51:00.0: 4.000 Gb/s available PCIe bandwidth (5.0 GT/s PCIe x1 link)
[    5.636228] igc 0000:51:00.0 eth0: MAC: d8:5e:d3:86:cc:c8
[    5.657867] nvme nvme1: missing or invalid SUBNQN field.
[    5.684723] r8169 0000:4e:00.0 eth1: RTL8125B, d8:5e:d3:86:cc:c6, XID 641, IRQ 72
[    5.692192] r8169 0000:4e:00.0 eth1: jumbo features [frames: 9194 bytes, tx checksumming: ko]
[    5.700719] i8042: PNP: No PS/2 controller found.
[    5.705437] rtc_cmos 00:02: RTC can wake from S4
[    5.710263] rtc_cmos 00:02: registered as rtc0
[    5.714723] rtc_cmos 00:02: setting system clock to 2022-08-06T09:31:35 UTC (1659778295)
[    5.715418] nvme nvme1: allocated 128 MiB host memory buffer.
[    5.722786] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    5.737135] efifb: probing for efifb
[    5.740709] efifb: framebuffer at 0xc0000000, using 3072k, total 3072k
[    5.747212] efifb: mode is 1024x768x32, linelength=4096, pages=1
[    5.753198] efifb: scrolling: redraw
[    5.756768] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    5.763111] Console: switching to colour frame buffer device 128x48
[    5.769807] fb0: EFI VGA frame buffer device
[    5.774096] ccp 0000:53:00.2: enabling device (0000 -> 0002)
[    5.789920] ccp 0000:53:00.2: tee enabled
[    5.793923] ccp 0000:53:00.2: psp enabled
[    5.798865] microcode: CPU0: patch_level=0x0a50000d
[    5.803751] microcode: CPU1: patch_level=0x0a50000d
[    5.808632] microcode: CPU2: patch_level=0x0a50000d
[    5.813520] microcode: CPU3: patch_level=0x0a50000d
[    5.818404] microcode: CPU4: patch_level=0x0a50000d
[    5.823275] microcode: CPU5: patch_level=0x0a50000d
[    5.828148] microcode: CPU6: patch_level=0x0a50000d
[    5.833119] microcode: CPU7: patch_level=0x0a50000d
[    5.838004] microcode: CPU8: patch_level=0x0a50000d
[    5.843119] microcode: CPU9: patch_level=0x0a50000d
[    5.848000] microcode: CPU10: patch_level=0x0a50000d
[    5.852958] microcode: CPU11: patch_level=0x0a50000d
[    5.857915] microcode: Microcode Update Driver: v2.2.
[    5.857917] IPI shorthand broadcast: enabled
[    5.867222] sched_clock: Marking stable (4355494257, 1507458394)->(5882672787, -19720136)
[    5.869425] nvme nvme1: 8/0/0 default/read/poll queues
[    5.881000] registered taskstats version 1
[    5.889027] nvme nvme1: Ignoring bogus Namespace Identifiers
[    5.895906]  nvme1n1: p1 p3 p4 p5
[    5.899843] Freeing unused kernel image (initmem) memory: 952K
[    6.043085] Write protecting the kernel read-only data: 12288k
[    6.049705] Freeing unused kernel image (text/rodata gap) memory: 2044K
[    6.056889] Freeing unused kernel image (rodata/data gap) memory: 180K
[    6.063629] Run /init as init process
[    6.099451] udevd[972]: starting version 3.2.9
[    6.372864] tsc: Refined TSC clocksource calibration: 3925.684 MHz
[    6.379204] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x712c427f03e, max_idle_ns: 881591097498 ns
[    6.389618] clocksource: Switched to clocksource tsc
[    7.152735] clocksource: timekeeping watchdog on CPU10: Marking clocksource 'tsc' as unstable because the skew is too large:
[    7.164059] clocksource:                       'hpet' wd_nsec: 503289663 wd_now: 4c6f2f8 wd_last: 458fdc8 mask: ffffffff
[    7.175040] clocksource:                       'tsc' cs_nsec: 499996520 cs_now: 170178539a cs_last: 168c79f2e4 mask: ffffffffffffffff
[    7.187351] clocksource:                       'tsc' is current clocksource.
[    7.194550] tsc: Marking TSC unstable due to clocksource watchdog
[    7.200813] TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
[    7.209560] sched_clock: Marking unstable (5693464229, 1507458537)<-(7220533357, -19720136)
[    7.218827] clocksource: Checking clocksource tsc synchronization from CPU 6 to CPUs 0,4-5,7-8,11.
[    7.228283] clocksource: Switched to clocksource hpet
[   11.082856] random: crng init done
[   11.087164] udevd[975]: starting eudev-3.2.9
[   11.096558] ACPI: \_TZ_.UAD0: Invalid passive threshold
[   11.102047] thermal LNXTHERM:00: registered as thermal_zone0
[   11.107995] ACPI: thermal: Thermal Zone [UAD0] (17 C)
[   11.113459] tg3 0000:2e:00.0: enabling device (0000 -> 0002)
[   11.119825] ahci 0000:01:00.1: SSS flag set, parallel bus scan disabled
[   11.126752] ahci 0000:01:00.1: AHCI 0001.0301 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
[   11.126998] ACPI: bus type USB registered
[   11.135156] ahci 0000:01:00.1: flags: 64bit ncq sntf stag pm led clo only pmp pio slum part sxs deso sadm sds apst
[   11.135440] usbcore: registered new interface driver usbfs
[   11.140017] scsi host0: ahci
[   11.150403] usbcore: registered new interface driver hub
[   11.150456] cryptd: max_cpu_qlen set to 1000
[   11.150755] scsi host1: ahci
[   11.150985] usbcore: registered new device driver usb
[   11.151349] scsi host2: ahci
[   11.180954] scsi host3: ahci
[   11.184240] scsi host4: ahci
[   11.187480] scsi host5: ahci
[   11.190675] ata1: SATA max UDMA/133 abar m131072@0xef780000 port 0xef780100 irq 83
[   11.198562] ata2: SATA max UDMA/133 abar m131072@0xef780000 port 0xef780180 irq 83
[   11.206433] ata3: SATA max UDMA/133 abar m131072@0xef780000 port 0xef780200 irq 83
[   11.209004] tg3 0000:2e:00.0 eth2: Tigon3 [partno(BCM957761) rev 57785100] (PCI Express) MAC address c8:2a:14:4f:80:3e
[   11.214296] ata4: SATA max UDMA/133 abar m131072@0xef780000 port 0xef780280 irq 83
[   11.214753] tg3 0000:2e:00.0 eth2: attached PHY is 57765 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[   11.215107] ata5: SATA max UDMA/133 abar m131072@0xef780000 port 0xef780300 irq 83
[   11.215434] tg3 0000:2e:00.0 eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[   11.215753] ata6: SATA max UDMA/133 abar m131072@0xef780000 port 0xef780380 irq 83
[   11.216072] tg3 0000:2e:00.0 eth2: dma_rwctrl[00000001] dma_mask[64-bit]
[   11.274431] AVX2 version of gcm_enc/dec engaged.
[   11.279458] AES CTR mode by8 optimization enabled
[   11.287176] ACPI: bus type thunderbolt registered
[   11.292198] thunderbolt 0000:05:00.0: enabling device (0000 -> 0002)
[   11.298909] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   11.544188] ata1: SATA link down (SStatus 0 SControl 330)
[   11.877226] ata2: SATA link down (SStatus 0 SControl 330)
[   11.923925] thunderbolt 0-3: new device found, vendor=0x1 device=0x8002
[   11.930760] thunderbolt 0-3: Apple, Inc. Thunderbolt Display
[   12.213289] ata3: SATA link down (SStatus 0 SControl 330)
[   12.543679] ata4: SATA link down (SStatus 0 SControl 330)
[   13.643137] ata5: failed to resume link (SControl 0)
[   13.648349] ata5: SATA link down (SStatus 0 SControl 0)
[   14.753149] ata6: failed to resume link (SControl 0)
[   14.758363] ata6: SATA link down (SStatus 0 SControl 0)
[   14.764761] xhci_hcd 0000:01:00.0: xHCI Host Controller
[   14.764768] ehci-pci: EHCI PCI platform driver
[   14.765059] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
[   14.782572] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   14.789149] ACPI Warning: SystemIO range 0x0000000000000B00-0x0000000000000B08 conflicts with OpRegion 0x0000000000000B00-0x0000000000000B0F (\GSA1.SMBI) (20220331/utaddress-204)
[   14.805615] ACPI: OSL: Resource conflict; ACPI support missing from driver?
[   14.813183] ACPI: bus type drm_connector registered
[   14.820889] xhci_hcd 0000:01:00.0: hcc params 0x0200ef81 hci version 0x110 quirks 0x0000000000000410
[   14.830429] ehci-pci 0000:2d:00.2: EHCI Host Controller
[   14.830443] xhci_hcd 0000:01:00.0: xHCI Host Controller
[   14.830744] ehci-pci 0000:2d:00.2: new USB bus registered, assigned bus number 2
[   14.831012] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 3
[   14.831569] xhci_hcd 0000:01:00.0: Host supports USB 3.1 Enhanced SuperSpeed
[   14.836798] ehci-pci 0000:2d:00.2: irq 34, io mem 0xdf100000
[   14.837099] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.19
[   14.872864] ehci-pci 0000:2d:00.2: USB 2.0 started, EHCI 1.00
[   14.878499] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   14.891946] usb usb1: Product: xHCI Host Controller
[   14.897133] usb usb1: Manufacturer: Linux 5.19.0+ xhci-hcd
[   14.902889] usb usb1: SerialNumber: 0000:01:00.0
[   14.908144] hub 1-0:1.0: USB hub found
[   14.912156] hub 1-0:1.0: 10 ports detected
[   14.916753] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.19
[   14.925303] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   14.932751] usb usb2: Product: EHCI Host Controller
[   14.937943] usb usb2: Manufacturer: Linux 5.19.0+ ehci_hcd
[   14.943744] usb usb2: SerialNumber: 0000:2d:00.2
[   14.949022] hub 2-0:1.0: USB hub found
[   14.953066] hub 2-0:1.0: 4 ports detected
[   14.957656] usb usb3: We don't know the algorithms for LPM for this host, disabling LPM.
[   14.967655] pcieport 0000:2a:05.0: pciehp: pciehp_isr: no response from device
[   15.167079] usb usb3: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.19
[   15.183060] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   15.190488] usb usb3: Product: xHCI Host Controller
[   15.190650] [drm] amdgpu kernel modesetting enabled.
[   15.190780] usb usb3: Manufacturer: Linux 5.19.0+ xhci-hcd
[   15.193769] amdgpu: CRAT table disabled by module option
[   15.196287] usb usb3: SerialNumber: 0000:01:00.0
[   15.196524] amdgpu: Virtual CRAT table created for CPU
[   15.196942] hub 3-0:1.0: USB hub found
[   15.197097] amdgpu: Topology: Add CPU node
[   15.197100] ohci-pci: OHCI PCI platform driver
[   15.197181] ohci-pci 0000:2d:00.0: OHCI PCI host controller
[   15.197383] hub 3-0:1.0: 4 ports detected
[   15.198026] ohci-pci 0000:2d:00.0: new USB bus registered, assigned bus number 4
[   15.198053] ohci-pci 0000:2d:00.0: irq 108, io mem 0xdf102000
[   15.259392] xhci_hcd 0000:28:00.0: xHCI Host Controller
[   15.259394] xhci_hcd 0000:28:00.0: new USB bus registered, assigned bus number 5
[   15.259937] Console: switching to colour dummy device 80x25
[   15.260584] xhci_hcd 0000:28:00.0: hcc params 0x200077c1 hci version 0x110 quirks 0x0000000200009810
[   15.266966] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.19
[   15.278116] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   15.278552] xhci_hcd 0000:28:00.0: xHCI Host Controller
[   15.287234] usb usb4: Product: OHCI PCI host controller
[   15.313137] usb usb4: Manufacturer: Linux 5.19.0+ ohci_hcd
[   15.313138] usb usb4: SerialNumber: 0000:2d:00.0
[   15.313238] hub 4-0:1.0: USB hub found
[   15.318604] amdgpu 0000:53:00.0: vgaarb: deactivate vga console
[   15.323244] hub 4-0:1.0: 2 ports detected
[   15.336932] amdgpu 0000:53:00.0: enabling device (0006 -> 0007)
[   15.337211] xhci_hcd 0000:28:00.0: new USB bus registered, assigned bus number 6
[   15.337214] xhci_hcd 0000:28:00.0: Host supports USB 3.1 Enhanced SuperSpeed
[   15.337241] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.19
[   15.337243] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   15.337244] usb usb5: Product: xHCI Host Controller
[   15.337245] usb usb5: Manufacturer: Linux 5.19.0+ xhci-hcd
[   15.337245] usb usb5: SerialNumber: 0000:28:00.0
[   15.337357] hub 5-0:1.0: USB hub found
[   15.337364] hub 5-0:1.0: 2 ports detected
[   15.337451] usb usb6: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.19
[   15.337453] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   15.337453] usb usb6: Product: xHCI Host Controller
[   15.337454] usb usb6: Manufacturer: Linux 5.19.0+ xhci-hcd
[   15.337455] usb usb6: SerialNumber: 0000:28:00.0
[   15.337562] hub 6-0:1.0: USB hub found
[   15.337570] hub 6-0:1.0: 2 ports detected
[   15.337689] xhci_hcd 0000:53:00.3: xHCI Host Controller
[   15.337692] xhci_hcd 0000:53:00.3: new USB bus registered, assigned bus number 7
[   15.337792] xhci_hcd 0000:53:00.3: hcc params 0x0268ffe5 hci version 0x110 quirks 0x0000020000000410
[   15.337963] xhci_hcd 0000:53:00.3: xHCI Host Controller
[   15.337964] xhci_hcd 0000:53:00.3: new USB bus registered, assigned bus number 8
[   15.337966] xhci_hcd 0000:53:00.3: Host supports USB 3.1 Enhanced SuperSpeed
[   15.337985] usb usb7: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.19
[   15.337987]

00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Root Complex
	Subsystem: Advanced Micro Devices, Inc. [AMD] Renoir Root Complex
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Renoir IOMMU
	Subsystem: Advanced Micro Devices, Inc. [AMD] Renoir IOMMU
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 255
	Capabilities: [40] Secure device <?>
	Capabilities: [64] MSI: Enable- Count=1/4 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [74] HyperTransport: MSI Mapping Enable+ Fixed+

00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Host Bridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Host Bridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin ? routed to IRQ 27
	Bus: primary=00, secondary=01, subordinate=51, sec-latency=0
	I/O behind bridge: 0000f000-0000ffff [size=4K]
	Memory behind bridge: df000000-ef7fffff [size=264M]
	Prefetchable memory behind bridge: 00000000a0000000-00000000b1ffffff [size=288M]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #2, Speed 8GT/s, Width x4, ASPM not supported
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x4 (ok)
			TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 75.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		RootCap: CRSVisible+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible+
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- LN System CLS Not Supported, TPHComp+ ExtTPHComp- ARIFwd+
			 AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS-
		DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- LTR+ OBFF Disabled, ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee04000  Data: 0021
	Capabilities: [c0] Subsystem: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP Bridge
	Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [270 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [2a0 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans+
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Capabilities: [3c4 v1] Designated Vendor-Specific: Vendor=1022 ID=0001 Rev=1 Len=44 <?>
	Kernel driver in use: pcieport

00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin ? routed to IRQ 28
	Bus: primary=00, secondary=52, subordinate=52, sec-latency=0
	I/O behind bridge: [disabled]
	Memory behind bridge: efd00000-efdfffff [size=1M]
	Prefetchable memory behind bridge: [disabled]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 8GT/s, Width x4, ASPM not supported
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x4 (ok)
			TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 75.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		RootCap: CRSVisible+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible+
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- LN System CLS Not Supported, TPHComp+ ExtTPHComp- ARIFwd+
			 AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS-
		DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- LTR+ OBFF Disabled, ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee06000  Data: 0021
	Capabilities: [c0] Subsystem: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP Bridge
	Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [270 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [2a0 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans+
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Capabilities: [3c4 v1] Designated Vendor-Specific: Vendor=1022 ID=0001 Rev=1 Len=44 <?>
	Kernel driver in use: pcieport

00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Host Bridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal PCIe GPP Bridge to Bus (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 29
	Bus: primary=00, secondary=53, subordinate=53, sec-latency=0
	I/O behind bridge: 0000e000-0000efff [size=4K]
	Memory behind bridge: ef900000-efcfffff [size=4M]
	Prefetchable memory behind bridge: 00000000c0000000-00000000d01fffff [size=258M]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <64ns, L1 <1us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x16 (ok)
			TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		RootCap: CRSVisible+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible+
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 4
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd-
			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled, ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
		LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Retimer+ 2Retimers+ DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee08000  Data: 0021
	Capabilities: [c0] Subsystem: Advanced Micro Devices, Inc. [AMD] Renoir Internal PCIe GPP Bridge to Bus
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [270 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [2a0 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans+
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Capabilities: [400 v1] Data Link Feature <?>
	Capabilities: [410 v1] Physical Layer 16.0 GT/s <?>
	Capabilities: [440 v1] Lane Margining at the Receiver <?>
	Kernel driver in use: pcieport

00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev 51)
	Subsystem: Gigabyte Technology Co., Ltd FCH SMBus Controller
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel modules: i2c_piix4

00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev 51)
	Subsystem: Gigabyte Technology Co., Ltd FCH LPC Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 166a
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 166b
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 166c
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 166d
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel driver in use: k10temp
	Kernel modules: k10temp

00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 166e
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 166f
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1670
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1671
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

01:00.0 USB controller: Advanced Micro Devices, Inc. [AMD] Device 43ee (prog-if 30 [XHCI])
	Subsystem: ASMedia Technology Inc. Device 1142
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 25
	Region 0: Memory at ef7a0000 (64-bit, non-prefetchable) [size=32K]
	Capabilities: [50] MSI: Enable- Count=1/8 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [68] MSI-X: Enable+ Count=8 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00002080
	Capabilities: [78] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] Express (v2) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <64ns, L1 <64us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <2us, L1 <32us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x4 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [200 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [300 v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci

01:00.1 SATA controller: Advanced Micro Devices, Inc. [AMD] Device 43eb (prog-if 01 [AHCI 1.0])
	Subsystem: ASMedia Technology Inc. Device 1062
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 79
	Region 5: Memory at ef780000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at ef700000 [disabled] [size=512K]
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0b000  Data: 0024
	Capabilities: [78] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] Express (v2) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <64ns, L1 <64us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <2us, L1 <32us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x4 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Kernel driver in use: ahci
	Kernel modules: ahci

01:00.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 43e9 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 30
	Bus: primary=01, secondary=02, subordinate=51, sec-latency=0
	I/O behind bridge: 0000f000-0000ffff [size=4K]
	Memory behind bridge: df000000-ef6fffff [size=263M]
	Prefetchable memory behind bridge: 00000000a0000000-00000000b1ffffff [size=288M]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0a000  Data: 0021
	Capabilities: [78] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] Express (v2) Upstream Port, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 75.000W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM L0s L1, Exit Latency L0s <2us, L1 <32us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x4 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: Routing-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
			 AtomicOpsCtl: EgressBlck-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [c0] Subsystem: ASMedia Technology Inc. Device 0201
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Kernel driver in use: pcieport

02:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 43ea (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 31
	Bus: primary=02, secondary=03, subordinate=4a, sec-latency=0
	I/O behind bridge: [disabled]
	Memory behind bridge: df000000-ef1fffff [size=258M]
	Prefetchable memory behind bridge: 00000000a0000000-00000000b1ffffff [size=288M]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee01000  Data: 0021
	Capabilities: [78] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L1 <64us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x4 (ok)
			TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #1, PowerLimit 26.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState+
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- ARIFwd-
			 AtomicOpsCap: Routing-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled, ARIFwd-
			 AtomicOpsCtl: EgressBlck-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [c0] Subsystem: ASMedia Technology Inc. Device 3308
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [200 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Kernel driver in use: pcieport

02:04.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 43ea (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 32
	Bus: primary=02, secondary=4b, subordinate=4b, sec-latency=0
	I/O behind bridge: [disabled]
	Memory behind bridge: ef600000-ef6fffff [size=1M]
	Prefetchable memory behind bridge: [disabled]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee03000  Data: 0021
	Capabilities: [78] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #4, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L1 <64us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x4 (ok)
			TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #1, PowerLimit 26.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState+
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- ARIFwd-
			 AtomicOpsCap: Routing-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled, ARIFwd-
			 AtomicOpsCtl: EgressBlck-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [c0] Subsystem: ASMedia Technology Inc. Device 3308
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [200 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Kernel driver in use: pcieport

02:08.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 43ea (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 33
	Bus: primary=02, secondary=4c, subordinate=50, sec-latency=0
	I/O behind bridge: 0000f000-0000ffff [size=4K]
	Memory behind bridge: ef500000-ef5fffff [size=1M]
	Prefetchable memory behind bridge: [disabled]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee05000  Data: 0021
	Capabilities: [78] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #8, Speed 8GT/s, Width x1, ASPM L1, Exit Latency L1 <64us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s (downgraded), Width x1 (ok)
			TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #1, PowerLimit 26.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState+
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- ARIFwd-
			 AtomicOpsCap: Routing-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled, ARIFwd-
			 AtomicOpsCtl: EgressBlck-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [c0] Subsystem: ASMedia Technology Inc. Device 3308
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [200 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Kernel driver in use: pcieport

02:09.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 43ea (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 35
	Bus: primary=02, secondary=51, subordinate=51, sec-latency=0
	I/O behind bridge: [disabled]
	Memory behind bridge: ef300000-ef4fffff [size=2M]
	Prefetchable memory behind bridge: [disabled]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee07000  Data: 0021
	Capabilities: [78] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #9, Speed 8GT/s, Width x1, ASPM L1, Exit Latency L1 <64us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s (downgraded), Width x1 (ok)
			TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt+
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #1, PowerLimit 26.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState+
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- ARIFwd-
			 AtomicOpsCap: Routing-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled, ARIFwd-
			 AtomicOpsCtl: EgressBlck-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [c0] Subsystem: ASMedia Technology Inc. Device 3308
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [200 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Kernel driver in use: pcieport

03:00.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 36
	Bus: primary=03, secondary=04, subordinate=4a, sec-latency=0
	I/O behind bridge: [disabled]
	Memory behind bridge: df000000-ef1fffff [size=258M]
	Prefetchable memory behind bridge: 00000000a0000000-00000000b1ffffff [size=288M]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [88] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee09000  Data: 0021
	Capabilities: [ac] Subsystem: Gigabyte Technology Co., Ltd JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018]
	Capabilities: [c0] Express (v2) Upstream Port, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 26.000W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L1 <2us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x4 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: Routing-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled,
			 AtomicOpsCtl: EgressBlck-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [100 v1] Device Serial Number d9-a6-50-49-69-c9-a0-00
	Capabilities: [200 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [300 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [400 v1] Power Budgeting <?>
	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=100 <?>
	Capabilities: [600 v1] Vendor Specific Information: ID=8086 Rev=2 Len=04c <?>
	Capabilities: [700 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [800 v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Capabilities: [a00 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=0us PortTPowerOnTime=10us
		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
			   T_CommonMode=0us LTR1.2_Threshold=0ns
		L1SubCtl2: T_PwrOn=10us
	Capabilities: [b00 v1] Precision Time Measurement
		PTMCap: Requester:- Responder:- Root:-
		PTMClockGranularity: Unimplemented
		PTMControl: Enabled:- RootSelected:-
		PTMEffectiveGranularity: Unknown
	Kernel driver in use: pcieport

04:00.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 37
	Bus: primary=04, secondary=05, subordinate=05, sec-latency=0
	I/O behind bridge: [disabled]
	Memory behind bridge: ef100000-ef1fffff [size=1M]
	Prefetchable memory behind bridge: [disabled]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [88] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0b000  Data: 0021
	Capabilities: [ac] Subsystem: Gigabyte Technology Co., Ltd JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018]
	Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L1, Exit Latency L1 <1us
			ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (ok), Width x4 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- ARIFwd-
			 AtomicOpsCap: Routing-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled, ARIFwd-
			 AtomicOpsCtl: EgressBlck-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [50] Capability ID 0x15 [0000]
	Capabilities: [100 v1] Device Serial Number d9-a6-50-49-69-c9-a0-00
	Capabilities: [200 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [300 v1] Virtual Channel
		Caps:	LPEVC=1 RefClk=100ns PATEntryBits=1
		Arb:	Fixed+ WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable- ID=1 ArbSelect=Fixed TC/VC=00
			Status:	NegoPending+ InProgress-
	Capabilities: [400 v1] Power Budgeting <?>
	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=100 <?>
	Capabilities: [600 v1] Vendor Specific Information: ID=8086 Rev=2 Len=04c <?>
	Capabilities: [700 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [900 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir- CmpltRedir- UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: pcieport

04:01.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 38
	Bus: primary=04, secondary=06, subordinate=27, sec-latency=0
	I/O behind bridge: [disabled]
	Memory behind bridge: e7000000-eeffffff [size=128M]
	Prefetchable memory behind bridge: 00000000b0000000-00000000b1ffffff [size=32M]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [88] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee00000  Data: 0021
	Capabilities: [ac] Subsystem: Gigabyte Technology Co., Ltd JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018]
	Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x4, ASPM L1, Exit Latency L1 <1us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (ok), Width x4 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #1, PowerLimit 0.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg+
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- ARIFwd-
			 AtomicOpsCap: Routing-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled, ARIFwd-
			 AtomicOpsCtl: EgressBlck-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [50] Capability ID 0x15 [0000]
	Capabilities: [100 v1] Device Serial Number d9-a6-50-49-69-c9-a0-00
	Capabilities: [200 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [300 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending+ InProgress-
	Capabilities: [400 v1] Power Budgeting <?>
	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=100 <?>
	Capabilities: [600 v1] Vendor Specific Information: ID=8086 Rev=2 Len=04c <?>
	Capabilities: [700 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [900 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir- CmpltRedir- UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: pcieport

04:02.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 39
	Bus: primary=04, secondary=28, subordinate=28, sec-latency=0
	I/O behind bridge: [disabled]
	Memory behind bridge: ef000000-ef0fffff [size=1M]
	Prefetchable memory behind bridge: [disabled]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [88] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee02000  Data: 0022
	Capabilities: [ac] Subsystem: Gigabyte Technology Co., Ltd JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018]
	Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #2, Speed 2.5GT/s, Width x4, ASPM L1, Exit Latency L1 <1us
			ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (ok), Width x4 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- ARIFwd-
			 AtomicOpsCap: Routing-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled, ARIFwd-
			 AtomicOpsCtl: EgressBlck-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [50] Capability ID 0x15 [0000]
	Capabilities: [100 v1] Device Serial Number d9-a6-50-49-69-c9-a0-00
	Capabilities: [200 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [300 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [400 v1] Power Budgeting <?>
	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=100 <?>
	Capabilities: [600 v1] Vendor Specific Information: ID=8086 Rev=2 Len=04c <?>
	Capabilities: [700 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [900 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir- CmpltRedir- UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: pcieport

04:04.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 40
	Bus: primary=04, secondary=29, subordinate=4a, sec-latency=0
	I/O behind bridge: [disabled]
	Memory behind bridge: df000000-e6ffffff [size=128M]
	Prefetchable memory behind bridge: 00000000a0000000-00000000a1ffffff [size=32M]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME+
	Capabilities: [88] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee04000  Data: 0022
	Capabilities: [ac] Subsystem: Gigabyte Technology Co., Ltd JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018]
	Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #4, Speed 2.5GT/s, Width x4, ASPM L1, Exit Latency L1 <1us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (ok), Width x4 (ok)
			TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #4, PowerLimit 0.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg+
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- ARIFwd-
			 AtomicOpsCap: Routing-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled, ARIFwd-
			 AtomicOpsCtl: EgressBlck-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [50] Capability ID 0x15 [0000]
	Capabilities: [100 v1] Device Serial Number d9-a6-50-49-69-c9-a0-00
	Capabilities: [200 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [300 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [400 v1] Power Budgeting <?>
	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=100 <?>
	Capabilities: [600 v1] Vendor Specific Information: ID=8086 Rev=2 Len=04c <?>
	Capabilities: [700 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [900 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir- CmpltRedir- UpstreamFwd+ EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: pcieport

05:00.0 System peripheral: Intel Corporation JHL7540 Thunderbolt 3 NHI [Titan Ridge 4C 2018] (rev 06)
	Subsystem: Gigabyte Technology Co., Ltd JHL7540 Thunderbolt 3 NHI [Titan Ridge 4C 2018]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 25
	Region 0: Memory at ef100000 (32-bit, non-prefetchable) [size=256K]
	Region 1: Memory at ef140000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [88] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [c0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L1, Exit Latency L1 <1us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (ok), Width x4 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range B, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI-X: Enable+ Count=16 Masked-
		Vector table: BAR=1 offset=00000000
		PBA: BAR=1 offset=00000fa0
	Capabilities: [100 v1] Device Serial Number d9-a6-50-49-69-c9-a0-00
	Capabilities: [200 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [300 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
	Capabilities: [400 v1] Power Budgeting <?>
	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=100 <?>
	Capabilities: [600 v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Kernel driver in use: thunderbolt
	Kernel modules: thunderbolt

28:00.0 USB controller: Intel Corporation JHL7540 Thunderbolt 3 USB Controller [Titan Ridge 4C 2018] (rev 06) (prog-if 30 [XHCI])
	Subsystem: Gigabyte Technology Co., Ltd JHL7540 Thunderbolt 3 USB Controller [Titan Ridge 4C 2018]
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 104
	Region 0: Memory at ef000000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
	Capabilities: [88] MSI: Enable+ Count=1/8 Maskable- 64bit+
		Address: 00000000fee09000  Data: 0025
	Capabilities: [c0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L1, Exit Latency L1 <1us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (ok), Width x4 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range B, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [100 v1] Device Serial Number d9-a6-50-49-69-c9-a0-00
	Capabilities: [200 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [300 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
	Capabilities: [400 v1] Power Budgeting <?>
	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=100 <?>
	Capabilities: [600 v1] Vendor Specific Information: ID=8086 Rev=2 Len=04c <?>
	Capabilities: [700 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [800 v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci

29:00.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010] (prog-if 00 [Normal decode])
	Physical Slot: 4
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 125
	Bus: primary=29, secondary=2a, subordinate=4a, sec-latency=0
	I/O behind bridge: [disabled]
	Memory behind bridge: df000000-e6ffffff [size=128M]
	Prefetchable memory behind bridge: 00000000a0000000-00000000a1ffffff [size=32M]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [88] MSI: Enable+ Count=1/32 Maskable- 64bit+
		Address: 00000000fee01000  Data: 0027
	Capabilities: [c0] Express (v2) Upstream Port, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 0.000W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s unlimited, L1 unlimited
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (ok), Width x4 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: Routing-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
			 AtomicOpsCtl: EgressBlck-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [100 v1] Device Serial Number 01-00-00-00-00-c9-a0-00
	Capabilities: [200 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [300 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [400 v1] Power Budgeting <?>
	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=01c <?>
	Kernel driver in use: pcieport

2a:00.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010] (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 126
	Bus: primary=2a, secondary=2b, subordinate=2d, sec-latency=0
	I/O behind bridge: [disabled]
	Memory behind bridge: df000000-df0fffff [size=1M]
	Prefetchable memory behind bridge: 00000000a0000000-00000000a00fffff [size=1M]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [88] MSI: Enable+ Count=1/32 Maskable- 64bit+
		Address: 00000000fee03000  Data: 0027
	Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s unlimited, L1 unlimited
			ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp-
		LnkCtl:	ASPM Disabled; Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (ok), Width x1 (downgraded)
			TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- ARIFwd-
			 AtomicOpsCap: Routing-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled, ARIFwd-
			 AtomicOpsCtl: EgressBlck-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [100 v1] Device Serial Number 01-00-00-00-00-c9-a0-00
	Capabilities: [200 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [300 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [400 v1] Power Budgeting <?>
	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=01c <?>
	Kernel driver in use: pcieport

2a:01.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010] (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 127
	Bus: primary=2a, secondary=2e, subordinate=2e, sec-latency=0
	I/O behind bridge: [disabled]
	Memory behind bridge: df100000-df1fffff [size=1M]
	Prefetchable memory behind bridge: 00000000a0100000-00000000a01fffff [size=1M]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [88] MSI: Enable+ Count=1/32 Maskable- 64bit+
		Address: 00000000fee05000  Data: 0027
	Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s unlimited, L1 unlimited
			ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp-
		LnkCtl:	ASPM Disabled; Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (ok), Width x1 (downgraded)
			TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- ARIFwd-
			 AtomicOpsCap: Routing-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled, ARIFwd-
			 AtomicOpsCtl: EgressBlck-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [100 v1] Device Serial Number 01-00-00-00-00-c9-a0-00
	Capabilities: [200 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [300 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [400 v1] Power Budgeting <?>
	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=01c <?>
	Kernel driver in use: pcieport

2a:02.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010] (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 128
	Bus: primary=2a, secondary=2f, subordinate=2f, sec-latency=0
	I/O behind bridge: [disabled]
	Memory behind bridge: df200000-df2fffff [size=1M]
	Prefetchable memory behind bridge: 00000000a0200000-00000000a02fffff [size=1M]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [88] MSI: Enable+ Count=1/32 Maskable- 64bit+
		Address: 00000000fee07000  Data: 0027
	Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #2, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s unlimited, L1 unlimited
			ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp-
		LnkCtl:	ASPM Disabled; Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (ok), Width x1 (downgraded)
			TrErr- Train- SlotClk+ DLActive- BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- ARIFwd-
			 AtomicOpsCap: Routing-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled, ARIFwd-
			 AtomicOpsCtl: EgressBlck-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [100 v1] Device Serial Number 01-00-00-00-00-c9-a0-00
	Capabilities: [200 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [300 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [400 v1] Power Budgeting <?>
	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=01c <?>
	Kernel driver in use: pcieport

2a:04.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010] (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 25
	Bus: primary=2a, secondary=30, subordinate=3f, sec-latency=0
	I/O behind bridge: [disabled]
	Memory behind bridge: df300000-e31fffff [size=63M]
	Prefetchable memory behind bridge: 00000000a0300000-00000000a11fffff [size=15M]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [88] MSI: Enable- Count=1/32 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #4, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s unlimited, L1 unlimited
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
		LnkCtl:	ASPM Disabled; Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (ok), Width x4 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #4, PowerLimit 0.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt+ HPIrq+ LinkChg+
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- ARIFwd-
			 AtomicOpsCap: Routing-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled, ARIFwd-
			 AtomicOpsCtl: EgressBlck-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [100 v1] Device Serial Number 01-00-00-00-00-c9-a0-00
	Capabilities: [200 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [300 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending+ InProgress-
	Capabilities: [400 v1] Power Budgeting <?>
	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=01c <?>
	Kernel driver in use: pcieport

2a:05.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010] (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 34
	Bus: primary=2a, secondary=40, subordinate=4a, sec-latency=0
	I/O behind bridge: [disabled]
	Memory behind bridge: e3200000-e6ffffff [size=62M]
	Prefetchable memory behind bridge: 00000000a1200000-00000000a1ffffff [size=14M]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [88] MSI: Enable- Count=1/32 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [c0] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #5, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency L0s unlimited, L1 unlimited
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
		LnkCtl:	ASPM Disabled; Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (ok), Width x4 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #5, PowerLimit 0.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt+ HPIrq+ LinkChg+
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- ARIFwd-
			 AtomicOpsCap: Routing-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled, ARIFwd-
			 AtomicOpsCtl: EgressBlck-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [100 v1] Device Serial Number 01-00-00-00-00-c9-a0-00
	Capabilities: [200 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [300 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending+ InProgress-
	Capabilities: [400 v1] Power Budgeting <?>
	Capabilities: [500 v1] Vendor Specific Information: ID=1234 Rev=1 Len=01c <?>
	Kernel driver in use: pcieport

2b:00.0 PCI bridge: Pericom Semiconductor Device 400c (rev 02) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=2b, secondary=2c, subordinate=2d, sec-latency=0
	I/O behind bridge: [disabled]
	Memory behind bridge: df000000-df0fffff [size=1M]
	Prefetchable memory behind bridge: 00000000a0000000-00000000a00fffff [size=1M]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [9c] Vital Product Data
		Not readable
	Capabilities: [a4] Vendor Specific Information: Len=0c <?>
	Capabilities: [c4] Subsystem: Device 0000:0000
	Capabilities: [e0] Express (v1) Upstream Port, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 0.000W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Exit Latency L0s <512ns
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (ok), Width x1 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [140 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=4
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=04 MaxTimeSlots=64 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128+ TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
			Port Arbitration Table <?>
	Capabilities: [20c v1] Power Budgeting <?>

2c:03.0 PCI bridge: Pericom Semiconductor Device 400c (rev 02) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=2c, secondary=2d, subordinate=2d, sec-latency=0
	I/O behind bridge: [disabled]
	Memory behind bridge: df000000-df0fffff [size=1M]
	Prefetchable memory behind bridge: 00000000a0000000-00000000a00fffff [size=1M]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [8c] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [a4] Vendor Specific Information: Len=0c <?>
	Capabilities: [c4] Subsystem: Device 0000:0000
	Capabilities: [e0] Express (v1) Downstream Port (Slot-), MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #3, Speed 2.5GT/s, Width x1, ASPM L0s, Exit Latency L0s <512ns
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (ok), Width x1 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Kernel driver in use: pcieport

2d:00.0 USB controller: Pericom Semiconductor PI7C9X442SL USB OHCI Controller (rev 01) (prog-if 10 [OHCI])
	Subsystem: Pericom Semiconductor PI7C9X442SL USB OHCI Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 122
	Region 0: Memory at df000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [8c] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Exit Latency L0s <512ns
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (ok), Width x1 (ok)
			TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
	Kernel driver in use: ohci-pci
	Kernel modules: ohci_pci

2d:00.1 USB controller: Pericom Semiconductor PI7C9X442SL USB OHCI Controller (rev 01) (prog-if 10 [OHCI])
	Subsystem: Pericom Semiconductor PI7C9X442SL USB OHCI Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 25
	Region 0: Memory at df001000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [8c] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Exit Latency L0s <512ns
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (ok), Width x1 (ok)
			TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
	Kernel driver in use: ohci-pci
	Kernel modules: ohci_pci

2d:00.2 USB controller: Pericom Semiconductor PI7C9X442SL USB EHCI Controller (rev 01) (prog-if 20 [EHCI])
	Subsystem: Pericom Semiconductor PI7C9X442SL USB EHCI Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 34
	Region 0: Memory at df002000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [8c] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Exit Latency L0s <512ns
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (ok), Width x1 (ok)
			TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
	Kernel driver in use: ehci-pci
	Kernel modules: ehci_pci

2e:00.0 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme BCM57761 Gigabit Ethernet PCIe (rev 10)
	Subsystem: Apple Inc. NetXtreme BCM57761 Gigabit Ethernet PCIe
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 34
	Region 0: Memory at a0100000 (64-bit, prefetchable) [size=64K]
	Region 2: Memory at a0110000 (64-bit, prefetchable) [size=64K]
	Capabilities: [48] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [a0] MSI-X: Enable+ Count=6 Masked-
		Vector table: BAR=2 offset=00000000
		PBA: BAR=2 offset=00000120
	Capabilities: [ac] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <2us, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (ok), Width x1 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [13c v1] Device Serial Number 00-00-c8-2a-14-4f-80-3e
	Capabilities: [150 v1] Power Budgeting <?>
	Capabilities: [160 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Kernel driver in use: tg3
	Kernel modules: tg3

2f:00.0 FireWire (IEEE 1394): LSI Corporation FW643 [TrueFire] PCIe 1394b Controller (rev 08) (prog-if 10 [OHCI])
	Subsystem: Device c111:0159
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 255
	Region 0: Memory at df200000 (64-bit, non-prefetchable) [disabled] [size=4K]
	Capabilities: [44] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [4c] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [60] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 2048 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <512ns, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (ok), Width x1 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [140 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable- ID=0 ArbSelect=Fixed TC/VC=00
			Status:	NegoPending- InProgress-
	Capabilities: [170 v1] Device Serial Number 00-0a-27-02-00-40-c4-ba

4b:00.0 Non-Volatile memory controller: Kingston Technology Company, Inc. Device 2262 (rev 03) (prog-if 02 [NVM Express])
	Subsystem: Kingston Technology Company, Inc. Device 2262
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 25
	NUMA node: 0
	Region 0: Memory at ef600000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable- Count=1/8 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [70] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 26.000W
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L1 <8us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x4 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [b0] MSI-X: Enable+ Count=16 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00002100
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [158 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [178 v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Capabilities: [180 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=10us PortTPowerOnTime=10us
		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
			   T_CommonMode=0us LTR1.2_Threshold=0ns
		L1SubCtl2: T_PwrOn=10us
	Kernel driver in use: nvme

4c:00.0 PCI bridge: ASMedia Technology Inc. Device 1806 (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 41
	Bus: primary=4c, secondary=4d, subordinate=50, sec-latency=0
	I/O behind bridge: 0000f000-0000ffff [size=4K]
	Memory behind bridge: ef500000-ef5fffff [size=1M]
	Prefetchable memory behind bridge: [disabled]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee06000  Data: 0022
	Capabilities: [80] Express (v2) Upstream Port, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 26.000W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x2, ASPM L1, Exit Latency L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s (ok), Width x1 (downgraded)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: Routing-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled,
			 AtomicOpsCtl: EgressBlck-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis+
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [c0] Subsystem: Device 0000:0000
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 14, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 05000001 0000220f 4d08004d 00000000
	Capabilities: [140 v1] Power Budgeting <?>
	Capabilities: [160 v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Capabilities: [180 v1] Multicast
		McastCap: MaxGroups 64, ECRCRegen-
		McastCtl: NumGroups 1, Enable-
		McastBAR: IndexPos 0, BaseAddr 0000000000000000
		McastReceiveVec:      0000000000000000
		McastBlockAllVec:     0000000000000000
		McastBlockUntransVec: 0000000000000000
		McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 0000000000000000
	Capabilities: [1c0 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [200 v1] Vendor Specific Information: ID=001a Rev=0 Len=000 <?>
	Kernel driver in use: pcieport

4d:00.0 PCI bridge: ASMedia Technology Inc. Device 1806 (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 42
	Bus: primary=4d, secondary=4e, subordinate=4e, sec-latency=0
	I/O behind bridge: 0000f000-0000ffff [size=4K]
	Memory behind bridge: ef500000-ef5fffff [size=1M]
	Prefetchable memory behind bridge: [disabled]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee08000  Data: 0022
	Capabilities: [80] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x2, ASPM L1, Exit Latency L1 <64us
			ClockPM+ Surprise+ LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s (ok), Width x1 (downgraded)
			TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState+
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- ARIFwd+
			 AtomicOpsCap: Routing-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled, ARIFwd-
			 AtomicOpsCtl: EgressBlck-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis+, Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [c0] Subsystem: Device 0000:0000
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [140 v1] Power Budgeting <?>
	Capabilities: [160 v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Capabilities: [180 v1] Multicast
		McastCap: MaxGroups 64, ECRCRegen-
		McastCtl: NumGroups 1, Enable-
		McastBAR: IndexPos 0, BaseAddr 0000000000000000
		McastReceiveVec:      0000000000000000
		McastBlockAllVec:     0000000000000000
		McastBlockUntransVec: 0000000000000000
		McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 0000000000000000
	Capabilities: [1c0 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [200 v1] Vendor Specific Information: ID=001a Rev=0 Len=000 <?>
	Kernel driver in use: pcieport

4d:06.0 PCI bridge: ASMedia Technology Inc. Device 1806 (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 43
	Bus: primary=4d, secondary=4f, subordinate=4f, sec-latency=0
	I/O behind bridge: [disabled]
	Memory behind bridge: [disabled]
	Prefetchable memory behind bridge: [disabled]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0a000  Data: 0022
	Capabilities: [80] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
		LnkCap:	Port #6, Speed 5GT/s, Width x1, ASPM L1, Exit Latency L1 <64us
			ClockPM+ Surprise+ LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (downgraded), Width x1 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- ARIFwd+
			 AtomicOpsCap: Routing-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled, ARIFwd-
			 AtomicOpsCtl: EgressBlck-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis+, Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [c0] Subsystem: Device 0000:0000
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 14, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 04000001 0000230f 4f00004f 00000000
	Capabilities: [140 v1] Power Budgeting <?>
	Capabilities: [160 v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Capabilities: [180 v1] Multicast
		McastCap: MaxGroups 64, ECRCRegen-
		McastCtl: NumGroups 1, Enable-
		McastBAR: IndexPos 0, BaseAddr 0000000000000000
		McastReceiveVec:      0000000000000000
		McastBlockAllVec:     0000000000000000
		McastBlockUntransVec: 0000000000000000
		McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 0000000000000000
	Capabilities: [1c0 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [200 v1] Vendor Specific Information: ID=001a Rev=0 Len=000 <?>
	Kernel driver in use: pcieport

4d:0e.0 PCI bridge: ASMedia Technology Inc. Device 1806 (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 44
	Bus: primary=4d, secondary=50, subordinate=50, sec-latency=0
	I/O behind bridge: [disabled]
	Memory behind bridge: [disabled]
	Prefetchable memory behind bridge: [disabled]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee01000  Data: 0022
	Capabilities: [80] Express (v2) Downstream Port (Slot+), MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
		LnkCap:	Port #14, Speed 5GT/s, Width x1, ASPM L1, Exit Latency L1 <64us
			ClockPM+ Surprise+ LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (downgraded), Width x1 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- ARIFwd+
			 AtomicOpsCap: Routing-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled, ARIFwd-
			 AtomicOpsCtl: EgressBlck-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis+, Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [c0] Subsystem: Device 0000:0000
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 14, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 04000001 0000220f 50000050 00000000
	Capabilities: [140 v1] Power Budgeting <?>
	Capabilities: [160 v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Capabilities: [180 v1] Multicast
		McastCap: MaxGroups 64, ECRCRegen-
		McastCtl: NumGroups 1, Enable-
		McastBAR: IndexPos 0, BaseAddr 0000000000000000
		McastReceiveVec:      0000000000000000
		McastBlockAllVec:     0000000000000000
		McastBlockUntransVec: 0000000000000000
		McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr 0000000000000000
	Capabilities: [1c0 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [200 v1] Vendor Specific Information: ID=001a Rev=0 Len=000 <?>
	Kernel driver in use: pcieport

4e:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller (rev 05)
	Subsystem: Gigabyte Technology Co., Ltd Device e000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 25
	Region 0: I/O ports at f000 [size=256]
	Region 2: Memory at ef500000 (64-bit, non-prefetchable) [size=64K]
	Region 4: Memory at ef510000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [70] Express (v2) Endpoint, MSI 01
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s unlimited, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s (ok), Width x1 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Via message/WAKE#, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp+ ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [b0] MSI-X: Enable+ Count=32 Masked-
		Vector table: BAR=4 offset=00000000
		PBA: BAR=4 offset=00000800
	Capabilities: [d0] Vital Product Data
		Not readable
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [148 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
	Capabilities: [168 v1] Device Serial Number c6-cc-86-d3-5e-d8-00-00
	Capabilities: [178 v1] Transaction Processing Hints
		No steering table available
	Capabilities: [204 v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Capabilities: [20c v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=150us PortTPowerOnTime=150us
		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
			   T_CommonMode=0us LTR1.2_Threshold=0ns
		L1SubCtl2: T_PwrOn=10us
	Capabilities: [21c v1] Vendor Specific Information: ID=0002 Rev=4 Len=100 <?>
	Kernel driver in use: r8169

51:00.0 Ethernet controller: Intel Corporation Ethernet Controller I225-V (rev 01)
	Subsystem: Gigabyte Technology Co., Ltd Device e000
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 34
	Region 0: Memory at ef300000 (32-bit, non-prefetchable) [size=1M]
	Region 3: Memory at ef400000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [70] MSI-X: Enable+ Count=5 Masked-
		Vector table: BAR=3 offset=00000000
		PBA: BAR=3 offset=00002000
	Capabilities: [a0] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0.000W
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #9, Speed 5GT/s, Width x1, ASPM L1, Exit Latency L1 <4us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 5GT/s (ok), Width x1 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [140 v1] Device Serial Number d8-5e-d3-ff-ff-86-cc-c8
	Capabilities: [1c0 v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Capabilities: [1f0 v1] Precision Time Measurement
		PTMCap: Requester:+ Responder:- Root:-
		PTMClockGranularity: 4ns
		PTMControl: Enabled:+ RootSelected:-
		PTMEffectiveGranularity: Unknown
	Capabilities: [1e0 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2- PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1+ L1_PM_Substates+
		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
		L1SubCtl2:
	Kernel driver in use: igc

52:00.0 Non-Volatile memory controller: Micron/Crucial Technology Device 540a (rev 01) (prog-if 02 [NVM Express])
	Subsystem: Micron/Crucial Technology Device 540a
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 45
	NUMA node: 0
	Region 0: Memory at efd00000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [80] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 75.000W
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L1 unlimited
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x4 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: Upstream Port
	Capabilities: [d0] MSI-X: Enable+ Count=9 Masked-
		Vector table: BAR=0 offset=00002000
		PBA: BAR=0 offset=00003000
	Capabilities: [e0] MSI: Enable- Count=1/8 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [f8] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Capabilities: [110 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=10us PortTPowerOnTime=220us
		L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
			   T_CommonMode=0us LTR1.2_Threshold=0ns
		L1SubCtl2: T_PwrOn=10us
	Capabilities: [200 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 04000001 0000210f 52070000 6b192b64
	Capabilities: [300 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Kernel driver in use: nvme

53:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Cezanne (rev c9) (prog-if 00 [VGA controller])
	Subsystem: Gigabyte Technology Co., Ltd Device d000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort+ <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 24
	Region 0: Memory at c0000000 (64-bit, prefetchable) [size=256M]
	Region 2: Memory at d0000000 (64-bit, prefetchable) [size=2M]
	Region 4: I/O ports at e000 [size=256]
	Region 5: Memory at efc00000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [48] Vendor Specific Information: Len=08 <?>
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [64] Express (v2) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr+ FatalErr- UnsupReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x16 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Retimer+ 2Retimers+ DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable- Count=1/4 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [c0] MSI-X: Enable+ Count=4 Masked-
		Vector table: BAR=5 offset=00042000
		PBA: BAR=5 offset=00043000
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [270 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [2a0 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Capabilities: [2b0 v1] Address Translation Service (ATS)
		ATSCap:	Invalidate Queue Depth: 00
		ATSCtl:	Enable-, Smallest Translation Unit: 00
	Capabilities: [2c0 v1] Page Request Interface (PRI)
		PRICtl: Enable- Reset-
		PRISta: RF- UPRGI- Stopped+
		Page Request Capacity: 00000100, Page Request Allocation: 00000000
	Capabilities: [2d0 v1] Process Address Space ID (PASID)
		PASIDCap: Exec+ Priv+, Max PASID Width: 10
		PASIDCtl: Enable- Exec- Priv-
	Capabilities: [400 v1] Data Link Feature <?>
	Capabilities: [410 v1] Physical Layer 16.0 GT/s <?>
	Capabilities: [440 v1] Lane Margining at the Receiver <?>
	Kernel driver in use: amdgpu
	Kernel modules: amdgpu

53:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Device 1637
	Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Device 1637
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 123
	Region 0: Memory at efc88000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [48] Vendor Specific Information: Len=08 <?>
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [64] Express (v2) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x16 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee08000  Data: 0027
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [2a0 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel

53:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 10h-1fh) Platform Security Processor
	Subsystem: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 10h-1fh) Platform Security Processor
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 25
	Region 2: Memory at efb00000 (32-bit, non-prefetchable) [size=1M]
	Region 5: Memory at efc8c000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [48] Vendor Specific Information: Len=08 <?>
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [64] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x16 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable- Count=1/2 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [c0] MSI-X: Enable+ Count=2 Masked-
		Vector table: BAR=5 offset=00000000
		PBA: BAR=5 offset=00001000
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [2a0 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: ccp

53:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir USB 3.1 (prog-if 30 [XHCI])
	Subsystem: Gigabyte Technology Co., Ltd Renoir USB 3.1
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin D routed to IRQ 34
	Region 0: Memory at efa00000 (64-bit, non-prefetchable) [size=1M]
	Capabilities: [48] Vendor Specific Information: Len=08 <?>
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [64] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x16 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable- Count=1/8 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [c0] MSI-X: Enable+ Count=8 Masked-
		Vector table: BAR=0 offset=000fe000
		PBA: BAR=0 offset=000ff000
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [2a0 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci

53:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir USB 3.1 (prog-if 30 [XHCI])
	Subsystem: Gigabyte Technology Co., Ltd Renoir USB 3.1
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 24
	Region 0: Memory at ef900000 (64-bit, non-prefetchable) [size=1M]
	Capabilities: [48] Vendor Specific Information: Len=08 <?>
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [64] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x16 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable- Count=1/8 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [c0] MSI-X: Enable+ Count=8 Masked-
		Vector table: BAR=0 offset=000fe000
		PBA: BAR=0 offset=000ff000
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [2a0 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci

53:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 10h-1fh) HD Audio Controller
	DeviceName: Realtek ALC1220
	Subsystem: Gigabyte Technology Co., Ltd Family 17h (Models 10h-1fh) HD Audio Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 124
	Region 0: Memory at efc80000 (32-bit, non-prefetchable) [size=32K]
	Capabilities: [48] Vendor Specific Information: Len=08 <?>
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
	Capabilities: [64] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x16 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0a000  Data: 0027
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [2a0 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel


-[0000:00]-+-00.0  Advanced Micro Devices, Inc. [AMD] Renoir Root Complex
            +-00.2  Advanced Micro Devices, Inc. [AMD] Renoir IOMMU
            +-01.0  Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Host Bridge
            +-02.0  Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Host Bridge
            +-02.1-[01-51]--+-00.0  Advanced Micro Devices, Inc. [AMD] Device 43ee
            |               +-00.1  Advanced Micro Devices, Inc. [AMD] Device 43eb
            |               \-00.2-[02-51]--+-00.0-[03-4a]----00.0-[04-4a]--+-00.0-[05]----00.0  Intel Corporation JHL7540 Thunderbolt 3 NHI [Titan Ridge 4C 2018]
            |                               |                               +-01.0-[06-27]--
            |                               |                               +-02.0-[28]----00.0  Intel Corporation JHL7540 Thunderbolt 3 USB Controller [Titan Ridge 4C 2018]
            |                               |                               \-04.0-[29-4a]----00.0-[2a-4a]--+-00.0-[2b-2d]----00.0-[2c-2d]----03.0-[2d]--+-00.0  Pericom Semiconductor PI7C9X442SL USB OHCI Controller
            |                               |                                                               |                                            +-00.1  Pericom Semiconductor PI7C9X442SL USB OHCI Controller
            |                               |                                                               |                                            \-00.2  Pericom Semiconductor PI7C9X442SL USB EHCI Controller
            |                               |                                                               +-01.0-[2e]----00.0  Broadcom Inc. and subsidiaries NetXtreme BCM57761 Gigabit Ethernet PCIe
            |                               |                                                               +-02.0-[2f]----00.0  LSI Corporation FW643 [TrueFire] PCIe 1394b Controller
            |                               |                                                               +-04.0-[30-3f]--
            |                               |                                                               \-05.0-[40-4a]--
            |                               +-04.0-[4b]----00.0  Kingston Technology Company, Inc. Device 2262
            |                               +-08.0-[4c-50]----00.0-[4d-50]--+-00.0-[4e]----00.0  Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller
            |                               |                               +-06.0-[4f]--
            |                               |                               \-0e.0-[50]--
            |                               \-09.0-[51]----00.0  Intel Corporation Ethernet Controller I225-V
            +-02.2-[52]----00.0  Micron/Crucial Technology Device 540a
            +-08.0  Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Host Bridge
            +-08.1-[53]--+-00.0  Advanced Micro Devices, Inc. [AMD/ATI] Cezanne
            |            +-00.1  Advanced Micro Devices, Inc. [AMD/ATI] Device 1637
            |            +-00.2  Advanced Micro Devices, Inc. [AMD] Family 17h (Models 10h-1fh) Platform Security Processor
            |            +-00.3  Advanced Micro Devices, Inc. [AMD] Renoir USB 3.1
            |            +-00.4  Advanced Micro Devices, Inc. [AMD] Renoir USB 3.1
            |            \-00.6  Advanced Micro Devices, Inc. [AMD] Family 17h (Models 10h-1fh) HD Audio Controller
            +-14.0  Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller
            +-14.3  Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge
            +-18.0  Advanced Micro Devices, Inc. [AMD] Device 166a
            +-18.1  Advanced Micro Devices, Inc. [AMD] Device 166b
            +-18.2  Advanced Micro Devices, Inc. [AMD] Device 166c
            +-18.3  Advanced Micro Devices, Inc. [AMD] Device 166d
            +-18.4  Advanced Micro Devices, Inc. [AMD] Device 166e
            +-18.5  Advanced Micro Devices, Inc. [AMD] Device 166f
            +-18.6  Advanced Micro Devices, Inc. [AMD] Device 1670
            \-18.7  Advanced Micro Devices, Inc. [AMD] Device 1671


Regards,
Brad
