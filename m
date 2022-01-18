Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F11492BC9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346964AbiARRBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 12:01:10 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:58769 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346368AbiARRBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:01:09 -0500
Received: from [192.168.0.2] (ip5f5aecd1.dynamic.kabel-deutschland.de [95.90.236.209])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1154261EA1BE6;
        Tue, 18 Jan 2022 18:01:07 +0100 (CET)
Message-ID: <fd1c1767-0029-58d2-3878-5bc1a85b8e2c@molgen.mpg.de>
Date:   Tue, 18 Jan 2022 18:01:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: nvme: IO_PAGE_FAULT logged with Intel SSDPEKKF512G8
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <366b1545-fdea-3423-10a7-308ca2bef746@molgen.mpg.de>
 <20220118165325.GA3301052@dhcp-10-100-145-180.wdc.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220118165325.GA3301052@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Keith,


Thank you for your quick response.


Am 18.01.22 um 17:53 schrieb Keith Busch:
> On Tue, Jan 18, 2022 at 03:32:45PM +0100, Paul Menzel wrote:
>> On a Dell OptiPlex 5055 with an Intel SSDPEKKF512G8, Linux 5.10.82 reported
>> an IO_PAGE_FAULT error. This is the first and only time this has happened.
>>
>>      $ dmesg --level=err
>>      [    4.194306] nvme 0000:01:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000c address=0xffffc080 flags=0x0050]
>>      [    4.206970] nvme 0000:01:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000c address=0xffffc000 flags=0x0050]
>>      [    7.327820] kfd kfd: VERDE  not supported in kfd
>>      $ lspci -nn -s 01:00.0
>>      01:00.0 Non-Volatile memory controller [0108]: Intel Corporation SSD Pro 7600p/760p/E 6100p Series [8086:f1a6] (rev 03)
> 
> I think it's a bug with the iommu implementation.

That would surprise me, but I am adding Jörg and Suravee to the 
recipient list. Last time, I saw an IO_PAGE_FAULT, it was a bug in the 
amdgpu driver.

> If it causes problems, you can typically work around it with kernel
> parameter "iommu=soft".

I have not noticed any problems yet.


Kind regards,

Paul


PS: No idea, if useful, but I include the content of `/proc/iomem`:

$ sudo more /proc/iomem
00000000-00000fff : Reserved
00001000-00087fff : System RAM
00088000-00088fff : Reserved
00089000-0009efff : System RAM
0009f000-000bffff : Reserved
   000a0000-000bffff : PCI Bus 0000:00
000c0000-000c3fff : PCI Bus 0000:00
000c4000-000c7fff : PCI Bus 0000:00
000c8000-000cbfff : PCI Bus 0000:00
000cc000-000cffff : PCI Bus 0000:00
000d0000-000d3fff : PCI Bus 0000:00
000d4000-000d7fff : PCI Bus 0000:00
000d8000-000dbfff : PCI Bus 0000:00
000dc000-000dffff : PCI Bus 0000:00
000e0000-000e3fff : PCI Bus 0000:00
000e4000-000e7fff : PCI Bus 0000:00
000e8000-000ebfff : PCI Bus 0000:00
000ec000-000effff : PCI Bus 0000:00
000f0000-000fffff : System ROM
00100000-09cfffff : System RAM
   05000000-05e03316 : Kernel code
   06000000-063a8fff : Kernel rodata
   06400000-06762eff : Kernel data
   06d31000-06ffffff : Kernel bss
09d00000-09e6ffff : Reserved
09e70000-7afb5fff : System RAM
7afb6000-7afb6fff : Reserved
7afb7000-7afbbfff : System RAM
7afbc000-7afbcfff : Reserved
7afbd000-dadbefff : System RAM
dadbf000-dafbefff : Unknown E820 type
dafbf000-dcfbefff : Reserved
dcfbf000-defbefff : ACPI Non-volatile Storage
defbf000-deffefff : ACPI Tables
defff000-deffffff : System RAM
df000000-dfffffff : Reserved
e0000000-f7ffffff : PCI Bus 0000:00
   e0000000-efffffff : PCI Bus 0000:06
     e0000000-efffffff : 0000:06:00.0
   f0000000-f00fffff : PCI Bus 0000:02
     f0000000-f00fffff : PCI Bus 0000:03
       f0000000-f00fffff : PCI Bus 0000:04
         f0000000-f000ffff : 0000:04:00.0
           f0000000-f000ffff : tg3
         f0010000-f001ffff : 0000:04:00.0
           f0010000-f001ffff : tg3
         f0020000-f002ffff : 0000:04:00.0
           f0020000-f002ffff : tg3
   f0100000-f01fffff : PCI Bus 0000:08
     f0100000-f0107fff : 0000:08:00.3
       f0100000-f0107fff : ICH HD audio
     f0108000-f0108fff : 0000:08:00.2
       f0108000-f0108fff : ahci
   f0200000-f04fffff : PCI Bus 0000:07
     f0200000-f02fffff : 0000:07:00.3
       f0200000-f02fffff : xhci-hcd
     f0300000-f03fffff : 0000:07:00.2
     f0400000-f0401fff : 0000:07:00.2
   f0500000-f05fffff : PCI Bus 0000:06
     f0500000-f053ffff : 0000:06:00.0
     f0540000-f0543fff : 0000:06:00.1
       f0540000-f0543fff : ICH HD audio
     f0560000-f057ffff : 0000:06:00.0
   f0600000-f06fffff : PCI Bus 0000:02
     f0600000-f061ffff : 0000:02:00.1
       f0600000-f061ffff : ahci
     f0620000-f0627fff : 0000:02:00.0
       f0620000-f0627fff : xhci-hcd
     f0680000-f06fffff : 0000:02:00.1
   f0700000-f07fffff : PCI Bus 0000:01
     f0700000-f0703fff : 0000:01:00.0
       f0700000-f0703fff : nvme
f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
   f8000000-fbffffff : Reserved
fc000000-feafffff : PCI Bus 0000:00
   fc000000-fc07ffff : amd_iommu
   fdf00000-fdffffff : pnp 00:00
fec00000-fec00fff : Reserved
   fec00000-fec003ff : IOAPIC 0
fec01000-fec013ff : IOAPIC 1
fec10000-fec10fff : Reserved
fec30000-fec30fff : AMDIF030:00
fed00000-fed003ff : HPET 0
   fed00000-fed003ff : PNP0103:00
fed40000-fed44fff : MSFT0101:00
fed80000-fed80fff : Reserved
fed81500-fed818ff : AMDI0030:00
fee00000-fee00fff : Local APIC
   fee00000-fee00fff : pnp 00:00
ff000000-ffffffff : Reserved
   ff000000-ffffffff : pnp 00:03
100000000-81effffff : System RAM
81f000000-81fffffff : RAM buffer
