Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A42658C850
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 14:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242785AbiHHM0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 08:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237179AbiHHM0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:26:05 -0400
Received: from ns3.fnarfbargle.com (ns3.fnarfbargle.com [103.4.19.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCCA634B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 05:26:03 -0700 (PDT)
Received: from [10.8.0.1] (helo=srv.home)
        by ns3.fnarfbargle.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1oL1pZ-0003zH-H4; Mon, 08 Aug 2022 22:26:01 +1000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fnarfbargle.com; s=mail; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5d16od//EvGvPTszWarD6cEBfCrpsO8adLEmKQMrBcs=; b=cXQHF3sOoUNaZwDS6bhVaKMiHQ
        SLRVxn391yXQcSvFnaP7y26PL1sclXvzQCviM8e2qNa1qt3+fK1o4mBnGw0Ywf9Ce3tRIaQGIXkxp
        oFUDYo+dqesAoT7dt6GtG5Mi2efZTcOk7JSvh6Uio6E0g1DlFv6CyglpKcEUngHNLFm4=;
Message-ID: <5474e599-057a-ec0f-b469-560644155907@fnarfbargle.com>
Date:   Mon, 8 Aug 2022 20:25:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Apple Thunderbolt Display chaining
Content-Language: en-US
From:   Brad Campbell <lists2009@fnarfbargle.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
References: <Yk2qMt568oEeTj8H@lahna>
 <49183e52-2e73-b32f-11ad-6036b1040d7c@fnarfbargle.com>
 <Yuz/Q3MTVIhCZU+0@lahna>
 <f5c8b9f0-0d6d-c6db-ae0b-894acb58d078@fnarfbargle.com>
 <Yu0UuOVGeIv/U+jU@lahna>
 <d484d7e5-f1aa-1096-e6fb-bbf16ce28699@fnarfbargle.com>
 <Yu0nWro4xXURbSX6@lahna>
 <87c1a001-ef79-6390-dfe2-06d2850f6e84@fnarfbargle.com>
 <Yu4Gmkous7asng6h@lahna>
 <42e81a8e-e393-7a69-7339-a020ebb57935@fnarfbargle.com>
 <YvDcudE5BRtZAtfM@lahna>
 <a1db1454-63b6-7c39-bbf6-53e53bbd36e6@fnarfbargle.com>
In-Reply-To: <a1db1454-63b6-7c39-bbf6-53e53bbd36e6@fnarfbargle.com>
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



On 8/8/22 19:55, Brad Campbell wrote:
> G'day Mika,
> 
> On 8/8/22 17:51, Mika Westerberg wrote:
>> Hi,
>>
>> On Sat, Aug 06, 2022 at 05:41:37PM +0800, Brad Campbell wrote:
>>> I've left in the patch to not set up the DP tunnel and recompiled with CONFIG_PCI_DEBUG=y
>>>
>>> The minimum I can use to reproduce the fault is a single Thunderbolt display. The Apple TB->GBe dongle doesn't do it
>>> and I have a TB->USB3+eSATA dongle that won't run on the TB3->TB1 adapter due to insufficient power.
>>>
>>> This is captured with serial console. It's a cold boot with a single TB display connected. Boots to desktop and I immediately issue a reboot.
>>>
>>> From -> [   15.337689] xhci_hcd 0000:53:00.3: xHCI Host Controller <- on the second boot, the console output slows to
>>> about 1-2 characters per second (nothing updates on the monitor) and eventually the machine reboots by itself. I don't have reboot on panic set.
>>
>> I noticed that the device links are not set for AR/TR devices but it
>> probably does not help here. Anyway can you try the below patch just in
>> case?
>>
>> I did not see anything that stands out from the logs so next step would
>> be to unbind the drivers for each PCIe device of the TBT display and see
>> if that helps (so we can narrow this down to a specific driver). You can
>> either just unload the whole driver (rmmod or modprobe -r) or
>> "echo XXXX > /sys/pci/drivers/DRIVER/unbind". Where XXXX is the PCI
>> device name, like 0000:00:2a.0 and so on.
> 
> It's not looking driver specific. The only 2 drivers I have for that device are the tg3
> and o/ehci drivers.
>  
>> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
>> index 8030fc544c5e..bfe023030b90 100644
>> --- a/drivers/thunderbolt/tb.c
>> +++ b/drivers/thunderbolt/tb.c
>> @@ -2181,6 +2181,10 @@ static void tb_apple_add_links(struct tb_nhi *nhi)
>>  	case PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C:
>>  	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI:
>>  	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI:
>> +	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_NHI:
>> +	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_NHI:
>> +	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_NHI:
>> +	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_NHI:
>>  		break;
>>  	default:
>>  		return;
>>
> 
> Applied that patch. No change unfortunately.
> 
> I unloaded the tg3 driver and all usb ([xeo]hci) drivers and still ran into the problem.
> Less so in that the machine responds to a ps2 keyboard and the magic-sysrq keys _slowly and
> still reboots "randomly".
> 
> lspci straight after boot :
> 
> 00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Root Complex
> 00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Renoir IOMMU
> 00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Host Bridge
> 00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Host Bridge
> 00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP Bridge
> 00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP Bridge
> 00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Host Bridge
> 00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal PCIe GPP Bridge to Bus
> 00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev 51)
> 00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev 51)
> 00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 166a
> 00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 166b
> 00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 166c
> 00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 166d
> 00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 166e
> 00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 166f
> 00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1670
> 00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1671
> 01:00.0 USB controller: Advanced Micro Devices, Inc. [AMD] Device 43ee
> 01:00.1 SATA controller: Advanced Micro Devices, Inc. [AMD] Device 43eb
> 01:00.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 43e9
> 02:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 43ea
> 02:04.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 43ea
> 02:08.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 43ea
> 02:09.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 43ea
> 03:00.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06)
> 04:00.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06)
> 04:01.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06)
> 04:02.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06)
> 04:04.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06)
> 05:00.0 System peripheral: Intel Corporation JHL7540 Thunderbolt 3 NHI [Titan Ridge 4C 2018] (rev 06)
> 28:00.0 USB controller: Intel Corporation JHL7540 Thunderbolt 3 USB Controller [Titan Ridge 4C 2018] (rev 06)
> 29:00.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010]
> 2a:00.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010]
> 2a:01.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010]
> 2a:02.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010]
> 2a:04.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010]
> 2a:05.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010]
> 2b:00.0 PCI bridge: Pericom Semiconductor Device 400c (rev 02)
> 2c:03.0 PCI bridge: Pericom Semiconductor Device 400c (rev 02)
> 2d:00.0 USB controller: Pericom Semiconductor PI7C9X442SL USB OHCI Controller (rev 01)
> 2d:00.1 USB controller: Pericom Semiconductor PI7C9X442SL USB OHCI Controller (rev 01)
> 2d:00.2 USB controller: Pericom Semiconductor PI7C9X442SL USB EHCI Controller (rev 01)
> 2e:00.0 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme BCM57761 Gigabit Ethernet PCIe (rev 10)
> 2f:00.0 FireWire (IEEE 1394): LSI Corporation FW643 [TrueFire] PCIe 1394b Controller (rev 08)
> 30:00.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010]
> 31:00.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010]
> 31:01.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010]
> 31:02.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010]
> 31:04.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010]
> 31:05.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010]
> 32:00.0 PCI bridge: Pericom Semiconductor Device 400c (rev 02)
> 33:03.0 PCI bridge: Pericom Semiconductor Device 400c (rev 02)
> 34:00.0 USB controller: Pericom Semiconductor PI7C9X442SL USB OHCI Controller (rev 01)
> 34:00.1 USB controller: Pericom Semiconductor PI7C9X442SL USB OHCI Controller (rev 01)
> 34:00.2 USB controller: Pericom Semiconductor PI7C9X442SL USB EHCI Controller (rev 03)
> 35:00.0 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme BCM57761 Gigabit Ethernet PCIe (rev 10)
> 36:00.0 FireWire (IEEE 1394): LSI Corporation FW643 [TrueFire] PCIe 1394b Controller (rev 08)
> 4b:00.0 Non-Volatile memory controller: Kingston Technology Company, Inc. Device 2262 (rev 03)
> 4c:00.0 PCI bridge: ASMedia Technology Inc. Device 1806 (rev 01)
> 4d:00.0 PCI bridge: ASMedia Technology Inc. Device 1806 (rev 01)
> 4d:06.0 PCI bridge: ASMedia Technology Inc. Device 1806 (rev 01)
> 4d:0e.0 PCI bridge: ASMedia Technology Inc. Device 1806 (rev 01)
> 4e:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller (rev 05)
> 51:00.0 Ethernet controller: Intel Corporation Ethernet Controller I225-V (rev 01)
> 52:00.0 Non-Volatile memory controller: Micron/Crucial Technology Device 540a (rev 01)
> 53:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Cezanne (rev c9)
> 53:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Device 1637
> 53:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 10h-1fh) Platform Security Processor
> 53:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir USB 3.1
> 53:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir USB 3.1
> 53:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 10h-1fh) HD Audio Controller
> 

And now we are getting somewhere. It's when we hit the Light Ridge controller :
 
root@bkd:/sys/bus/pci/devices/0000:31:04.0# time cat config | hexdump
0000000 8086 1513 0007 0010 0000 0604 0010 0001
0000010 0000 0000 0000 0000 3731 0037 01f1 0000
0000020 fff0 0000 fff1 0001 0000 0000 0000 0000
0000030 0000 0000 0080 0000 0000 0000 01ff 0002
0000040 0000 0000 0000 0000 0000 0000 0000 0000
*
0000080 8801 fe03 2008 0a00 c005 008a 0000 0000
0000090 0000 0000 0000 0000 0000 0000 0000 0000
*
00000c0 0010 0162 8020 0000 291f 0010 fc41 0433
00000d0 0000 1041 0060 0020 1038 0000 0000 0000
00000e0 0000 0000 0000 0000 0000 0000 0000 0000
00000f0 0000 0001 0000 0000 0000 0000 0000 0000
0000100 0003 2001 a000 00c9 0000 0100 0000 0000
0000110 0000 0000 0000 0000 0000 0000 0000 0000
*
0000200 0001 3001 0000 0000 0000 0000 2030 0006
0000210 0000 0000 2000 0000 0000 0000 0000 0000
0000220 0000 0000 0000 0000 0000 0000 0000 0000
*
0000300 0002 4001 0000 0000 0000 0000 0000 0000
0000310 0000 0000 00ff 8000 0000 0002 0000 0000
0000320 0000 0000 0000 0000 0000 0000 0000 0000
*
0000400 0004 5001 0000 0000 82a5 0007 0000 0000
0000410 0000 0000 0000 0000 0000 0000 0000 0000
*
0000500 000b 0001 1234 01c1 0950 0000 0039 0000
0000510 0000 0000 0000 0000 0000 0000 0000 0000
*
0001000

real	0m0.005s
user	0m0.005s
sys	0m0.000s
root@bkd:/sys/bus/pci/devices/0000:31:04.0# modprobe thunderbolt
root@bkd:/sys/bus/pci/devices/0000:31:04.0# time cat config | hexdump

<slowdown/lockup/reboot>

This on the serial console : 
[  160.248275] ACPI: bus type thunderbolt registered
[  160.253386] thunderbolt 0000:05:00.0: enabling device (0000 -> 0002)
[  160.872438] thunderbolt 0-3: new device found, vendor=0x1 device=0x8002
[  160.879398] thunderbolt 0-3: Apple, Inc. Thunderbolt Display
[  161.436984] thunderbolt 0-303: new device found, vendor=0x1 device=0x8002
[  161.444108] thunderbolt 0-303: Apple, Inc. Thunderbolt Display
[  165.324982] hrtimer: interrupt took 604007930 ns
[  169.744439] xhci_hcd 0000:28:00.0: Unable to change power state from D3hot to D0, device inaccessible
[  223.912783] rcu: INFO: rcu_preempt self-detected stall on CPU
[  229.741463] rcu:     9-....: (126 ticks this GP) idle=0d44/1/0x4000000000000000 softirq=1935/1935 fqs=76
[  237.593512]  (t=7349 jiffies g=1537 q=264 ncpus=12)
[  242.425503] NMI backtrace for cpu 9
[  244.640203] CPU: 9 PID: 57 Comm: ksoftirqd/9 Tainted: G           O       5.19.0+ #57
[  251.082940] Hardware name: Gigabyte Technology Co., Ltd. B550 VISION D-P/B550 VISION D-P, BIOS F15d 07/20/2022
[  258.532330] Call Trace:
[  260.545693]  <IRQ>
[  262.156386]  dump_stack_lvl+0x34/0x44
[  264.985085]  nmi_cpu_backtrace.cold+0x30/0x70
[  268.800445]  ? lapic_can_unplug_cpu+0x90/0x90
[  273.028459]  nmi_trig


Regards,
Brad
