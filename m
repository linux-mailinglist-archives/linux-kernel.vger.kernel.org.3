Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BF259A0AF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 18:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352990AbiHSQZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 12:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352482AbiHSQVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 12:21:06 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8D72AE3;
        Fri, 19 Aug 2022 09:02:25 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aea64.dynamic.kabel-deutschland.de [95.90.234.100])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4316161EA192A;
        Fri, 19 Aug 2022 18:02:24 +0200 (CEST)
Message-ID: <4253695b-85aa-a2fb-fbf6-718db8b6c20c@molgen.mpg.de>
Date:   Fri, 19 Aug 2022 18:02:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: WARNING: CPU: 1 PID: 83 at arch/x86/kernel/cpu/sgx/main.c:446
 ksgxd+0x1b7/0x1d0
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     linux-sgx@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <ce0b4d26-3a6e-7c5a-5f66-44cba05f9f35@molgen.mpg.de>
In-Reply-To: <ce0b4d26-3a6e-7c5a-5f66-44cba05f9f35@molgen.mpg.de>
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

[Cc: +linux-sgx@vger.kernel.org]

Am 19.08.22 um 15:19 schrieb Paul Menzel:
> Dear Linux folks,
> 
> 
> On the Dell XPS 13 9370, Linux 5.18.16 prints the warning below:
> 
> ```
> [    0.000000] Linux version 5.18.0-4-amd64 (debian-kernel@lists.debian.org) (gcc-11 (Debian 11.3.0-5) 11.3.0, GNU ld (GNU Binutils for Debian) 2.38.90.20220713) #1 SMP PREEMPT_DYNAMIC Debian 5.18.16-1 (2022-08-10)
> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.18.0-4-amd64 root=UUID=56f398e0-1e25-4fda-aa9f-611dece4b333 ro quiet
> […]
> [    0.000000] DMI: Dell Inc. XPS 13 9370/0RMYH9, BIOS 1.21.0 07/06/2022
> […]
> [    0.235418] sgx: EPC section 0x40200000-0x45f7ffff
> [    0.235853] ------------[ cut here ]------------
> [    0.235855] WARNING: CPU: 1 PID: 83 at arch/x86/kernel/cpu/sgx/main.c:446 ksgxd+0x1b7/0x1d0
> [    0.235861] Modules linked in:
> [    0.235862] CPU: 1 PID: 83 Comm: ksgxd Not tainted 5.18.0-4-amd64 #1 Debian 5.18.16-1
> [    0.235865] Hardware name: Dell Inc. XPS 13 9370/0RMYH9, BIOS 1.21.0 07/06/2022
> [    0.235866] RIP: 0010:ksgxd+0x1b7/0x1d0
> [    0.235869] Code: ff e9 f2 fe ff ff 48 89 df e8 55 56 0d 00 84 c0 0f 84 c3 fe ff ff 31 ff e8 c6 56 0d 00 84 c0 0f 85 94 fe ff ff e9 af fe ff ff <0f> 0b e9 7f fe ff ff e8 3d dd 93 00 66 66 2e 0f 1f 84 00 00 00 00
> [    0.235870] RSP: 0000:ffffaaed0097bed8 EFLAGS: 00010287
> [    0.235872] RAX: ffffaaed00431890 RBX: ffff9a323ccc8000 RCX: 0000000000000000
> [    0.235873] RDX: 0000000080000000 RSI: ffffaaed00431850 RDI: 00000000ffffffff
> [    0.235875] RBP: ffff9a31416ca080 R08: ffff9a31416cae40 R09: ffff9a31416cae40
> [    0.235876] R10: 0000000000000000 R11: 0000000000000001 R12: ffffaaed0006bce0
> [    0.235877] R13: ffff9a3140e9c480 R14: ffffffff9825ee60 R15: 0000000000000000
> [    0.235878] FS:  0000000000000000(0000) GS:ffff9a32e6640000(0000) knlGS:0000000000000000
> [    0.235880] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.235881] CR2: 0000000000000000 CR3: 00000001fbe10001 CR4: 00000000003706e0
> [    0.235882] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    0.235883] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    0.235884] Call Trace:
> [    0.235893]  <TASK>
> [    0.235895]  ? _raw_spin_lock_irqsave+0x24/0x60
> [    0.235900]  ? _raw_spin_unlock_irqrestore+0x23/0x40
> [    0.235902]  ? __kthread_parkme+0x36/0x90
> [    0.235905]  kthread+0xe5/0x110
> [    0.235907]  ? kthread_complete_and_exit+0x20/0x20
> [    0.235909]  ret_from_fork+0x1f/0x30
> [    0.235914]  </TASK>
> [    0.235915] ---[ end trace 0000000000000000 ]---
> ```
> 
> 
> Kind regards,
> 
> Paul
