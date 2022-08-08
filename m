Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F04958C7F2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 13:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242483AbiHHLzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 07:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237973AbiHHLzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 07:55:23 -0400
Received: from ns3.fnarfbargle.com (ns3.fnarfbargle.com [103.4.19.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724ECF69
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 04:55:21 -0700 (PDT)
Received: from [10.8.0.1] (helo=srv.home)
        by ns3.fnarfbargle.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1oL1Lq-0003yv-OE; Mon, 08 Aug 2022 21:55:18 +1000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fnarfbargle.com; s=mail; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/1rJR5Kh8hGOWFyH6oMUsGviKwkVrHoYYgGsIQ3XoRY=; b=FH5J+lEykWOxJtZnmg9MMumzHy
        jgci2eAPPTR/D+7iTLzqp0Hf8IDkJ/vWr5q8TOqeIExEN/OIA1nCi6K+YetbPIUQstUmVzibHYjec
        wwURv5V8fpMUvZLhUVjfYAnIOIYnk2bdkpxH8Me+N/vrooV9FqPfuPbbTDaSqrmgBmrM=;
Message-ID: <a1db1454-63b6-7c39-bbf6-53e53bbd36e6@fnarfbargle.com>
Date:   Mon, 8 Aug 2022 19:55:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Apple Thunderbolt Display chaining
Content-Language: en-US
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
From:   Brad Campbell <lists2009@fnarfbargle.com>
In-Reply-To: <YvDcudE5BRtZAtfM@lahna>
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

G'day Mika,

On 8/8/22 17:51, Mika Westerberg wrote:
> Hi,
> 
> On Sat, Aug 06, 2022 at 05:41:37PM +0800, Brad Campbell wrote:
>> I've left in the patch to not set up the DP tunnel and recompiled with CONFIG_PCI_DEBUG=y
>>
>> The minimum I can use to reproduce the fault is a single Thunderbolt display. The Apple TB->GBe dongle doesn't do it
>> and I have a TB->USB3+eSATA dongle that won't run on the TB3->TB1 adapter due to insufficient power.
>>
>> This is captured with serial console. It's a cold boot with a single TB display connected. Boots to desktop and I immediately issue a reboot.
>>
>> From -> [   15.337689] xhci_hcd 0000:53:00.3: xHCI Host Controller <- on the second boot, the console output slows to
>> about 1-2 characters per second (nothing updates on the monitor) and eventually the machine reboots by itself. I don't have reboot on panic set.
> 
> I noticed that the device links are not set for AR/TR devices but it
> probably does not help here. Anyway can you try the below patch just in
> case?
> 
> I did not see anything that stands out from the logs so next step would
> be to unbind the drivers for each PCIe device of the TBT display and see
> if that helps (so we can narrow this down to a specific driver). You can
> either just unload the whole driver (rmmod or modprobe -r) or
> "echo XXXX > /sys/pci/drivers/DRIVER/unbind". Where XXXX is the PCI
> device name, like 0000:00:2a.0 and so on.

It's not looking driver specific. The only 2 drivers I have for that device are the tg3
and o/ehci drivers.
 
> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> index 8030fc544c5e..bfe023030b90 100644
> --- a/drivers/thunderbolt/tb.c
> +++ b/drivers/thunderbolt/tb.c
> @@ -2181,6 +2181,10 @@ static void tb_apple_add_links(struct tb_nhi *nhi)
>  	case PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C:
>  	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI:
>  	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI:
> +	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_NHI:
> +	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_NHI:
> +	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_NHI:
> +	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_NHI:
>  		break;
>  	default:
>  		return;
> 

Applied that patch. No change unfortunately.

I unloaded the tg3 driver and all usb ([xeo]hci) drivers and still ran into the problem.
Less so in that the machine responds to a ps2 keyboard and the magic-sysrq keys _slowly and
still reboots "randomly".

lspci straight after boot :

00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Root Complex
00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Renoir IOMMU
00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Host Bridge
00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Host Bridge
00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP Bridge
00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP Bridge
00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Host Bridge
00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal PCIe GPP Bridge to Bus
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev 51)
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev 51)
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 166a
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 166b
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 166c
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 166d
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 166e
00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 166f
00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1670
00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1671
01:00.0 USB controller: Advanced Micro Devices, Inc. [AMD] Device 43ee
01:00.1 SATA controller: Advanced Micro Devices, Inc. [AMD] Device 43eb
01:00.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 43e9
02:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 43ea
02:04.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 43ea
02:08.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 43ea
02:09.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 43ea
03:00.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06)
04:00.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06)
04:01.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06)
04:02.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06)
04:04.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06)
05:00.0 System peripheral: Intel Corporation JHL7540 Thunderbolt 3 NHI [Titan Ridge 4C 2018] (rev 06)
28:00.0 USB controller: Intel Corporation JHL7540 Thunderbolt 3 USB Controller [Titan Ridge 4C 2018] (rev 06)
29:00.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010]
2a:00.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010]
2a:01.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010]
2a:02.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010]
2a:04.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010]
2a:05.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010]
2b:00.0 PCI bridge: Pericom Semiconductor Device 400c (rev 02)
2c:03.0 PCI bridge: Pericom Semiconductor Device 400c (rev 02)
2d:00.0 USB controller: Pericom Semiconductor PI7C9X442SL USB OHCI Controller (rev 01)
2d:00.1 USB controller: Pericom Semiconductor PI7C9X442SL USB OHCI Controller (rev 01)
2d:00.2 USB controller: Pericom Semiconductor PI7C9X442SL USB EHCI Controller (rev 01)
2e:00.0 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme BCM57761 Gigabit Ethernet PCIe (rev 10)
2f:00.0 FireWire (IEEE 1394): LSI Corporation FW643 [TrueFire] PCIe 1394b Controller (rev 08)
30:00.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010]
31:00.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010]
31:01.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010]
31:02.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010]
31:04.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010]
31:05.0 PCI bridge: Intel Corporation CV82524 Thunderbolt Controller [Light Ridge 4C 2010]
32:00.0 PCI bridge: Pericom Semiconductor Device 400c (rev 02)
33:03.0 PCI bridge: Pericom Semiconductor Device 400c (rev 02)
34:00.0 USB controller: Pericom Semiconductor PI7C9X442SL USB OHCI Controller (rev 01)
34:00.1 USB controller: Pericom Semiconductor PI7C9X442SL USB OHCI Controller (rev 01)
34:00.2 USB controller: Pericom Semiconductor PI7C9X442SL USB EHCI Controller (rev 03)
35:00.0 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme BCM57761 Gigabit Ethernet PCIe (rev 10)
36:00.0 FireWire (IEEE 1394): LSI Corporation FW643 [TrueFire] PCIe 1394b Controller (rev 08)
4b:00.0 Non-Volatile memory controller: Kingston Technology Company, Inc. Device 2262 (rev 03)
4c:00.0 PCI bridge: ASMedia Technology Inc. Device 1806 (rev 01)
4d:00.0 PCI bridge: ASMedia Technology Inc. Device 1806 (rev 01)
4d:06.0 PCI bridge: ASMedia Technology Inc. Device 1806 (rev 01)
4d:0e.0 PCI bridge: ASMedia Technology Inc. Device 1806 (rev 01)
4e:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller (rev 05)
51:00.0 Ethernet controller: Intel Corporation Ethernet Controller I225-V (rev 01)
52:00.0 Non-Volatile memory controller: Micron/Crucial Technology Device 540a (rev 01)
53:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Cezanne (rev c9)
53:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Device 1637
53:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 10h-1fh) Platform Security Processor
53:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir USB 3.1
53:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir USB 3.1
53:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 10h-1fh) HD Audio Controller

Logging an strace lspci -v before loading the thunderbolt module it runs straight through in under a clock second.

Abridged : 

19:28:44 access("/etc/selinux/config", F_OK) = -1 ENOENT (No such file or directory)
19:28:44 access("/sys/bus/pci", R_OK)   = 0
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices", O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DIRECTORY) = 3
19:28:44 fstat(3, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
19:28:44 getdents64(3, 0x55bf61f66b00 /* 74 entries */, 32768) = 2352
19:28:44 getdents64(3, 0x55bf61f66b00 /* 0 entries */, 32768) = 0
19:28:44 close(3)                       = 0
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:32:00.0/config", O_RDONLY) = 3
19:28:44 pread64(3, "\330\22\f@\7\0\20\0\2\0\4\6\20\0\1\0\0\0\0\0\0\0\0\000234\0\361\1\0\0\20\337\20\337\361\377\1\0\0\0\0\0\0\0\0\0\0\0\0\0\200\0\0\0\0\0\0\0\377\0\22\0", 64, 0) = 64
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:32:00.0/vendor", O_RDONLY) = 4
19:28:44 read(4, "0x12d8\n", 1024)      = 7
19:28:44 close(4)                       = 0
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:32:00.0/device", O_RDONLY) = 4
19:28:44 read(4, "0x400c\n", 1024)      = 7
19:28:44 close(4)                       = 0
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:32:00.0/class", O_RDONLY) = 4
19:28:44 read(4, "0x060400\n", 1024)    = 9
19:28:44 close(4)                       = 0
19:28:44 close(3)                       = 0
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:4d:00.0/config", O_RDONLY) = 3
19:28:44 pread64(3, "!\33\6\30\7\4\20\0\1\0\4\6\20\0\1\0\0\0\0\0\0\0\0\0MNN\0\361\361\0\0P\357P\357\361\377\1\0\0\0\0\0\0\0\0\0\0\0\0\0@\0\0\0\0\0\0\0\377\1\22\0", 64, 0) = 64
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:4d:00.0/vendor", O_RDONLY) = 4
19:28:44 read(4, "0x1b21\n", 1024)      = 7
19:28:44 close(4)                       = 0
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:4d:00.0/device", O_RDONLY) = 4
19:28:44 read(4, "0x1806\n", 1024)      = 7
19:28:44 close(4)                       = 0
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:4d:00.0/class", O_RDONLY) = 4
19:28:44 read(4, "0x060400\n", 1024)    = 9
19:28:44 close(4)                       = 0
19:28:44 close(3)                       = 0
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:00:18.5/config", O_RDONLY) = 3
19:28:44 pread64(3, "\"\20o\26\0\0\0\0\0\0\0\6\0\0\200\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0", 64, 0) = 64
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:00:18.5/vendor", O_RDONLY) = 4
19:28:44 read(4, "0x1022\n", 1024)      = 7
19:28:44 close(4)                       = 0
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:00:18.5/device", O_RDONLY) = 4
19:28:44 read(4, "0x166f\n", 1024)      = 7
19:28:44 close(4)                       = 0
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:00:18.5/class", O_RDONLY) = 4
19:28:44 read(4, "0x060000\n", 1024)    = 9
19:28:44 close(4)                       = 0
19:28:44 close(3)                       = 0
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:02:04.0/config", O_RDONLY) = 3
19:28:44 pread64(3, "\"\20\352C\7\4\20\0\0\0\4\6\20\0\1\0\0\0\0\0\0\0\0\0\2KK\0\361\1\0\0`\357`\357\361\377\1\0\0\0\0\0\0\0\0\0\0\0\0\0P\0\0\0\0\0\0\0\377\1\22\0", 64, 0) = 64
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:02:04.0/vendor", O_RDONLY) = 4
19:28:44 read(4, "0x1022\n", 1024)      = 7
19:28:44 close(4)                       = 0
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:02:04.0/device", O_RDONLY) = 4
19:28:44 read(4, "0x43ea\n", 1024)      = 7
19:28:44 close(4)                       = 0
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:02:04.0/class", O_RDONLY) = 4
19:28:44 read(4, "0x060400\n", 1024)    = 9
19:28:44 close(4)                       = 0
19:28:44 close(3)                       = 0
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:31:04.0/config", O_RDONLY) = 3
19:28:44 pread64(3, "\206\200\23\25\7\0\20\0\0\0\4\6\20\0\1\0\0\0\0\0\0\0\0\000177\0\361\1\0\0\360\377\0\0\361\377\1\0\0\0\0\0\0\0\0\0\0\0\0\0\200\0\0\0\0\0\0\0\377\1\2\0", 64, 0) = 64
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:31:04.0/vendor", O_RDONLY) = 4
19:28:44 read(4, "0x8086\n", 1024)      = 7
19:28:44 close(4)                       = 0
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:31:04.0/device", O_RDONLY) = 4
19:28:44 read(4, "0x1513\n", 1024)      = 7
19:28:44 close(4)                       = 0
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:31:04.0/class", O_RDONLY) = 4
19:28:44 read(4, "0x060400\n", 1024)    = 9
19:28:44 close(4)                       = 0
19:28:44 close(3)                       = 0
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:33:03.0/config", O_RDONLY) = 3
19:28:44 pread64(3, "\330\22\f@\7\0\20\0\2\0\4\6\20\0\1\0\0\0\0\0\0\0\0\000344\0\361\1\0\0\20\337\20\337\361\377\1\0\0\0\0\0\0\0\0\0\0\0\0\0\200\0\0\0\0\0\0\0\377\0\22\0", 64, 0) = 64
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:33:03.0/vendor", O_RDONLY) = 4
19:28:44 read(4, "0x12d8\n", 1024)      = 7
19:28:44 close(4)                       = 0
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:33:03.0/device", O_RDONLY) = 4
19:28:44 read(4, "0x400c\n", 1024)      = 7
19:28:44 close(4)                       = 0
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:33:03.0/class", O_RDONLY) = 4
19:28:44 read(4, "0x060400\n", 1024)    = 9
19:28:44 close(4)                       = 0
19:28:44 close(3)                       = 0
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:00:14.0/config", O_RDONLY) = 3
19:28:44 pread64(3, "\"\20\vy\3\4 \2Q\0\5\f\0\0\200\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0X\24\1P\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0", 64, 0) = 64
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:00:14.0/vendor", O_RDONLY) = 4
19:28:44 read(4, "0x1022\n", 1024)      = 7
19:28:44 close(4)                       = 0
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:00:14.0/device", O_RDONLY) = 4
19:28:44 read(4, "0x790b\n", 1024)      = 7
19:28:44 close(4)                       = 0
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:00:14.0/class", O_RDONLY) = 4
19:28:44 read(4, "0x0c0500\n", 1024)    = 9
19:28:44 close(4)                       = 0
19:28:44 close(3)                       = 0
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:2a:00.0/config", O_RDONLY) = 3
19:28:44 pread64(3, "\206\200\23\25\7\4\20\0\0\0\4\6\20\0\1\0\0\0\0\0\0\0\0\0*+-\0\361\1\0\0000\3370\337\361\377\1\0\0\0\0\0\0\0\0\0\0\0\0\0\200\0\0\0\0\0\0\0\377\1\2\0", 64, 0) = 64
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:2a:00.0/vendor", O_RDONLY) = 4
19:28:44 read(4, "0x8086\n", 1024)      = 7
19:28:44 close(4)                       = 0
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:2a:00.0/device", O_RDONLY) = 4
19:28:44 read(4, "0x1513\n", 1024)      = 7
19:28:44 close(4)                       = 0
19:28:44 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:2a:00.0/class", O_RDONLY) = 4
19:28:44 read(4, "0x060400\n", 1024)    = 9
19:28:44 close(4)                       = 0
19:28:44 close(3)                       = 0


Immediately after loading the thunderbolt module we get this abridged strace :

It all progresses rapidly until we hit the thunderbolt controller. This progressed through to completion albeit slowly.

19:29:02 execve("/usr/bin/lspci", ["lspci", "-v"], 0x7ffdd1692958 /* 18 vars */) = 0
........ 
19:29:02 access("/etc/selinux/config", F_OK) = -1 ENOENT (No such file or directory)
19:29:02 access("/sys/bus/pci", R_OK)   = 0
19:29:02 openat(AT_FDCWD, "/sys/bus/pci/devices", O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DIRECTORY) = 3
19:29:02 fstat(3, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
19:29:02 getdents64(3, 0x55b4081e5b00 /* 74 entries */, 32768) = 2352
19:29:02 getdents64(3, 0x55b4081e5b00 /* 0 entries */, 32768) = 0
19:29:02 close(3)                       = 0
19:29:02 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:32:00.0/config", O_RDONLY) = 3
19:29:02 pread64(3, "\330\22\f@\7\0\20\0\2\0\4\6\20\0\1\0\0\0\0\0\0\0\0\000234\0\361\1\0\0\20\337\20\337\361\377\1\0\0\0\0\0\0\0\0\0\0\0\0\0\200\0\0\0\0\0\0\0\377\0\22\0", 64, 0) = 64
19:29:02 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:32:00.0/vendor", O_RDONLY) = 4
19:29:02 read(4, "0x12d8\n", 1024)      = 7
19:29:02 close(4)                       = 0
19:29:02 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:32:00.0/device", O_RDONLY) = 4
19:29:02 read(4, "0x400c\n", 1024)      = 7
19:29:02 close(4)                       = 0
19:29:02 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:32:00.0/class", O_RDONLY) = 4
19:29:02 read(4, "0x060400\n", 1024)    = 9
19:29:02 close(4)                       = 0
19:29:02 close(3)                       = 0
19:29:02 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:4d:00.0/config", O_RDONLY) = 3
19:29:02 pread64(3, "!\33\6\30\7\4\20\0\1\0\4\6\20\0\1\0\0\0\0\0\0\0\0\0MNN\0\361\361\0\0P\357P\357\361\377\1\0\0\0\0\0\0\0\0\0\0\0\0\0@\0\0\0\0\0\0\0\377\1\22\0", 64, 0) = 64
19:29:02 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:4d:00.0/vendor", O_RDONLY) = 4
19:29:02 read(4, "0x1b21\n", 1024)      = 7
19:29:02 close(4)                       = 0
19:29:02 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:4d:00.0/device", O_RDONLY) = 4
19:29:02 read(4, "0x1806\n", 1024)      = 7
19:29:02 close(4)                       = 0
19:29:02 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:4d:00.0/class", O_RDONLY) = 4
19:29:02 read(4, "0x060400\n", 1024)    = 9
19:29:02 close(4)                       = 0
19:29:02 close(3)                       = 0
19:29:02 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:00:18.5/config", O_RDONLY) = 3
19:29:02 pread64(3, "\"\20o\26\0\0\0\0\0\0\0\6\0\0\200\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0", 64, 0) = 64
19:29:02 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:00:18.5/vendor", O_RDONLY) = 4
19:29:02 read(4, "0x1022\n", 1024)      = 7
19:29:02 close(4)                       = 0
19:29:02 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:00:18.5/device", O_RDONLY) = 4
19:29:02 read(4, "0x166f\n", 1024)      = 7
19:29:02 close(4)                       = 0
19:29:02 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:00:18.5/class", O_RDONLY) = 4
19:29:02 read(4, "0x060000\n", 1024)    = 9
19:29:02 close(4)                       = 0
19:29:02 close(3)                       = 0
19:29:02 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:02:04.0/config", O_RDONLY) = 3
19:29:02 pread64(3, "\"\20\352C\7\4\20\0\0\0\4\6\20\0\1\0\0\0\0\0\0\0\0\0\2KK\0\361\1\0\0`\357`\357\361\377\1\0\0\0\0\0\0\0\0\0\0\0\0\0P\0\0\0\0\0\0\0\377\1\22\0", 64, 0) = 64
19:29:02 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:02:04.0/vendor", O_RDONLY) = 4
19:29:02 read(4, "0x1022\n", 1024)      = 7
19:29:02 close(4)                       = 0
19:29:02 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:02:04.0/device", O_RDONLY) = 4
19:29:02 read(4, "0x43ea\n", 1024)      = 7
19:29:02 close(4)                       = 0
19:29:02 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:02:04.0/class", O_RDONLY) = 4
19:29:02 read(4, "0x060400\n", 1024)    = 9
19:29:02 close(4)                       = 0
19:29:02 close(3)                       = 0
19:29:02 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:31:04.0/config", O_RDONLY) = 3
19:29:02 pread64(3, "\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377", 64, 0) = 64
19:29:05 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:31:04.0/vendor", O_RDONLY) = 4
19:29:05 read(4, "0x8086\n", 1024)      = 7
19:29:05 close(4)                       = 0
19:29:05 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:31:04.0/device", O_RDONLY) = 4
19:29:05 read(4, "0x1513\n", 1024)      = 7
19:29:05 close(4)                       = 0
19:29:05 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:31:04.0/class", O_RDONLY) = 4
19:29:05 read(4, "0x060400\n", 1024)    = 9
19:29:05 close(4)                       = 0
19:29:05 close(3)                       = 0
19:29:05 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:33:03.0/config", O_RDONLY) = 3
19:29:05 pread64(3, "\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377", 64, 0) = 64
19:29:08 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:33:03.0/vendor", O_RDONLY) = 4
19:29:08 read(4, "0x12d8\n", 1024)      = 7
19:29:08 close(4)                       = 0
19:29:08 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:33:03.0/device", O_RDONLY) = 4
19:29:08 read(4, "0x400c\n", 1024)      = 7
19:29:08 close(4)                       = 0
19:29:08 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:33:03.0/class", O_RDONLY) = 4
19:29:08 read(4, "0x060400\n", 1024)    = 9
19:29:08 close(4)                       = 0
19:29:08 close(3)                       = 0
19:29:08 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:00:14.0/config", O_RDONLY) = 3
19:29:08 pread64(3, "\"\20\vy\3\4 \2Q\0\5\f\0\0\200\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0X\24\1P\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0", 64, 0) = 64
19:29:08 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:00:14.0/vendor", O_RDONLY) = 4
19:29:08 read(4, "0x1022\n", 1024)      = 7
19:29:08 close(4)                       = 0
19:29:08 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:00:14.0/device", O_RDONLY) = 4
19:29:08 read(4, "0x790b\n", 1024)      = 7
19:29:08 close(4)                       = 0
19:29:08 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:00:14.0/class", O_RDONLY) = 4
19:29:08 read(4, "0x0c0500\n", 1024)    = 9
19:29:08 close(4)                       = 0
19:29:08 close(3)                       = 0
19:29:08 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:2a:00.0/config", O_RDONLY) = 3
19:29:08 pread64(3, "\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377", 64, 0) = 64
19:29:12 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:2a:00.0/vendor", O_RDONLY) = 4
19:29:12 read(4, "0x8086\n", 1024)      = 7
19:29:12 close(4)                       = 0
19:29:12 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:2a:00.0/device", O_RDONLY) = 4
19:29:12 read(4, "0x1513\n", 1024)      = 7
19:29:12 close(4)                       = 0
19:29:12 openat(AT_FDCWD, "/sys/bus/pci/devices/0000:2a:00.0/class", O_RDONLY) = 4
19:29:12 read(4, "0x060400\n", 1024)    = 9
19:29:12 close(4)                       = 0
19:29:12 close(3)                       = 0
.....
19:30:49 +++ exited with 0 +++

An attempt to run it again resulted in a reboot.

Something goes off the rails with PCI access. The bizzare thing is I can hit the reset button, the machine boots
with all PCIe tunnels still established and I repeat the process (unload drivers, lspci, modprobe thunderbolt,
lspci locks up).

Regards,
Brad
