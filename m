Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C58A4DB814
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 19:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357753AbiCPSqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 14:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345697AbiCPSqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 14:46:44 -0400
Received: from audible.transient.net (audible.transient.net [24.143.126.66])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id E0638657B8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 11:45:26 -0700 (PDT)
Received: (qmail 3417 invoked from network); 16 Mar 2022 18:45:25 -0000
Received: from cucamonga.audible.transient.net (192.168.2.5)
  by canarsie.audible.transient.net with QMQP; 16 Mar 2022 18:45:25 -0000
Received: (nullmailer pid 2376 invoked by uid 1000);
        Wed, 16 Mar 2022 18:45:25 -0000
Date:   Wed, 16 Mar 2022 18:45:25 +0000
From:   Jamie Heilman <jamie@audible.transient.net>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: system locks up with CONFIG_SLS=Y; 5.17.0-rc
Message-ID: <YjIwRR5UsTd3W4Bj@audible.transient.net>
Mail-Followup-To: Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
References: <YjGzJwjrvxg5YZ0Z@audible.transient.net>
 <YjHYh3XRbHwrlLbR@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjHYh3XRbHwrlLbR@zn.tnic>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov wrote:
> On Wed, Mar 16, 2022 at 09:51:35AM +0000, Jamie Heilman wrote:
> > I've been (somewhat unsuccessfully) trying to bisect a hard lock-up
> > of my workstation that occurs when I'm running 5.17 rc kernels a few
> > seconds after I start a kvm guest instance.  There is no output to
> > any log, everything locks up completely, sysrq doesn't even work
> > anymore.
> 
> Any chance you can connect that box with a serial cable, get serial
> console working and see if you can catch dmesg with it this way?
> 
> https://www.kernel.org/doc/html/latest/admin-guide/serial-console.html

Yep that worked, here's output, you can see the network get set up and
then boom:

br0: port 2(motorhead) entered blocking state
br0: port 2(motorhead) entered disabled state
device motorhead entered promiscuous mode
br0: port 2(motorhead) entered blocking state
br0: port 2(motorhead) entered forwarding state
int3: 0000 [#1] PREEMPT SMP PTI
CPU: 0 PID: 2435 Comm: qemu-system-x86 Not tainted 5.17.0-rc8-sls #1
Hardware name: Dell Inc. Precision WorkStation T3400  /0TP412, BIOS A14 04/30/2012
RIP: 0010:setc+0x5/0x8 [kvm]
Code: 00 00 0f 1f 00 0f b6 05 43 24 06 00 c3 cc 0f 1f 80 00 00 00 00 0f 90 c0 c3 cc 0f 1f 00 0f 91 c0 c3 cc 0f 1f 00 0f 92 c0 c3 cc <0f> 1f 00 0f 93 c0 c3 cc 0f 1f 00 0f 94 c0 c3 cc 0f 1f 00 0f 95 c0
RSP: 0018:ffffc90000a1fc68 EFLAGS: 00000283
RAX: 0000000000000281 RBX: 0000000000000006 RCX: 0000000000000005
RDX: ffffffffa01a4024 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88810ef76900 R08: 0000000000000000 R09: 0000000000000000
R10: ffff88810ee54000 R11: 0000000000000000 R12: ffffffffa01d5720
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88810ef76900
FS:  00007f23ecd79640(0000) GS:ffff888233c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000108df8000 CR4: 00000000000426f0
Call Trace:
 <TASK>
 ? x86_emulate_insn+0x76b/0xe00 [kvm]
 ? x86_emulate_instruction+0x345/0x600 [kvm]
 ? vmx_handle_exit+0x2f5/0x760 [kvm_intel]
 ? kvm_arch_vcpu_ioctl_run+0x60b/0x1b40 [kvm]
 ? kvm_vcpu_ioctl+0x2ce/0x690 [kvm]
 ? __x64_sys_ioctl+0x483/0xa50
 ? do_syscall_64+0x40/0xa0
 ? entry_SYSCALL_64_after_hwframe+0x44/0xae
 </TASK>
Modules linked in: nfsv4 cpufreq_userspace cpufreq_powersave cpufreq_ondemand cpufreq_conservative autofs4 fan nfsd auth_rpcgss nfs lockd grace fscache netfs sunrpc bridge stp llc nhpoly1305_sse2 nhpoly1305 aes_generic libaes chacha_generic chacha_x86_64 libchacha adiantum libpoly1305 vhost_net tun vhost vhost_iotlb tap dm_crypt snd_hda_codec_analog snd_hda_codec_generic snd_usb_audio snd_usbmidi_lib snd_rawmidi usb_storage snd_hda_intel snd_seq_device snd_intel_dspcfg snd_hda_codec snd_hwdep snd_hda_core dcdbas tg3 snd_pcm floppy kvm_intel snd_timer snd evdev soundcore kvm sr_mod cdrom irqbypass sg xfs dm_mod raid1 md_mod psmouse
---[ end trace 0000000000000000 ]---
RIP: 0010:setc+0x5/0x8 [kvm]
Code: 00 00 0f 1f 00 0f b6 05 43 24 06 00 c3 cc 0f 1f 80 00 00 00 00 0f 90 c0 c3 cc 0f 1f 00 0f 91 c0 c3 cc 0f 1f 00 0f 92 c0 c3 cc <0f> 1f 00 0f 93 c0 c3 cc 0f 1f 00 0f 94 c0 c3 cc 0f 1f 00 0f 95 c0
RSP: 0018:ffffc90000a1fc68 EFLAGS: 00000283
RAX: 0000000000000281 RBX: 0000000000000006 RCX: 0000000000000005
RDX: ffffffffa01a4024 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88810ef76900 R08: 0000000000000000 R09: 0000000000000000
R10: ffff88810ee54000 R11: 0000000000000000 R12: ffffffffa01d5720
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88810ef76900
FS:  00007f23ecd79640(0000) GS:ffff888233c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000108df8000 CR4: 00000000000426f0
Kernel panic - not syncing: Fatal exception in interrupt
Kernel Offset: disabled
---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---


-- 
Jamie Heilman                     http://audible.transient.net/~jamie/
