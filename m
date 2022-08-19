Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DF9599E3F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 17:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349529AbiHSPa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 11:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349623AbiHSPay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 11:30:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE1D101C65;
        Fri, 19 Aug 2022 08:30:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E56DB615D5;
        Fri, 19 Aug 2022 15:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCD1C433D6;
        Fri, 19 Aug 2022 15:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660923052;
        bh=tM34vq7OcS5+LQiiZR7o24oQ/vivQhqm/1WREtVVHQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FV9KBd/ztnCeZ1MaPuuNSkJFWRUUr+6eW6Ysr2ZwXNUw/GIUsFTMC+iufgVZ+wD38
         EeqDTUPTYvG7+mlBfMSUNTIdDeEaZvrPBUTU1WkzHFmnmBIgsh7RSq3EKYVgACXP6G
         Hv1Ss8+xwOscL7cTwXho6/P0a67tggzTIZBfkXT4=
Date:   Fri, 19 Aug 2022 17:30:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Dell XPS 13 9370: ucsi_acpi USBC000:00: UCSI_GET_PDOS returned 0
 bytes
Message-ID: <Yv+sqa8wdqiuSUZ3@kroah.com>
References: <726661bf-b95f-02fc-e7c5-c222820ee257@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <726661bf-b95f-02fc-e7c5-c222820ee257@molgen.mpg.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 03:37:00PM +0200, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On the Dell XPS 13 9370 with Debian sid/unstable, connecting a Dell DA300
> port replicator Linux 5.18.16 logs a warning:
> 
> ```
> $ dmesg
> [    0.000000] Linux version 5.18.0-4-amd64 (debian-kernel@lists.debian.org)
> (gcc-11 (Debian 11.3.0-5) 11.3.0, GNU ld (GNU Binutils for Debian)
> 2.38.90.20220713) #1 SMP PREEMPT_DYNAMIC Debian 5.18.16-1 (2022-08-10)
> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.18.0-4-amd64
> root=UUID=56f398e0-1e25-4fda-aa9f-611dece4b333 ro quiet
> […]
> [    0.000000] DMI: Dell Inc. XPS 13 9370/0RMYH9, BIOS 1.21.0 07/06/2022
> […]
> [   13.900028] ucsi_acpi USBC000:00: UCSI_GET_PDOS returned 0 bytes
> ```

What warning?

> 
> ```
> $ lsusb
> Bus 002 Device 003: ID 0bda:8153 Realtek Semiconductor Corp. RTL8153 Gigabit
> Ethernet Adapter
> Bus 002 Device 002: ID 2109:0820 VIA Labs, Inc. VL820 Hub
> Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 001 Device 004: ID 8087:0a2b Intel Corp. Bluetooth wireless interface
> Bus 001 Device 003: ID 0bda:58f4 Realtek Semiconductor Corp.
> Integrated_Webcam_HD
> Bus 001 Device 006: ID 27c6:5385 Shenzhen Goodix Technology Co.,Ltd.
> Fingerprint Reader
> Bus 001 Device 005: ID 06c4:c412 Bizlink International Corp. DELL DA300
> Bus 001 Device 002: ID 2109:2820 VIA Labs, Inc. VL820 Hub
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> ```
> 
> How can that warning be addressed?

What warning?

You have a SGX error in your kernel boot log:

> [    0.235418] sgx: EPC section 0x40200000-0x45f7ffff
> [    0.235853] ------------[ cut here ]------------
> [    0.235855] WARNING: CPU: 1 PID: 83 at arch/x86/kernel/cpu/sgx/main.c:446 ksgxd+0x1b7/0x1d0
> [    0.235861] Modules linked in:
> [    0.235862] CPU: 1 PID: 83 Comm: ksgxd Not tainted 5.18.0-4-amd64 #1  Debian 5.18.16-1
> [    0.235865] Hardware name: Dell Inc. XPS 13 9370/0RMYH9, BIOS 1.21.0 07/06/2022
> [    0.235866] RIP: 0010:ksgxd+0x1b7/0x1d0
> [    0.235869] Code: ff e9 f2 fe ff ff 48 89 df e8 55 56 0d 00 84 c0 0f 84 c3 fe ff ff 31 ff e8 c6 56 0d 00 84 c0 0f 85 94 fe ff ff e9 af fe ff ff <0f> 0b e9 7f fe ff ff e8 3d dd 93 00 66 66 2e 0f 1f 84 00 00 00 00
> [    0.235870] RSP: 0000:ffffaaed0097bed8 EFLAGS: 00010287
> [    0.235872] RAX: ffffaaed00431890 RBX: ffff9a323ccc8000 RCX: 0000000000000000
> [    0.235873] RDX: 0000000080000000 RSI: ffffaaed00431850 RDI: 00000000ffffffff
> [    0.235875] RBP: ffff9a31416ca080 R08: ffff9a31416cae40 R09: ffff9a31416cae40
> [    0.235876] R10: 0000000000000000 R11: 0000000000000001 R12: ffffaaed0006bce0
> [    0.235877] R13: ffff9a3140e9c480 R14: ffffffff9825ee60 R15: 0000000000000000
> [    0.235878] FS:  0000000000000000(0000) GS:ffff9a32e6640000(0000) knlGS:0000000000000000
> [    0.235880] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.235881] CR2: 0000000000000000 CR3: 00000001fbe10001 CR4: 00000000003706e0
> [    0.235882] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    0.235883] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    0.235884] Call Trace:
> [    0.235893]  <TASK>
> [    0.235895]  ? _raw_spin_lock_irqsave+0x24/0x60
> [    0.235900]  ? _raw_spin_unlock_irqrestore+0x23/0x40
> [    0.235902]  ? __kthread_parkme+0x36/0x90
> [    0.235905]  kthread+0xe5/0x110
> [    0.235907]  ? kthread_complete_and_exit+0x20/0x20
> [    0.235909]  ret_from_fork+0x1f/0x30
> [    0.235914]  </TASK>
> [    0.235915] ---[ end trace 0000000000000000 ]---

Talk to the SGX developers about that mess :)

thanks,

greg k-h
