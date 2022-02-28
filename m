Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3254C65E1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbiB1JoT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Feb 2022 04:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbiB1JoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:44:17 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A068913D79;
        Mon, 28 Feb 2022 01:43:34 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nOcZ2-0007D9-Bx; Mon, 28 Feb 2022 10:43:32 +0100
Message-ID: <35bafd68-b340-dfaa-dd5f-d45843104f91@leemhuis.info>
Date:   Mon, 28 Feb 2022 10:43:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Bug 215605 - [5.14 regression] BUG: unable to handle page fault
 while running badblocks (fsck.ext4 -c) on a raid5 md array
Content-Language: en-BS
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Song Liu <song@kernel.org>, linux-raid@vger.kernel.org
Cc:     Dominik Mierzejewski <dominik@greysector.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Jens Axboe <axboe@kernel.dk>
References: <53e7de78-4d27-5089-f159-0d443b354666@leemhuis.info>
In-Reply-To: <53e7de78-4d27-5089-f159-0d443b354666@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1646041414;4cfc9239;
X-HE-SMSGID: 1nOcZ2-0007D9-Bx
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing Jens]

Hi, this is your Linux kernel regression tracker. Top-posting for once,
to make this easily accessible to everyone.

What's up here? Below regression was reported two weeks ago and I
forwarded it nearly a week ago, nevertheless the reporter afaics didn't
get a single reply. Is the issue discussed somewhere else and I just
missed it? Is the report not accurate for some reason or missing
something important? Or did the report fall throug the cracks?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.

#regzbot poke

On 22.02.22 09:59, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker.
> 
> I noticed a regression report in bugzilla.kernel.org that afaics nobody
> acted upon since it was reported about a week ago, that's why I decided
> to forward it to the lists and add a few relevant people to the CC. To
> quote from https://bugzilla.kernel.org/show_bug.cgi?id=215605
> 
>>  Dominik Mierzejewski 2022-02-14 10:36:36 UTC
>>
>> Created attachment 300450 [details]
>> kernel-5.16.8 dmesg with crash
>>
>> I'm experiencing kernel crash when running badblocks (fsck.ext4 -c) on a raid5 md array in my Intel Atom-based NAS box (Thecus N5550):
>> [  720.911993] kernel: BUG: unable to handle page fault for address: ffffdbc681023bc8
>> [  720.912073] kernel: #PF: supervisor read access in kernel mode
>> [  720.912120] kernel: #PF: error_code(0x0000) - not-present page
>> [  720.912166] kernel: PGD 11ffc6067 P4D 11ffc6067 PUD 0 
>> [  720.912213] kernel: Oops: 0000 [#1] PREEMPT SMP NOPTI
>> [  720.912256] kernel: CPU: 1 PID: 1406 Comm: badblocks Not tainted 5.16.8-200.fc35.x86_64 #1
>> [  720.912321] kernel: Hardware name: Intel Corporation Milstead Platform/Granite Well, BIOS CDV W Series 05 08/27/2015
>> [  720.912400] kernel: RIP: 0010:kfree+0x58/0x3e0
>> [  720.912449] kernel: Code: 80 4c 01 e5 0f 82 84 03 00 00 48 c7 c0 00 00 00 80 48 2b 05 4a 96 3b 01 48 01 c5 48 c1 ed 0c 48 c1 e5 06 48 03 2d 28 96 3b 01 <48> 8b 45 08 48 8d 50 ff a8 01 48 0f 45 ea 4
>> 8 8b 55 08 48 8d 42 ff
>> [  720.912598] kernel: RSP: 0018:ffff9db4008efaf8 EFLAGS: 00010286
>> [  720.912648] kernel: RAX: 00006d7bc0000000 RBX: ffff9284c5214800 RCX: ffff9284c3758ff8
>> [  720.912708] kernel: RDX: ffff9283c1102740 RSI: ffffffffc07af091 RDI: ffff9db4008efd58
>> [  720.912767] kernel: RBP: ffffdbc681023bc0 R08: ffff9db4008efb88 R09: ffff9284c3759000
>> [  720.912826] kernel: R10: 0000000000000028 R11: ffff9284c213db48 R12: ffff9db4008efd58
>> [  720.912885] kernel: R13: ffff9284c213da00 R14: ffff9284c375f000 R15: ffff9db4008efd58
>> [  720.912945] kernel: FS:  00007f73e6669740(0000) GS:ffff9284dbc80000(0000) knlGS:0000000000000000
>> [  720.913012] kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  720.913062] kernel: CR2: ffffdbc681023bc8 CR3: 000000005c2cc000 CR4: 00000000000006e0
>> [  720.913122] kernel: Call Trace:
>> [  720.913150] kernel:  <TASK>
>> [  720.913179] kernel:  raid5_make_request+0xb31/0xb90 [raid456]
>> [  720.913247] kernel:  ? do_wait_intr_irq+0xa0/0xa0
>> [  720.913292] kernel:  ? __blk_queue_split+0x30a/0x470
>> [  720.913339] kernel:  md_handle_request+0x119/0x180
>> [  720.913386] kernel:  md_submit_bio+0x67/0xa0
>> [  720.913425] kernel:  __submit_bio_fops+0x91/0x160
>> [  720.913468] kernel:  submit_bio_noacct+0xd7/0x2c0
>> [  720.913510] kernel:  __blkdev_direct_IO_simple+0x198/0x290
>> [  720.913576] kernel:  ? __fpu_restore_sig+0x193/0x570
>> [  720.913623] kernel:  ? sysvec_apic_timer_interrupt+0xaf/0xd0
>> [  720.913676] kernel:  ? __blkdev_direct_IO_simple+0x290/0x290
>> [  720.913728] kernel:  generic_file_read_iter+0x9b/0x160
>> [  720.913775] kernel:  new_sync_read+0x105/0x180
>> [  720.913820] kernel:  vfs_read+0xf1/0x190
>> [  720.913858] kernel:  ksys_read+0x4f/0xc0
>> [  720.913896] kernel:  do_syscall_64+0x38/0x90
>> [  720.913936] kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [  720.913985] kernel: RIP: 0033:0x7f73e676d772
>> [  720.914024] kernel: Code: c0 e9 b2 fe ff ff 50 48 8d 3d da 2e 0c 00 e8 b5 f9 01 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
>> [  720.914166] kernel: RSP: 002b:00007fff1b8fcbb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>> [  720.914231] kernel: RAX: ffffffffffffffda RBX: 0000000000000040 RCX: 00007f73e676d772
>> [  720.917149] kernel: RDX: 0000000000040000 RSI: 00007f73e65d3000 RDI: 0000000000000004
>> [  720.920078] kernel: RBP: 0000000000001000 R08: 00000000015105c0 R09: 0000000000000080
>> [  720.922980] kernel: R10: 00007fff1b8fca00 R11: 0000000000000246 R12: 00000015105c0000
>> [  720.925875] kernel: R13: 0000000000000004 R14: 00007f73e65d3000 R15: 0000000000040000
>> [  720.928795] kernel:  </TASK>
>> [  720.931704] kernel: Modules linked in: sctp ip6_udp_tunnel udp_tunnel rpcrdma rdma_cm iw_cm ib_cm ib_core sit tunnel4 ip_tunnel rfkill ipt_REJECT nf_reject_ipv4 iptable_filter xt_nat iptable_nat nf_nat iptable_mangle nf_conntrack_pptp xt_CT iptable_raw xt_multiport xt_set ip6t_REJECT nf_reject_ipv6 xt_LOG nf_log_syslog xt_limit xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter ip6_tables ip_set_hash_netport ip_set_hash_net ip_set drivetemp it87 nfnetlink hwmon_vid vfat fat iTCO_wdt intel_pmc_bxt iTCO_vendor_support at24 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx intel_powerclamp raid1 coretemp snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_hda_core snd_usb_audio i2c_i801 gma500_gfx i2c_smbus snd_usbmidi_lib joydev snd_hwdep snd_rawmidi snd_seq_device mc snd_pcm lpc_ich i2c_algo_bit snd_timer drm_kms_helper snd cec soundcore nfsd auth_rpcgss
>> [  720.931885] kernel:  nfs_acl lockd grace drm fuse sunrpc zram ip_tables hid_logitech_hidpp serio_raw r8152 sata_sil24 video mii hid_jabra e1000e hid_logitech_dj
>> [  720.952122] kernel: CR2: ffffdbc681023bc8
>> [  720.955651] kernel: ---[ end trace de2c3d5b971ae71d ]---
>> [  720.959186] kernel: RIP: 0010:kfree+0x58/0x3e0
>> [  720.962723] kernel: Code: 80 4c 01 e5 0f 82 84 03 00 00 48 c7 c0 00 00 00 80 48 2b 05 4a 96 3b 01 48 01 c5 48 c1 ed 0c 48 c1 e5 06 48 03 2d 28 96 3b 01 <48> 8b 45 08 48 8d 50 ff a8 01 48 0f 45 ea 48 8b 55 08 48 8d 42 ff
>> [  720.966472] kernel: RSP: 0018:ffff9db4008efaf8 EFLAGS: 00010286
>> [  720.970238] kernel: RAX: 00006d7bc0000000 RBX: ffff9284c5214800 RCX: ffff9284c3758ff8
>> [  720.973993] kernel: RDX: ffff9283c1102740 RSI: ffffffffc07af091 RDI: ffff9db4008efd58
>> [  720.977723] kernel: RBP: ffffdbc681023bc0 R08: ffff9db4008efb88 R09: ffff9284c3759000
>> [  720.981464] kernel: R10: 0000000000000028 R11: ffff9284c213db48 R12: ffff9db4008efd58
>> [  720.985228] kernel: R13: ffff9284c213da00 R14: ffff9284c375f000 R15: ffff9db4008efd58
>> [  720.988995] kernel: FS:  00007f73e6669740(0000) GS:ffff9284dbc80000(0000) knlGS:0000000000000000
>> [  720.992774] kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  720.996535] kernel: CR2: ffffdbc681023bc8 CR3: 000000005c2cc000 CR4: 00000000000006e0
>>
>> There was a crash earlier which caused the array to become degraded, but I wasn't able to capture the backtrace due to journal corruption. After resyncing the array I tried running fsck on the filesystem and it's causing a kernel crash each time.
>>
>> I've reproduced the crash with the following kernels:
>> 5.16.8-200.fc35.x86_64
>> 5.15.18-200.fc35.x86_64
>> 5.14.10-300.fc35.x86_64
>>
>> It doesn't happen with 5.13 kernels. I've been running fsck.ext4 -c on the array for the last 10 hours without a crash. It found 27 read errors which it corrected.
>>
>> Steps to reproduce:
>> 1. fsck.ext4 -c -v /dev/md126
>> 2. crash
>>
>> The array was degraded as a result of a previous crash, but it recovered itself with no errors reported. Obviously, there remained some read errors which badblocks found and which the kernel tripped over.
>>
>> Crash with 5.14.10 looks different:
>> Feb 13 17:55:06 kernel: general protection fault, probably for non-canonical address 0xef6dfcf53c7d6fc3: 0000 [#1] SMP NOPTI
>> Feb 13 17:55:06 kernel: CPU: 2 PID: 831 Comm: md126_raid5 Not tainted 5.14.10-300.fc35.x86_64 #1
>> Feb 13 17:55:06 kernel: Hardware name: Intel Corporation Milstead Platform/Granite Well, BIOS CDV W Series 05 08/27/2015
>> Feb 13 17:55:06 kernel: RIP: 0010:bio_endio+0x87/0x130
>> Feb 13 17:55:06 kernel: Code: 02 00 48 8b 45 08 48 85 c0 74 09 0f b7 55 14 f6 c6 01 75 2f 48 81 7d 38 50 48 5e bb 75 38 0f b6 45 1a 48 8b 5d 40 84 c0 74 09 <80> 7b 1a 00 75 03 88 43 1a 48 89 ef 48 89 dd e8 d5 fe ff ff e9 6a
>> Feb 13 17:55:06 kernel: RSP: 0000:ffffa5bb80597b48 EFLAGS: 00010206
>> Feb 13 17:55:06 kernel: RAX: 000000000000000a RBX: ef6dfcf53c7d6fa9 RCX: ffff92b840865b50
>> Feb 13 17:55:06 kernel: RDX: 0000000000000082 RSI: ffff92b8497f46c0 RDI: ffff92b84881f180
>> Feb 13 17:55:06 kernel: RBP: ffff92b8497f46c0 R08: 0000000000000001 R09: 0000000000000000
>> Feb 13 17:55:06 kernel: R10: ffff92b74a722c01 R11: 0000000000000001 R12: 0000000000000000
>> Feb 13 17:55:06 kernel: R13: 0000000000000000 R14: ffff92b74a722cd0 R15: ffff92b844748860
>> Feb 13 17:55:06 kernel: FS:  0000000000000000(0000) GS:ffff92b85bd00000(0000) knlGS:0000000000000000
>> Feb 13 17:55:06 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> Feb 13 17:55:06 kernel: CR2: 0000557d787a2028 CR3: 000000003c194000 CR4: 00000000000006e0
>> Feb 13 17:55:06 kernel: Call Trace:
>> Feb 13 17:55:06 kernel:  ops_complete_biofill+0x98/0xe0 [raid456]
>> Feb 13 17:55:06 kernel:  async_trigger_callback+0x7d/0xc1 [async_tx]
>> Feb 13 17:55:06 kernel:  raid_run_ops+0x98c/0x15b0 [raid456]
>> Feb 13 17:55:06 kernel:  ? handle_stripe_clean_event+0x400/0x400 [raid456]
>> Feb 13 17:55:06 kernel:  handle_stripe+0xe91/0x1dc0 [raid456]
>> Feb 13 17:55:06 kernel:  handle_active_stripes.constprop.0+0x390/0x560 [raid456]
>> Feb 13 17:55:06 kernel:  raid5d+0x39d/0x5d0 [raid456]
>> Feb 13 17:55:06 kernel:  ? prepare_to_wait_event+0x5d/0x170
>> Feb 13 17:55:06 kernel:  md_thread+0x98/0x140
>> Feb 13 17:55:06 kernel:  ? finish_wait+0x80/0x80
>> Feb 13 17:55:06 kernel:  ? md_write_inc+0x50/0x50
>> Feb 13 17:55:06 kernel:  kthread+0x124/0x150
>> Feb 13 17:55:06 kernel:  ? set_kthread_struct+0x40/0x40
>> Feb 13 17:55:06 kernel:  ret_from_fork+0x1f/0x30
>> Feb 13 17:55:06 kernel: Modules linked in: rpcrdma rdma_cm iw_cm ib_cm ib_core rfkill ip6t_REJECT nf_reject_ipv6 ip6table_filter ip6_tables xt_set ipt_REJECT nf_reject_ipv4 xt_LOG nf_log_syslog xt_limit xt_multiport xt_state xt_conntrack iptable_filter xt_nat iptable_nat nf_nat iptable_mangle nf_conntrack_pptp xt_CT nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_raw ip_set_hash_netport ip_set_hash_net ip_set drivetemp it87 nfnetlink hwmon_vid vfat fat snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi iTCO_wdt snd_hda_intel intel_pmc_bxt snd_intel_dspcfg iTCO_vendor_support raid456 snd_intel_sdw_acpi snd_hda_codec async_raid6_recov at24 async_memcpy async_pq async_xor async_tx snd_hda_core gma500_gfx snd_hwdep i2c_algo_bit drm_kms_helper snd_pcm intel_powerclamp i2c_i801 snd_timer coretemp i2c_smbus snd cec soundcore lpc_ich nfsd auth_rpcgss nfs_acl lockd drm grace fuse sunrpc ip_tables raid1 serio_raw video sata_sil24 e1000e
>> Feb 13 17:55:06 kernel: ---[ end trace 97447bed31e596e0 ]---
>> Feb 13 17:55:06 kernel: RIP: 0010:bio_endio+0x87/0x130
>> Feb 13 17:55:06 kernel: Code: 02 00 48 8b 45 08 48 85 c0 74 09 0f b7 55 14 f6 c6 01 75 2f 48 81 7d 38 50 48 5e bb 75 38 0f b6 45 1a 48 8b 5d 40 84 c0 74 09 <80> 7b 1a 00 75 03 88 43 1a 48 89 ef 48 89 dd e8 d5 fe ff ff e9 6a
>> Feb 13 17:55:06 kernel: RSP: 0000:ffffa5bb80597b48 EFLAGS: 00010206
>> Feb 13 17:55:06 kernel: RAX: 000000000000000a RBX: ef6dfcf53c7d6fa9 RCX: ffff92b840865b50
>> Feb 13 17:55:06 kernel: RDX: 0000000000000082 RSI: ffff92b8497f46c0 RDI: ffff92b84881f180
>> Feb 13 17:55:06 kernel: RBP: ffff92b8497f46c0 R08: 0000000000000001 R09: 0000000000000000
>> Feb 13 17:55:06 kernel: R10: ffff92b74a722c01 R11: 0000000000000001 R12: 0000000000000000
>> Feb 13 17:55:06 kernel: R13: 0000000000000000 R14: ffff92b74a722cd0 R15: ffff92b844748860
>> Feb 13 17:55:06 kernel: FS:  0000000000000000(0000) GS:ffff92b85bd00000(0000) knlGS:0000000000000000
>> Feb 13 17:55:06 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> Feb 13 17:55:06 kernel: CR2: 0000557d787a2028 CR3: 000000003c194000 CR4: 00000000000006e0
>> Feb 13 17:55:06 kernel: ------------[ cut here ]------------
>> Feb 13 17:55:06 kernel: WARNING: CPU: 2 PID: 831 at kernel/exit.c:739 do_exit+0x37/0xa90
>> Feb 13 17:55:06 kernel: Modules linked in: rpcrdma rdma_cm iw_cm ib_cm ib_core rfkill ip6t_REJECT nf_reject_ipv6 ip6table_filter ip6_tables xt_set ipt_REJECT nf_reject_ipv4 xt_LOG nf_log_syslog xt_limit xt_multiport xt_state xt_conntrack iptable_filter xt_nat iptable_nat nf_nat iptable_mangle nf_conntrack_pptp xt_CT nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_raw ip_set_hash_netport ip_set_hash_net ip_set drivetemp it87 nfnetlink hwmon_vid vfat fat snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi iTCO_wdt snd_hda_intel intel_pmc_bxt snd_intel_dspcfg iTCO_vendor_support raid456 snd_intel_sdw_acpi snd_hda_codec async_raid6_recov at24 async_memcpy async_pq async_xor async_tx snd_hda_core gma500_gfx snd_hwdep i2c_algo_bit drm_kms_helper snd_pcm intel_powerclamp i2c_i801 snd_timer coretemp i2c_smbus snd cec soundcore lpc_ich nfsd auth_rpcgss nfs_acl lockd drm grace fuse sunrpc ip_tables raid1 serio_raw video sata_sil24 e1000e
>> Feb 13 17:55:06 kernel: CPU: 2 PID: 831 Comm: md126_raid5 Tainted: G      D           5.14.10-300.fc35.x86_64 #1
>> Feb 13 17:55:06 kernel: Hardware name: Intel Corporation Milstead Platform/Granite Well, BIOS CDV W Series 05 08/27/2015
>> Feb 13 17:55:06 kernel: RIP: 0010:do_exit+0x37/0xa90
>> Feb 13 17:55:06 kernel: Code: 55 48 89 fd 53 65 48 8b 1c 25 c0 7b 01 00 48 83 ec 28 48 8b 83 a8 0c 00 00 48 85 c0 74 0e 48 8b 10 48 39 d0 0f 84 56 04 00 00 <0f> 0b 65 8b 0d a0 2c f3 44 89 c8 25 00 ff ff 00 89 44 24 0c 0f 85
>> Feb 13 17:55:06 kernel: RSP: 0000:ffffa5bb80597ef8 EFLAGS: 00010212
>> Feb 13 17:55:06 kernel: RAX: ffffa5bb80597e50 RBX: ffff92b8437d8000 RCX: 0000000000000000
>> Feb 13 17:55:06 kernel: RDX: ffff92b844217548 RSI: ffff92b85bd18a00 RDI: 000000000000000b
>> Feb 13 17:55:06 kernel: RBP: 000000000000000b R08: 0000000000000000 R09: ffffa5bb805977a0
>> Feb 13 17:55:06 kernel: R10: ffffa5bb80597798 R11: ffffffffbcf47468 R12: 000000000000000b
>> Feb 13 17:55:06 kernel: R13: 0000000000000000 R14: ffff92b8437d8000 R15: 0000000000000000
>> Feb 13 17:55:06 kernel: FS:  0000000000000000(0000) GS:ffff92b85bd00000(0000) knlGS:0000000000000000
>> Feb 13 17:55:06 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> Feb 13 17:55:06 kernel: CR2: 0000557d787a2028 CR3: 000000003c194000 CR4: 00000000000006e0
>> Feb 13 17:55:06 kernel: Call Trace:
>> Feb 13 17:55:06 kernel:  ? kthread+0x124/0x150
>> Feb 13 17:55:06 kernel:  rewind_stack_do_exit+0x17/0x20
>> Feb 13 17:55:06 kernel: RIP: 0000:0x0
>> Feb 13 17:55:06 kernel: Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
>> Feb 13 17:55:06 kernel: RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
>> Feb 13 17:55:06 kernel: RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
>> Feb 13 17:55:06 kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>> Feb 13 17:55:06 kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>> Feb 13 17:55:06 kernel: R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>> Feb 13 17:55:06 kernel: R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>> Feb 13 17:55:06 kernel: ---[ end trace 97447bed31e596e1 ]---
>>
>> Downstream bug report: https://bugzilla.redhat.com/show_bug.cgi?id=2053936 .
> 
> Could somebody take a look into this? Or was this discussed somewhere
> else already? Or even fixed?
> 
> FWIW, I searched the list and wondered if these might be related, but I
> was unable to tell for sure:
> 
> https://lore.kernel.org/all/164244747275.86917.2623783912687807916@richardiv.omgwallhack.org/
> https://lore.kernel.org/all/20211216145222.15370-4-mariusz.tkaczyk@linux.intel.com/
> 
> Anyway, to get this tracked:
> 
> #regzbot introduced: v5.13..v5.14.10
> #regzbot from: Dominik Mierzejewski <dominik@greysector.net>
> #regzbot title: md: unable to handle page fault while running badblocks
> (fsck.ext4 -c) on a raid5 md array
> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215605
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> 
> P.S.: As the Linux kernel's regression tracker I'm getting a lot of
> reports on my table. I can only look briefly into most of them and lack
> knowledge about most of the areas they concern. I thus unfortunately
> will sometimes get things wrong or miss something important. I hope
> that's not the case here; if you think it is, don't hesitate to tell me
> in a public reply, it's in everyone's interest to set the public record
> straight.
> 
