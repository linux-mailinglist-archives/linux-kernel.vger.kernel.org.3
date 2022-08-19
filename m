Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AA5599FB4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 18:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352364AbiHSQWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 12:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352553AbiHSQRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 12:17:04 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E233A1159AF;
        Fri, 19 Aug 2022 08:59:58 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aea64.dynamic.kabel-deutschland.de [95.90.234.100])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id A772A61EA192A;
        Fri, 19 Aug 2022 17:59:55 +0200 (CEST)
Message-ID: <ab679efe-df85-d2d2-2a4e-842ff9b59b6d@molgen.mpg.de>
Date:   Fri, 19 Aug 2022 17:59:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: Dell XPS 13 9370: ucsi_acpi USBC000:00: UCSI_GET_PDOS returned 0
 bytes
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <726661bf-b95f-02fc-e7c5-c222820ee257@molgen.mpg.de>
 <Yv+sqa8wdqiuSUZ3@kroah.com>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <Yv+sqa8wdqiuSUZ3@kroah.com>
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

Dear Greg,


Am 19.08.22 um 17:30 schrieb Greg KH:
> On Fri, Aug 19, 2022 at 03:37:00PM +0200, Paul Menzel wrote:

>> On the Dell XPS 13 9370 with Debian sid/unstable, connecting a Dell DA300
>> port replicator Linux 5.18.16 logs a warning:
>>
>> ```
>> $ dmesg
>> [    0.000000] Linux version 5.18.0-4-amd64 (debian-kernel@lists.debian.org)
>> (gcc-11 (Debian 11.3.0-5) 11.3.0, GNU ld (GNU Binutils for Debian)
>> 2.38.90.20220713) #1 SMP PREEMPT_DYNAMIC Debian 5.18.16-1 (2022-08-10)
>> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.18.0-4-amd64
>> root=UUID=56f398e0-1e25-4fda-aa9f-611dece4b333 ro quiet
>> […]
>> [    0.000000] DMI: Dell Inc. XPS 13 9370/0RMYH9, BIOS 1.21.0 07/06/2022
>> […]
>> [   13.900028] ucsi_acpi USBC000:00: UCSI_GET_PDOS returned 0 bytes
>> ```
> 
> What warning?

`ucsi_acpi USBC000:00: UCSI_GET_PDOS returned 0 bytes` has log level 
warning.

>> ```
>> $ lsusb
>> Bus 002 Device 003: ID 0bda:8153 Realtek Semiconductor Corp. RTL8153 Gigabit
>> Ethernet Adapter
>> Bus 002 Device 002: ID 2109:0820 VIA Labs, Inc. VL820 Hub
>> Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
>> Bus 001 Device 004: ID 8087:0a2b Intel Corp. Bluetooth wireless interface
>> Bus 001 Device 003: ID 0bda:58f4 Realtek Semiconductor Corp.
>> Integrated_Webcam_HD
>> Bus 001 Device 006: ID 27c6:5385 Shenzhen Goodix Technology Co.,Ltd.
>> Fingerprint Reader
>> Bus 001 Device 005: ID 06c4:c412 Bizlink International Corp. DELL DA300
>> Bus 001 Device 002: ID 2109:2820 VIA Labs, Inc. VL820 Hub
>> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>> ```
>>
>> How can that warning be addressed?
> 
> What warning?

See above.

> You have a SGX error in your kernel boot log:
> 
>> [    0.235418] sgx: EPC section 0x40200000-0x45f7ffff
>> [    0.235853] ------------[ cut here ]------------
>> [    0.235855] WARNING: CPU: 1 PID: 83 at arch/x86/kernel/cpu/sgx/main.c:446 ksgxd+0x1b7/0x1d0
>> [    0.235861] Modules linked in:
>> [    0.235862] CPU: 1 PID: 83 Comm: ksgxd Not tainted 5.18.0-4-amd64 #1  Debian 5.18.16-1
>> [    0.235865] Hardware name: Dell Inc. XPS 13 9370/0RMYH9, BIOS 1.21.0 07/06/2022
>> [    0.235866] RIP: 0010:ksgxd+0x1b7/0x1d0
>> [    0.235869] Code: ff e9 f2 fe ff ff 48 89 df e8 55 56 0d 00 84 c0 0f 84 c3 fe ff ff 31 ff e8 c6 56 0d 00 84 c0 0f 85 94 fe ff ff e9 af fe ff ff <0f> 0b e9 7f fe ff ff e8 3d dd 93 00 66 66 2e 0f 1f 84 00 00 00 00
>> [    0.235870] RSP: 0000:ffffaaed0097bed8 EFLAGS: 00010287
>> [    0.235872] RAX: ffffaaed00431890 RBX: ffff9a323ccc8000 RCX: 0000000000000000
>> [    0.235873] RDX: 0000000080000000 RSI: ffffaaed00431850 RDI: 00000000ffffffff
>> [    0.235875] RBP: ffff9a31416ca080 R08: ffff9a31416cae40 R09: ffff9a31416cae40
>> [    0.235876] R10: 0000000000000000 R11: 0000000000000001 R12: ffffaaed0006bce0
>> [    0.235877] R13: ffff9a3140e9c480 R14: ffffffff9825ee60 R15: 0000000000000000
>> [    0.235878] FS:  0000000000000000(0000) GS:ffff9a32e6640000(0000) knlGS:0000000000000000
>> [    0.235880] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [    0.235881] CR2: 0000000000000000 CR3: 00000001fbe10001 CR4: 00000000003706e0
>> [    0.235882] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [    0.235883] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [    0.235884] Call Trace:
>> [    0.235893]  <TASK>
>> [    0.235895]  ? _raw_spin_lock_irqsave+0x24/0x60
>> [    0.235900]  ? _raw_spin_unlock_irqrestore+0x23/0x40
>> [    0.235902]  ? __kthread_parkme+0x36/0x90
>> [    0.235905]  kthread+0xe5/0x110
>> [    0.235907]  ? kthread_complete_and_exit+0x20/0x20
>> [    0.235909]  ret_from_fork+0x1f/0x30
>> [    0.235914]  </TASK>
>> [    0.235915] ---[ end trace 0000000000000000 ]---
> 
> Talk to the SGX developers about that mess :)

Yes, I know, and did already [1], but I am pretty sure it’s unrelated.


Kind regards,

Paul


[1]: 
https://lore.kernel.org/lkml/ce0b4d26-3a6e-7c5a-5f66-44cba05f9f35@molgen.mpg.de/
