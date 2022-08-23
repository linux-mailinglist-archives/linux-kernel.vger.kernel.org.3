Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8068D59E92A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbiHWRSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238953AbiHWRRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:17:16 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39922140CE2;
        Tue, 23 Aug 2022 06:48:54 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id BD16661EA192D;
        Tue, 23 Aug 2022 15:48:52 +0200 (CEST)
Message-ID: <63a60042-4a4a-3bc3-5fa1-4495d80cc06c@molgen.mpg.de>
Date:   Tue, 23 Aug 2022 15:48:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: WARNING: CPU: 1 PID: 83 at arch/x86/kernel/cpu/sgx/main.c:446
 ksgxd+0x1b7/0x1d0
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Dave Hansen <dave.hansen@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-sgx@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <ce0b4d26-3a6e-7c5a-5f66-44cba05f9f35@molgen.mpg.de>
 <4253695b-85aa-a2fb-fbf6-718db8b6c20c@molgen.mpg.de>
 <46e3483b-a5ab-2a05-8a28-f9ea87e881c3@intel.com>
 <04c9d5fa-5861-bbc3-3e2f-e18a73866645@molgen.mpg.de>
In-Reply-To: <04c9d5fa-5861-bbc3-3e2f-e18a73866645@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Dave,


Am 20.08.22 um 08:13 schrieb Paul Menzel:

> Am 19.08.22 um 20:28 schrieb Dave Hansen:
>> On 8/19/22 09:02, Paul Menzel wrote:
>>> On the Dell XPS 13 9370, Linux 5.18.16 prints the warning below:
>>>
>>> ```
>>> [    0.000000] Linux version 5.18.0-4-amd64 (debian-kernel@lists.debian.org) (gcc-11 (Debian 11.3.0-5) 11.3.0, GNU ld (GNU Binutils for Debian) 2.38.90.20220713) #1 SMP PREEMPT_DYNAMIC Debian 5.18.16-1 (2022-08-10)
>>> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.18.0-4-amd64 root=UUID=56f398e0-1e25-4fda-aa9f-611dece4b333 ro quiet
>>> […]
>>> [    0.000000] DMI: Dell Inc. XPS 13 9370/0RMYH9, BIOS 1.21.0 07/06/2022
>>> […]
>>> [    0.235418] sgx: EPC section 0x40200000-0x45f7ffff
> 
>> Would you be able to send the entire dmesg, along with:
> 
> The log message are attached to the first message, where I missed to 
> carbon-copy linux-sgx@ [1].
> 
>>     cat /proc/iomem # (as root)
>> and
>>     cpuid -1 --raw
> 
> I am going to provide that next week. (Side note, Intel might have some 
> Dell XPS 9370 test machines in some QA lab.)

Please find both outputs at the end of the file.

>> I'm suspecting either a BIOS problem.  Reinette (cc'd) also thought this
>> might be a case of the SGX initialization getting a bit too far along
>> when it should have been disabled.
>>
>> We had some bugs where we didn't stop fast enough after spitting out the
>> "SGX Launch Control is locked..." errors.

Let’s hope it’s something known to you.


Kind regards,

Paul


> [1]: https://lore.kernel.org/lkml/ce0b4d26-3a6e-7c5a-5f66-44cba05f9f35@molgen.mpg.de/


PS:

$ sudo cat /proc/iomem
[sudo] password for molgenit:
00000000-00000fff : Reserved
00001000-00057fff : System RAM
00058000-00058fff : Reserved
00059000-0009dfff : System RAM
0009e000-000fffff : Reserved
   00000000-00000000 : PCI Bus 0000:00
   00000000-00000000 : PCI Bus 0000:00
   00000000-00000000 : PCI Bus 0000:00
   00000000-00000000 : PCI Bus 0000:00
   00000000-00000000 : PCI Bus 0000:00
   00000000-00000000 : PCI Bus 0000:00
   00000000-00000000 : PCI Bus 0000:00
   00000000-00000000 : PCI Bus 0000:00
   000a0000-000dffff : PCI Bus 0000:00
     000c0000-000dffff : 0000:00:02.0
   000f0000-000fffff : System ROM
00100000-2d6c4fff : System RAM
2d6c5000-2d6c5fff : ACPI Non-volatile Storage
2d6c6000-2d6c6fff : Reserved
2d6c7000-3b6acfff : System RAM
3b6ad000-3b720fff : Reserved
3b721000-3ecf1fff : System RAM
3ecf2000-3f0b1fff : Reserved
3f0b2000-3f0fefff : ACPI Tables
3f0ff000-3f7b6fff : ACPI Non-volatile Storage
   3f798000-3f798fff : USBC000:00
3f7b7000-3ff25fff : Reserved
3ff26000-3fffefff : Unknown E820 type
3ffff000-3fffffff : System RAM
40000000-47ffffff : Reserved
   40200000-45f7ffff : INT0E0C:00
48000000-48dfffff : System RAM
48e00000-4f7fffff : Reserved
   4b800000-4f7fffff : Graphics Stolen Memory
4f800000-dfffffff : PCI Bus 0000:00
   50000000-5fffffff : 0000:00:02.0
   60000000-a9ffffff : PCI Bus 0000:03
   ac000000-da0fffff : PCI Bus 0000:03
   db000000-dbffffff : 0000:00:02.0
   dc000000-dc0fffff : PCI Bus 0000:6e
     dc000000-dc003fff : 0000:6e:00.0
       dc000000-dc003fff : nvme
   dc100000-dc1fffff : PCI Bus 0000:02
     dc100000-dc101fff : 0000:02:00.0
       dc100000-dc101fff : iwlwifi
   dc200000-dc2fffff : PCI Bus 0000:01
     dc200000-dc200fff : 0000:01:00.0
       dc200000-dc200fff : rtsx_pci
   dc300000-dc30ffff : 0000:00:1f.3
   dc310000-dc31ffff : 0000:00:14.0
     dc310000-dc31ffff : xhci-hcd
       dc318070-dc31846f : intel_xhci_usb_sw
   dc320000-dc327fff : 0000:00:04.0
     dc320000-dc327fff : proc_thermal
   dc328000-dc32bfff : 0000:00:1f.3
     dc328000-dc32bfff : ICH HD audio
   dc32c000-dc32ffff : 0000:00:1f.2
   dc330000-dc3300ff : 0000:00:1f.4
   dc331000-dc331fff : 0000:00:16.3
   dc332000-dc332fff : 0000:00:16.0
     dc332000-dc332fff : mei_me
   dc333000-dc333fff : 0000:00:15.1
     dc333000-dc3331ff : lpss_dev
       dc333000-dc3331ff : i2c_designware.1 lpss_dev
     dc333200-dc3332ff : lpss_priv
     dc333800-dc333fff : idma64.1
       dc333800-dc333fff : idma64.1 idma64.1
   dc334000-dc334fff : 0000:00:15.0
     dc334000-dc3341ff : lpss_dev
       dc334000-dc3341ff : i2c_designware.0 lpss_dev
     dc334200-dc3342ff : lpss_priv
     dc334800-dc334fff : idma64.0
       dc334800-dc334fff : idma64.0 idma64.0
   dc335000-dc335fff : 0000:00:14.2
     dc335000-dc335fff : Intel PCH thermal driver
   dffe0000-dfffffff : pnp 00:05
e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
   e0000000-efffffff : Reserved
     e0000000-efffffff : pnp 00:05
fd000000-fe7fffff : PCI Bus 0000:00
   fd000000-fdabffff : pnp 00:06
   fdac0000-fdacffff : INT344B:00
     fdac0000-fdacffff : INT344B:00 INT344B:00
   fdad0000-fdadffff : pnp 00:06
   fdae0000-fdaeffff : INT344B:00
     fdae0000-fdaeffff : INT344B:00 INT344B:00
   fdaf0000-fdafffff : INT344B:00
     fdaf0000-fdafffff : INT344B:00 INT344B:00
   fdb00000-fdffffff : pnp 00:06
     fdc6000c-fdc6000f : iTCO_wdt
       fdc6000c-fdc6000f : iTCO_wdt iTCO_wdt
   fe000000-fe010fff : Reserved
   fe028000-fe028fff : pnp 00:08
   fe029000-fe029fff : pnp 00:08
   fe036000-fe03bfff : pnp 00:06
   fe03d000-fe3fffff : pnp 00:06
   fe410000-fe7fffff : pnp 00:06
fec00000-fec00fff : Reserved
   fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
   fed00000-fed003ff : PNP0103:00
fed10000-fed17fff : pnp 00:05
fed18000-fed18fff : pnp 00:05
fed19000-fed19fff : pnp 00:05
fed20000-fed3ffff : pnp 00:05
fed40000-fed44fff : MSFT0101:00
   fed40000-fed44fff : MSFT0101:00 MSFT0101:00
fed45000-fed8ffff : pnp 00:05
fed90000-fed90fff : dmar0
fed91000-fed91fff : dmar1
fee00000-fee00fff : Local APIC
   fee00000-fee00fff : Reserved
ff000000-ffffffff : Reserved
   ff000000-ffffffff : INT0800:00
     ff000000-ffffffff : pnp 00:05
100000000-2ae7fffff : System RAM
   190c00000-191801987 : Kernel code
   191a00000-19225ffff : Kernel rodata
   192400000-1926b57bf : Kernel data
   192d2b000-1931fffff : Kernel bss
2ae800000-2afffffff : RAM buffer

$ sudo cpuid -1 --raw
CPU:
    0x00000000 0x00: eax=0x00000016 ebx=0x756e6547 ecx=0x6c65746e 
edx=0x49656e69
    0x00000001 0x00: eax=0x000806ea ebx=0x00100800 ecx=0x7ffafbff 
edx=0xbfebfbff
    0x00000002 0x00: eax=0x76036301 ebx=0x00f0b5ff ecx=0x00000000 
edx=0x00c30000
    0x00000003 0x00: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 
edx=0x00000000
    0x00000004 0x00: eax=0x1c004121 ebx=0x01c0003f ecx=0x0000003f 
edx=0x00000000
    0x00000004 0x01: eax=0x1c004122 ebx=0x01c0003f ecx=0x0000003f 
edx=0x00000000
    0x00000004 0x02: eax=0x1c004143 ebx=0x00c0003f ecx=0x000003ff 
edx=0x00000000
    0x00000004 0x03: eax=0x1c03c163 ebx=0x02c0003f ecx=0x00001fff 
edx=0x00000006
    0x00000004 0x04: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 
edx=0x00000000
    0x00000005 0x00: eax=0x00000040 ebx=0x00000040 ecx=0x00000003 
edx=0x11142120
    0x00000006 0x00: eax=0x000027f7 ebx=0x00000002 ecx=0x00000009 
edx=0x00000000
    0x00000007 0x00: eax=0x00000000 ebx=0x029c67af ecx=0x00000000 
edx=0xbc002e00
    0x00000008 0x00: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 
edx=0x00000000
    0x00000009 0x00: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 
edx=0x00000000
    0x0000000a 0x00: eax=0x07300404 ebx=0x00000000 ecx=0x00000000 
edx=0x00000603
    0x0000000b 0x00: eax=0x00000001 ebx=0x00000002 ecx=0x00000100 
edx=0x00000000
    0x0000000b 0x01: eax=0x00000004 ebx=0x00000008 ecx=0x00000201 
edx=0x00000000
    0x0000000b 0x02: eax=0x00000000 ebx=0x00000000 ecx=0x00000002 
edx=0x00000000
    0x0000000c 0x00: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 
edx=0x00000000
    0x0000000d 0x00: eax=0x0000001f ebx=0x00000440 ecx=0x00000440 
edx=0x00000000
    0x0000000d 0x01: eax=0x0000000f ebx=0x000003c0 ecx=0x00000100 
edx=0x00000000
    0x0000000d 0x02: eax=0x00000100 ebx=0x00000240 ecx=0x00000000 
edx=0x00000000
    0x0000000d 0x03: eax=0x00000040 ebx=0x000003c0 ecx=0x00000000 
edx=0x00000000
    0x0000000d 0x04: eax=0x00000040 ebx=0x00000400 ecx=0x00000000 
edx=0x00000000
    0x0000000d 0x08: eax=0x00000080 ebx=0x00000000 ecx=0x00000001 
edx=0x00000000
    0x0000000e 0x00: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 
edx=0x00000000
    0x0000000f 0x00: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 
edx=0x00000000
    0x00000010 0x00: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 
edx=0x00000000
    0x00000011 0x00: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 
edx=0x00000000
    0x00000012 0x00: eax=0x00000001 ebx=0x00000000 ecx=0x00000000 
edx=0x0000241f
    0x00000012 0x01: eax=0x00000036 ebx=0x00000000 ecx=0x0000001f 
edx=0x00000000
    0x00000012 0x02: eax=0x40200001 ebx=0x00000000 ecx=0x05d80001 
edx=0x00000000
    0x00000012 0x03: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 
edx=0x00000000
    0x00000013 0x00: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 
edx=0x00000000
    0x00000014 0x00: eax=0x00000001 ebx=0x0000000f ecx=0x00000007 
edx=0x00000000
    0x00000014 0x01: eax=0x02490002 ebx=0x003f3fff ecx=0x00000000 
edx=0x00000000
    0x00000015 0x00: eax=0x00000002 ebx=0x0000009e ecx=0x00000000 
edx=0x00000000
    0x00000016 0x00: eax=0x0000076c ebx=0x00000e10 ecx=0x00000064 
edx=0x00000000
    0x20000000 0x00: eax=0x0000076c ebx=0x00000e10 ecx=0x00000064 
edx=0x00000000
    0x80000000 0x00: eax=0x80000008 ebx=0x00000000 ecx=0x00000000 
edx=0x00000000
    0x80000001 0x00: eax=0x00000000 ebx=0x00000000 ecx=0x00000121 
edx=0x2c100800
    0x80000002 0x00: eax=0x65746e49 ebx=0x2952286c ecx=0x726f4320 
edx=0x4d542865
    0x80000003 0x00: eax=0x35692029 ebx=0x3533382d ecx=0x43205530 
edx=0x40205550
    0x80000004 0x00: eax=0x372e3120 ebx=0x7a484730 ecx=0x00000000 
edx=0x00000000
    0x80000005 0x00: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 
edx=0x00000000
    0x80000006 0x00: eax=0x00000000 ebx=0x00000000 ecx=0x01006040 
edx=0x00000000
    0x80000007 0x00: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 
edx=0x00000100
    0x80000008 0x00: eax=0x00003027 ebx=0x00000000 ecx=0x00000000 
edx=0x00000000
    0x80860000 0x00: eax=0x0000076c ebx=0x00000e10 ecx=0x00000064 
edx=0x00000000
    0xc0000000 0x00: eax=0x0000076c ebx=0x00000e10 ecx=0x00000064 
edx=0x00000000
