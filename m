Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92274F0F7A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 08:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377503AbiDDGjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 02:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237532AbiDDGji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 02:39:38 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0357EDFFC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 23:37:42 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nbGLL-0005mB-NA; Mon, 04 Apr 2022 08:37:40 +0200
Message-ID: <fb45f370-1dbf-56c2-50da-5e5f5a5b561e@leemhuis.info>
Date:   Mon, 4 Apr 2022 08:37:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: PANIC: "Oops: 0000 [#1] PREEMPT SMP PTI" starting from 5.17 on
 dual socket Intel Xeon Gold servers #forregzbot
Content-Language: en-US
To:     regressions@lists.linux.dev
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
References: <CAE4VaGDZr_4wzRn2___eDYRtmdPaGGJdzu_LCSkJYuY9BEO3cw@mail.gmail.com>
 <536eca11-b4b9-c1a8-6e6b-fcd0c339a3ec@leemhuis.info>
 <CAE4VaGBZk2NL6Tn2fGxmGMR-n8KFNqgPOktY_sQ1vjViLDNhhg@mail.gmail.com>
 <CAE4VaGB4=aCd8iDb4EduR+-5QTSgVWd5sxrnBA4e3g9dPrnuBg@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CAE4VaGB4=aCd8iDb4EduR+-5QTSgVWd5sxrnBA4e3g9dPrnuBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1649054262;fed8beeb;
X-HE-SMSGID: 1nbGLL-0005mB-NA
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWIMC: this mail is primarily send for documentation purposes and for
regzbot, my Linux kernel regression tracking bot. These mails usually
contain '#forregzbot' in the subject, to make them easy to spot and filter.

#regzbot introduced: 393c3714081a53795bbff0e985d24146def6f57

On 31.03.22 00:24, Jirka Hladky wrote:
> Adding Minchan Kim on Cc.
> 
> @Minchan - commit 393c3714081a53795bbff0e985d24146def6f57f authored by
> you is causing BUG: kernel NULL pointer dereference, address:
> 0000000000000008
> 
> Could you please have a look at what might be wrong?
> 
> Thank you!
> Jirka
> 
> On Thu, Mar 31, 2022 at 12:16 AM Jirka Hladky <jhladky@redhat.com> wrote:
>>
>> Hi Thorsten,
>>
>> thanks for adding this to the regzbot bot.
>>
>> Hi Greg and all,
>>
>> I did bisecting and I have found the commit causing this issue [1].
>> Could you please have a look at the code how to fix it?
>>
>> Thanks a lot
>> Jirka
>>
>> [1]
>> =========================================================
>> $ git bisect visualize
>> commit 393c3714081a53795bbff0e985d24146def6f57f (refs/bisect/bad)
>> Author: Minchan Kim <minchan@kernel.org>
>> Date:   Thu Nov 18 15:00:08 2021 -0800
>>
>>    kernfs: switch global kernfs_rwsem lock to per-fs lock
>>
>>    The kernfs implementation has big lock granularity(kernfs_rwsem) so
>>    every kernfs-based(e.g., sysfs, cgroup) fs are able to compete the
>>    lock. It makes trouble for some cases to wait the global lock
>>    for a long time even though they are totally independent contexts
>>    each other.
>>
>>    A general example is process A goes under direct reclaim with holding
>>    the lock when it accessed the file in sysfs and process B is waiting
>>    the lock with exclusive mode and then process C is waiting the lock
>>    until process B could finish the job after it gets the lock from
>>    process A.
>>
>>    This patch switches the global kernfs_rwsem to per-fs lock, which
>>    put the rwsem into kernfs_root.
>>
>>    Suggested-by: Tejun Heo <tj@kernel.org>
>>    Acked-by: Tejun Heo <tj@kernel.org>
>>    Signed-off-by: Minchan Kim <minchan@kernel.org>
>>    Link: https://lore.kernel.org/r/20211118230008.2679780-1-minchan@kernel.org
>>    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> =========================================================
>>
>> The bug is triggered by running NAS Parallel benchmark suite on
>> SuperMicro servers with 2x Xeon(R) Gold 6126 CPU. Here is the error
>> log:
>>
>> [  247.035564] BUG: kernel NULL pointer dereference, address: 0000000000000008
>> [  247.036009] #PF: supervisor read access in kernel mode
>> [  247.036009] #PF: error_code(0x0000) - not-present page
>> [  247.036009] PGD 0 P4D 0
>> [  247.036009] Oops: 0000 [#1] PREEMPT SMP PTI
>> [  247.058060] CPU: 1 PID: 6546 Comm: umount Not tainted
>> 5.16.0393c3714081a53795bbff0e985d24146def6f57f+ #16
>> [  247.058060] Hardware name: Supermicro Super Server/X11DDW-L, BIOS
>> 2.0b 03/07/2018
>> [  247.058060] RIP: 0010:kernfs_remove+0x8/0x50
>> [  247.058060] Code: 4c 89 e0 5b 5d 41 5c 41 5d 41 5e c3 49 c7 c4 f4
>> ff ff ff eb b2 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 0f 1f 44 00 00
>> 41 54 55 <48> 8b 47 08 48 89 fd 48 85 c0 48 0f 44 c7 4c 8b 60 50 49 83
>> c4 60
>> [  247.058060] RSP: 0018:ffffbbfa48a27e48 EFLAGS: 00010246
>> [  247.058060] RAX: 0000000000000001 RBX: ffffffff89e31f98 RCX: 0000000080200018
>> [  247.058060] RDX: 0000000080200019 RSI: fffff6760786c900 RDI: 0000000000000000
>> [  247.058060] RBP: ffffffff89e31f98 R08: ffff926b61b24d00 R09: 0000000080200018
>> [  247.122048] R10: ffff926b61b24d00 R11: ffff926a8040c000 R12: ffff927bd09a2000
>> [  247.122048] R13: ffffffff89e31fa0 R14: dead000000000122 R15: dead000000000100
>> [  247.122048] FS:  00007f01be0a8c40(0000) GS:ffff926fa8e40000(0000)
>> knlGS:0000000000000000
>> [  247.122048] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  247.122048] CR2: 0000000000000008 CR3: 00000001145c6003 CR4: 00000000007706e0
>> [  247.122048] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [  247.122048] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [  247.122048] PKRU: 55555554
>> [  247.122048] Call Trace:
>> [  247.122048]  <TASK>
>> [  247.122048]  rdt_kill_sb+0x29d/0x350
>> [  247.122048]  deactivate_locked_super+0x36/0xa0
>> [  247.122048]  cleanup_mnt+0x131/0x190
>> [  247.122048]  task_work_run+0x5c/0x90
>> [  247.122048]  exit_to_user_mode_prepare+0x229/0x230
>> [  247.122048]  syscall_exit_to_user_mode+0x18/0x40
>> [  247.122048]  do_syscall_64+0x48/0x90
>> [  247.122048]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [  247.122048] RIP: 0033:0x7f01be2d735b
>> [  247.122048] Code: 2b 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3
>> 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00
>> 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 e9 2a 0c 00
>> f7 d8
>> [  247.122048] RSP: 002b:00007ffde1021e08 EFLAGS: 00000202 ORIG_RAX:
>> 00000000000000a6
>> [  247.122048] RAX: 0000000000000000 RBX: 0000560c012bf5a0 RCX: 00007f01be2d735b
>> [  247.122048] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000560c012c33a0
>> [  247.259079] RBP: 0000560c012bf370 R08: 0000000000000001 R09: 00007ffde1020b90
>> [  247.267058] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000001
>> [  247.271055] R13: 0000560c012c33a0 R14: 0000560c012bf480 R15: 0000560c012bf370
>> [  247.279066]  </TASK>
>> [  247.283054] Modules linked in: rfkill sunrpc intel_rapl_msr
>> intel_rapl_common isst_if_common skx_edac nfit libnvdimm
>> x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel irdma kvm ice
>> iTCO_wdt intel_pmc_bxt iTCO_vendor_support i
>> rqbypass ib_uverbs ipmi_ssif rapl intel_cstate ib_core mei_me joydev
>> intel_uncore i2c_i801 ioatdma acpi_ipmi lpc_ich mei pcspkr i2c_smbus
>> intel_pch_thermal dca ipmi_si acpi_power_meter acpi_pad zram ip_tables
>> xfs ast i2c_algo_bit drm_v
>> ram_helper drm_kms_helper cec drm_ttm_helper ttm drm i40e
>> crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel wmi
>> fuse ipmi_devintf ipmi_msghandler
>> [  247.335054] CR2: 0000000000000008
>> [  247.339041] ---[ end trace d8ccdb6c2d272688 ]---
>> [  247.355057] RIP: 0010:kernfs_remove+0x8/0x50
>> [  247.359059] Code: 4c 89 e0 5b 5d 41 5c 41 5d 41 5e c3 49 c7 c4 f4
>> ff ff ff eb b2 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 0f 1f 44 00 00
>> 41 54 55 <48> 8b 47 08 48 89 fd 48 85 c0 48 0f 44 c7 4c 8b 60 50 49 83
>> c4 60
>> [  247.379054] RSP: 0018:ffffbbfa48a27e48 EFLAGS: 00010246
>> [  247.383056] RAX: 0000000000000001 RBX: ffffffff89e31f98 RCX: 0000000080200018
>> [  247.391053] RDX: 0000000080200019 RSI: fffff6760786c900 RDI: 0000000000000000
>> [  247.395047] RBP: ffffffff89e31f98 R08: ffff926b61b24d00 R09: 0000000080200018
>> [  247.403055] R10: ffff926b61b24d00 R11: ffff926a8040c000 R12: ffff927bd09a2000
>> [  247.411046] R13: ffffffff89e31fa0 R14: dead000000000122 R15: dead000000000100
>> [  247.419055] FS:  00007f01be0a8c40(0000) GS:ffff926fa8e40000(0000)
>> knlGS:0000000000000000
>> [  247.427055] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  247.431055] CR2: 0000000000000008 CR3: 00000001145c6003 CR4: 00000000007706e0
>> [  247.439055] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [  247.443055] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [  247.455060] PKRU: 55555554
>>
>> On Thu, Mar 24, 2022 at 12:49 PM Thorsten Leemhuis
>> <regressions@leemhuis.info> wrote:
>>>
>>> [TLDR: I'm adding the regression report below to regzbot, the Linux
>>> kernel regression tracking bot; all text you find below is compiled from
>>> a few templates paragraphs you might have encountered already already
>>> from similar mails.]
>>>
>>> Hi, this is your Linux kernel regression tracker. Top-posting for once,
>>> to make this easily accessible to everyone.
>>>
>>> To be sure below issue doesn't fall through the cracks unnoticed, I'm
>>> adding it to regzbot, my Linux kernel regression tracking bot:
>>>
>>> #regzbot ^introduced v5.16..v5.17
>>> #regzbot ignore-activity
>>>
>>> If it turns out this isn't a regression, free free to remove it from the
>>> tracking by sending a reply to this thread containing a paragraph like
>>> "#regzbot invalid: reason why this is invalid" (without the quotes).
>>>
>>> Reminder for developers: when fixing the issue, please add a 'Link:'
>>> tags pointing to the report (the mail quoted above) using
>>> lore.kernel.org/r/, as explained in
>>> 'Documentation/process/submitting-patches.rst' and
>>> 'Documentation/process/5.Posting.rst'. Regzbot needs them to
>>> automatically connect reports with fixes, but they are useful in
>>> general, too.
>>>
>>> I'm sending this to everyone that got the initial report, to make
>>> everyone aware of the tracking. I also hope that messages like this
>>> motivate people to directly get at least the regression mailing list and
>>> ideally even regzbot involved when dealing with regressions, as messages
>>> like this wouldn't be needed then. And don't worry, if I need to send
>>> other mails regarding this regression only relevant for regzbot I'll
>>> send them to the regressions lists only (with a tag in the subject so
>>> people can filter them away). With a bit of luck no such messages will
>>> be needed anyway.
>>>
>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>>
>>> P.S.: As the Linux kernel's regression tracker I'm getting a lot of
>>> reports on my table. I can only look briefly into most of them and lack
>>> knowledge about most of the areas they concern. I thus unfortunately
>>> will sometimes get things wrong or miss something important. I hope
>>> that's not the case here; if you think it is, don't hesitate to tell me
>>> in a public reply, it's in everyone's interest to set the public record
>>> straight.
>>>
>>>
>>> On 22.03.22 00:29, Jirka Hladky wrote:
>>>> Starting from kernel 5.17 (tested with rc2, rc4, rc7, rc8) we
>>>> experience kernel oops on Intel Xeon Gold dual-socket servers (2x Xeon
>>>> Gold 6126 CPU)
>>>>
>>>> Bellow is a backtrace and the dmesg log.
>>>>
>>>> I have trouble creating a simple reproducer - it happens at random
>>>> places when preparing the NAS benchmark to be run. The script creates
>>>> a bunch of directories, compiles the benchmark a start trial runs.
>>>>
>>>> Could you please help to narrow down the problem?
>>>>
>>>> Reports bellow were created with kernel 5.17 rc8 and with
>>>> echo 1 > /proc/sys/kernel/panic_on_oops
>>>> setting.
>>>>
>>>> crash> sys
>>>>       KERNEL: /usr/lib/debug/lib/modules/5.17.0-0.rc8.123.fc37.x86_64/vmlinux
>>>>     DUMPFILE: vmcore  [PARTIAL DUMP]
>>>>         CPUS: 48
>>>>         DATE: Thu Mar 17 02:49:40 CET 2022
>>>>       UPTIME: 00:02:50
>>>> LOAD AVERAGE: 0.32, 0.10, 0.03
>>>>        TASKS: 608
>>>>     NODENAME: gold-2s-c
>>>>      RELEASE: 5.17.0-0.rc8.123.fc37.x86_64
>>>>      VERSION: #1 SMP PREEMPT Mon Mar 14 18:11:49 UTC 2022
>>>>      MACHINE: x86_64  (2600 Mhz)
>>>>       MEMORY: 94.7 GB
>>>>        PANIC: "Oops: 0000 [#1] PREEMPT SMP PTI" (check log for details)
>>>>
>>>>
>>>> crash> bt
>>>> PID: 2480   TASK: ffff9e8f76cb8000  CPU: 26  COMMAND: "umount"
>>>> #0 [ffffae00cacbfbb8] machine_kexec at ffffffffbb068980
>>>> #1 [ffffae00cacbfc08] __crash_kexec at ffffffffbb1a300a
>>>> #2 [ffffae00cacbfcc8] crash_kexec at ffffffffbb1a4045
>>>> #3 [ffffae00cacbfcd0] oops_end at ffffffffbb02c410
>>>> #4 [ffffae00cacbfcf0] page_fault_oops at ffffffffbb076a38
>>>> #5 [ffffae00cacbfd68] exc_page_fault at ffffffffbbd0b7c1
>>>> #6 [ffffae00cacbfd90] asm_exc_page_fault at ffffffffbbe00ace
>>>>    [exception RIP: kernfs_remove+7]
>>>>    RIP: ffffffffbb421f67  RSP: ffffae00cacbfe48  RFLAGS: 00010246
>>>>    RAX: 0000000000000001  RBX: ffffffffbce31e58  RCX: 0000000080200018
>>>>    RDX: 0000000080200019  RSI: ffffdfbd44161640  RDI: 0000000000000000
>>>>    RBP: ffffffffbce31e58   R8: 0000000000000000   R9: 0000000080200018
>>>>    R10: ffff9e8f05859e80  R11: ffff9e9443b1bd98  R12: ffff9ea057f1d000
>>>>    R13: ffffffffbce31e60  R14: dead000000000122  R15: dead000000000100
>>>>    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>>>> #7 [ffffae00cacbfe58] rdt_kill_sb at ffffffffbb05074b
>>>> #8 [ffffae00cacbfea8] deactivate_locked_super at ffffffffbb36ce1f
>>>> #9 [ffffae00cacbfec0] cleanup_mnt at ffffffffbb39176e
>>>> #10 [ffffae00cacbfee8] task_work_run at ffffffffbb10703c
>>>> #11 [ffffae00cacbff08] exit_to_user_mode_prepare at ffffffffbb17a399
>>>> #12 [ffffae00cacbff28] syscall_exit_to_user_mode at ffffffffbbd0bde8
>>>> #13 [ffffae00cacbff38] do_syscall_64 at ffffffffbbd071a6
>>>> #14 [ffffae00cacbff50] entry_SYSCALL_64_after_hwframe at ffffffffbbe0007c
>>>>    RIP: 00007f442c75126b  RSP: 00007ffc82d66fe8  RFLAGS: 00000202
>>>>    RAX: 0000000000000000  RBX: 000055bd4cc37090  RCX: 00007f442c75126b
>>>>    RDX: 0000000000000001  RSI: 0000000000000001  RDI: 000055bd4cc3b950
>>>>    RBP: 000055bd4cc371a8   R8: 0000000000000000   R9: 0000000000000073
>>>>    R10: 0000000000000000  R11: 0000000000000202  R12: 0000000000000001
>>>>    R13: 000055bd4cc3b950  R14: 000055bd4cc372c0  R15: 000055bd4cc37090
>>>>    ORIG_RAX: 00000000000000a6  CS: 0033  SS: 002b
>>>>
>>>> [2] dmesg
>>>> [  172.776553] BUG: kernel NULL pointer dereference, address: 0000000000000008
>>>> [  172.783513] #PF: supervisor read access in kernel mode
>>>> [  172.788652] #PF: error_code(0x0000) - not-present page
>>>> [  172.793793] PGD 0 P4D 0
>>>> [  172.796330] Oops: 0000 [#1] PREEMPT SMP PTI
>>>> [  172.800519] CPU: 26 PID: 2480 Comm: umount Kdump: loaded Not
>>>> tainted 5.17.0-0.rc8.123.fc37.x86_64 #1
>>>> [  172.809645] Hardware name: Supermicro Super Server/X11DDW-L, BIOS
>>>> 2.0b 03/07/2018
>>>> [  172.817123] RIP: 0010:kernfs_remove+0x7/0x50
>>>> [  172.821397] Code: e8 be e7 2c 00 48 89 df e8 b6 8c f0 ff 48 c7 c3
>>>> f4 ff ff ff 48 89 d8 5b 5d 41 5c 41 5d 41 5e c3 cc 66 90 0f 1f 44 00
>>>> 00 55 53 <48> 8b 47 08 48 89 fb 48 85 c0 48 0f 44 c7 48 8b 68 50 48 83
>>>> c5 60
>>>> [  172.840141] RSP: 0018:ffffae00cacbfe48 EFLAGS: 00010246
>>>> [  172.845367] RAX: 0000000000000001 RBX: ffffffffbce31e58 RCX: 0000000080200018
>>>> [  172.852501] RDX: 0000000080200019 RSI: ffffdfbd44161640 RDI: 0000000000000000
>>>> [  172.859632] RBP: ffffffffbce31e58 R08: 0000000000000000 R09: 0000000080200018
>>>> [  172.866764] R10: ffff9e8f05859e80 R11: ffff9e9443b1bd98 R12: ffff9ea057f1d000
>>>> [  172.873899] R13: ffffffffbce31e60 R14: dead000000000122 R15: dead000000000100
>>>> [  172.881033] FS:  00007f442c53c800(0000) GS:ffff9e9429000000(0000)
>>>> knlGS:0000000000000000
>>>> [  172.889117] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [  172.894861] CR2: 0000000000000008 CR3: 000000010ba96006 CR4: 00000000007706e0
>>>> [  172.901997] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>> [  172.909127] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>> [  172.916261] PKRU: 55555554
>>>> [  172.918974] Call Trace:
>>>> [  172.921427]  <TASK>
>>>> [  172.923533]  rdt_kill_sb+0x29b/0x350
>>>> [  172.927112]  deactivate_locked_super+0x2f/0xa0
>>>> [  172.931559]  cleanup_mnt+0xee/0x180
>>>> [  172.935051]  task_work_run+0x5c/0x90
>>>> [  172.938629]  exit_to_user_mode_prepare+0x229/0x230
>>>> [  172.943424]  syscall_exit_to_user_mode+0x18/0x40
>>>> [  172.948043]  do_syscall_64+0x46/0x80
>>>> [  172.951623]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>> [  172.956675] RIP: 0033:0x7f442c75126b
>>>> [  172.960271] Code: cb 1b 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 90 f3
>>>> 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00
>>>> 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 91 1b 0e 00
>>>> f7 d8
>>>> [  172.979017] RSP: 002b:00007ffc82d66fe8 EFLAGS: 00000202 ORIG_RAX:
>>>> 00000000000000a6
>>>> [  172.986584] RAX: 0000000000000000 RBX: 000055bd4cc37090 RCX: 00007f442c75126b
>>>> [  172.993715] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 000055bd4cc3b950
>>>> [  173.000849] RBP: 000055bd4cc371a8 R08: 0000000000000000 R09: 0000000000000073
>>>> [  173.007980] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000001
>>>> [  173.015115] R13: 000055bd4cc3b950 R14: 000055bd4cc372c0 R15: 000055bd4cc37090
>>>> [  173.022249]  </TASK>
>>>> [  173.024440] Modules linked in: rfkill intel_rapl_msr
>>>> intel_rapl_common isst_if_common irdma skx_edac nfit libnvdimm ice
>>>> x86_pkg_temp_thermal intel_powerclamp coretemp ib_uverbs iTCO_wdt
>>>> intel_pmc_bxt ib_core iTCO_vendor_support kvm_
>>>> intel ipmi_ssif kvm irqbypass rapl acpi_ipmi intel_cstate i40e joydev
>>>> mei_me ioatdma i2c_i801 intel_uncore lpc_ich i2c_smbus mei
>>>> intel_pch_thermal dca ipmi_si ipmi_devintf ipmi_msghandler acpi_pad
>>>> acpi_power_meter fuse zram xfs crct10d
>>>> if_pclmul ast crc32_pclmul crc32c_intel drm_vram_helper drm_ttm_helper
>>>> ttm wmi ghash_clmulni_intel
>>>> [  173.073900] CR2: 0000000000000008
>>>>
>>>
>>> --
>>> Additional information about regzbot:
>>>
>>> If you want to know more about regzbot, check out its web-interface, the
>>> getting start guide, and the references documentation:
>>>
>>> https://linux-regtracking.leemhuis.info/regzbot/
>>> https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
>>> https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md
>>>
>>> The last two documents will explain how you can interact with regzbot
>>> yourself if your want to.
>>>
>>> Hint for reporters: when reporting a regression it's in your interest to
>>> CC the regression list and tell regzbot about the issue, as that ensures
>>> the regression makes it onto the radar of the Linux kernel's regression
>>> tracker -- that's in your interest, as it ensures your report won't fall
>>> through the cracks unnoticed.
>>>
>>> Hint for developers: you normally don't need to care about regzbot once
>>> it's involved. Fix the issue as you normally would, just remember to
>>> include 'Link:' tag in the patch descriptions pointing to all reports
>>> about the issue. This has been expected from developers even before
>>> regzbot showed up for reasons explained in
>>> 'Documentation/process/submitting-patches.rst' and
>>> 'Documentation/process/5.Posting.rst'.
>>>
>>
>>
>> --
>> -Jirka
> 
> 
> 
