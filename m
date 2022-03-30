Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EA24ECEE3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 23:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351277AbiC3Vgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 17:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiC3Vgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 17:36:33 -0400
X-Greylist: delayed 407 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Mar 2022 14:34:45 PDT
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985F720F79
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 14:34:45 -0700 (PDT)
Received: from dispatch1-us1.ppe-hosted.com (localhost.localdomain [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 08B6122C771
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 21:27:59 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.64.219])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 6C0771C0081
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 21:27:57 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 3FC7C78008B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 21:27:57 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id B91DB13C2B0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 14:27:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com B91DB13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1648675676;
        bh=d86iQZjAMkl3I5xxyKZccQS/Dw6pHlshZk2WpxZaWrw=;
        h=To:From:Subject:Date:From;
        b=d5B444ntEO4GmiRsfAyh4CoZz3d636XX7VN5eHaQi8ILyum/l/BVbcWAvn00MkuW7
         /UzV1j6DFA0DvpDU5Paiv1twul+kRZM5ZaAWy0IkApQjmajHxZzMIospq4FZj+gZTx
         qSTDPb4ZJvrL8u832W/hNXzw64XhTj0kIbKvL0kA=
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: Kernel panic - not syncing: Attempted to kill init!
 exitcode=0x00007f00 since 5.17
Organization: Candela Technologies
Message-ID: <bbf2d268-a93d-afdc-a836-0fdb878be10e@candelatech.com>
Date:   Wed, 30 Mar 2022 14:27:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-MDID: 1648675677-sQsZwQOrI0r5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

After upgrading to 5.17 (plus our out-of-kernel patches),
one of my test machines has been crashing on startup around 20% of the time.
Here is one I just caught.  Looks like it cannot open a shared library
file.  I did not see this on 5.16 or earlier kernels.  Also have not seen
it on different machines, but also have not been doing any significant amounts
of reboots on other systems usign 5.17 to date.

hard power down, power up, and it boots fine.  So I think it is not initrd
packaging problem...


Loading Candela Technologies 5.17.0+ COM1 115200 8n1 ...
Loading initial ramdisk ...
�00:02: ttyS0 at I/O 0x240 (irq = 4, base_baud = 115200) is a 16550A
00:03: ttyS1 at I/O 0x248 (irq = 3, base_baud = 115200) is a 16550A
00:04: ttyS2 at I/O 0x250 (irq = 6, base_baud = 115200) is a 16550A
00:05: ttyS3 at I/O 0x258 (irq = 10, base_baud = 115200) is a 16550A
Non-volatile memory driver v1.3
brd: module loaded
loop: module loaded
mei_me 0000:00:16.0: enabling device (0000 -> 0002)
ahci 0000:00:17.0: AHCI 0001.0301 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
ahci 0000:00:17.0: flags: 64bit ncq sntf led clo only pio slum part ems deso sadm sds apst
scsi host0: ahci
scsi host1: ahci
ata1: SATA max UDMA/133 abar m2048@0xdf32b000 port 0xdf32b100 irq 144
ata2: SATA max UDMA/133 abar m2048@0xdf32b000 port 0xdf32b180 irq 144
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ehci-platform: EHCI generic platform driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-pci: OHCI PCI platform driver
ohci-platform: OHCI generic platform driver
uhci_hcd: USB Universal Host Controller Interface driver
usbcore: registered new interface driver usbserial_generic
usbserial: USB Serial support registered for generic
i8042: PNP: No PS/2 controller found.
i8042: Probing ports directly.
i8042: No controller found
mousedev: PS/2 mouse device common for all mice
rtc_cmos 00:08: RTC can wake from S4
rtc_cmos 00:08: registered as rtc0
rtc_cmos 00:08: setting system clock to 2022-03-30T21:00:57 UTC (1648674057)
rtc_cmos 00:08: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
device-mapper: uevent: version 1.0.3
device-mapper: ioctl: 4.45.0-ioctl (2021-03-22) initialised: dm-devel@redhat.com
platform eisa.0: Probing EISA bus 0
platform eisa.0: EISA: Cannot allocate resource for mainboard
intel_pstate: Intel P-state driver initializing
intel_pstate: Disabling energy efficiency optimization
intel_pstate: HWP enabled
ledtrig-cpu: registered to indicate activity on CPUs
hid: raw HID events driver (C) Jiri Kosina
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
resource sanity check: requesting [mem 0xfdffe800-0xfe0007ff], which spans more than pnp 00:0b [mem 0xfdb00000-0xfdffffff]
caller pmc_core_probe+0xa5/0x610 mapping multiple BARs
intel_pmc_core INT33A1:00:  initialized
Initializing XFRM netlink socket
NET: Registered PF_INET6 protocol family
Segment Routing with IPv6
RPL Segment Routing with IPv6
In-situ OAM (IOAM) with IPv6
NET: Registered PF_PACKET protocol family
Key type dns_resolver registered
microcode: sig=0x906e9, pf=0x2, revision=0xca
microcode: Microcode Update Driver: v2.2.
IPI shorthand broadcast: enabled
AVX2 version of gcm_enc/dec engaged.
AES CTR mode by8 optimization enabled
sched_clock: Marking stable (1516934985, 113449077)->(1680081859, -49697797)
registered taskstats version 1
Loading compiled-in X.509 certificates
zswap: loaded using pool lzo/zbud
Key type ._fscrypt registered
Key type .fscrypt registered
Key type fscrypt-provisioning registered
Key type big_key registered
Key type encrypted registered
PM:   Magic number: 14:426:46
event_source uprobe: hash matches
RAS: Correctable Errors collector initialized.
ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata1.00: ACPI cmd f5/00:00:00:00:00:00(SECURITY FREEZE LOCK) filtered out
ata1.00: ACPI cmd b1/c1:00:00:00:00:00(DEVICE CONFIGURATION OVERLAY) filtered out
ata2.00: ACPI cmd f5/00:00:00:00:00:00(SECURITY FREEZE LOCK) filtered out
ata2.00: ACPI cmd b1/c1:00:00:00:00:00(DEVICE CONFIGURATION OVERLAY) filtered out
ata1.00: ATA-10: INTEL SSDSC2KB240G8, XCV10120, max UDMA/133
ata1.00: 468862128 sectors, multi 1: LBA48 NCQ (depth 32)
ata2.00: ATA-10: INTEL SSDSC2KB240G8, XCV10120, max UDMA/133
ata2.00: 468862128 sectors, multi 1: LBA48 NCQ (depth 32)
ata1.00: ACPI cmd f5/00:00:00:00:00:00(SECURITY FREEZE LOCK) filtered out
ata1.00: ACPI cmd b1/c1:00:00:00:00:00(DEVICE CONFIGURATION OVERLAY) filtered out
ata2.00: ACPI cmd f5/00:00:00:00:00:00(SECURITY FREEZE LOCK) filtered out
ata2.00: ACPI cmd b1/c1:00:00:00:00:00(DEVICE CONFIGURATION OVERLAY) filtered out
ata1.00: configured for UDMA/133
ata2.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      INTEL SSDSC2KB24 0120 PQ: 0 ANSI: 5
sd 0:0:0:0: Attached scsi generic sg0 type 0
ata1.00: Enabling discard_zeroes_data
sd 0:0:0:0: [sda] 468862128 512-byte logical blocks: (240 GB/224 GiB)
scsi 1:0:0:0: Direct-Access     ATA      INTEL SSDSC2KB24 0120 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 4096-byte physical blocks
sd 0:0:0:0: [sda] Write Protect is off
ata2.00: Enabling discard_zeroes_data
sd 1:0:0:0: Attached scsi generic sg1 type 0
sd 1:0:0:0: [sdb] 468862128 512-byte logical blocks: (240 GB/224 GiB)
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] 4096-byte physical blocks
ata1.00: Enabling discard_zeroes_data
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata2.00: Enabling discard_zeroes_data
  sda: sda1 sda2 sda3
ata1.00: Enabling discard_zeroes_data
  sdb: sdb1 sdb2 sdb3
ata2.00: Enabling discard_zeroes_data
sd 0:0:0:0: [sda] Attached SCSI disk
sd 1:0:0:0: [sdb] Attached SCSI disk
Freeing unused kernel image (initmem) memory: 1784K
Write protecting the kernel read-only data: 24576k
Freeing unused kernel image (text/rodata gap) memory: 2040K
Freeing unused kernel image (rodata/data gap) memory: 712K
Run /init as init process
Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
/init: error whitsc: Refined TSC clocksource calibration: 2903.996 MHz
le loading shareCPU: 2 PID: 1 Comm: init Not tainted 5.17.0+ #12
d libraries: libclocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x29dc020bb13, max_idle_ns: 440795273180 ns
rt.so.1: cannot Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2020
open shared objeCall Trace:
ct file: No such <TASK>
  file or directo dump_stack_lvl+0x47/0x5c
ry
  panic+0xf5/0x2af
  do_exit.cold.47+0x15/0x15
  do_group_exit+0x28/0x90
  __x64_sys_exit_group+0xf/0x10
  do_syscall_64+0x34/0xb0
  entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f1178fa539e
Code: 89 fa 41 b8 e7 00 00 00 be 3c 00 00 00 eb 14 0f 1f 44 00 00 89 d7 89 f0 0f 05 48 3d 00 f0 ff ff 77 1a f4 89 d7 44 89 c0 05
RSP: 002b:00007ffca09d1fc8 EFLAGS: 00000202 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f1178f859f0 RCX: 00007f1178fa539e
RDX: 000000000000007f RSI: 000000000000003c RDI: 000000000000007f
RBP: 00007ffca09d2990 R08: 00000000000000e7 R09: 00007ffca09d1ed8
R10: 0000000000000000 R11: 0000000000000202 R12: 00007f1178fae4b0
R13: 0000000000000000 R14: 0000000000000003 R15: 00007f1178f85a20
  </TASK>
Kernel Offset: disabled
---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00 ]---

CTRL-A Z for help | 115200 8N1 | NOR | Minicom 2.7.1 | VT102 | Online 1:45 | ttyUSB0

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

