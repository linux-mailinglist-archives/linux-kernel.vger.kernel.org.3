Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191DE55D2A2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344144AbiF1JVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiF1JVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:21:16 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64411D312
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:21:14 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id z12so9160745qki.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Mzpx3QzXJvkWb9M2SJqsk6tjkqxL3O8tOsOJwMUq1qM=;
        b=dJW+4NeV1ifEBs/083dbjqA1ia3DFeB7p24IgRIuVx8hDsYe8/THy64z9C5APfN+8h
         PO/HZGie5hJuYyyYbgTMfOEelvKwJ09rRg/lqd2f0uMsE1spVz9O0RLFc8eBKO5nB4Fq
         erHRboIXIFCeP2hNkaHLPWyuDsIy5JsG3zYm0KABMmZyRRgOapNeeI0V+7X9ZAL0IJMY
         rnaE2WvC9YiedYGEJsJXbw0xPHgL8JG8D9md7cvjjJXeIstfyJj/jzageX8l50XzZHmU
         nwCebYkQLtqSLkI7itRayzDwzKH6fYY4FX/DIEuIwR3tOz13v55lVDxZRAQJrxZBF0dW
         1ygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Mzpx3QzXJvkWb9M2SJqsk6tjkqxL3O8tOsOJwMUq1qM=;
        b=Pbrw5FJBsZuVGVG/GPqhU9FA7HgjUsz0bXM8tk8zbka8DM6p4OjRBzy42ho/8nO4jV
         LNYJdD75SwrohRieltX7r9TBO8Mi8ec2DpY/IIJ+5iaYN5YohvKjJtyUyi8b0aKkeJRV
         4I9nyThZ9DuyMQnkZ+1PAMPmnBR/GIOTPHYpyhcR6AkXb3I1NAXEq39DEEe8STeX8gUo
         LFLu6ykNa17CvupRYJUa29TgnT/UKgKj4WY2DxUQmrOeNBhxbGh0EqGkni9YVzQe6dzM
         FlUb4YchsxVhU4gnvh06uA6w1wOMxuDio9Dafk89WddkNG8BawxkjWv6cn2G3MSFt6kL
         Ng5w==
X-Gm-Message-State: AJIora/UG8VCeHrhU1OPDcPnO455NDURh/8LyxY2F0DJp1Xx08cuT/lW
        AM7a669S6ENhnA/FDM7V6j8/bUv+YMvNt2knYtgNBcGkpKBZ5Lzyux4=
X-Google-Smtp-Source: AGRyM1sejJE81L1Xd/tnXw3a1Dx+lawkY2HmVDy013Emgq6fTfmstOhNvg2jeWEMQzWF3xOfHruH9bdgZfEjfzSZxC4=
X-Received: by 2002:a05:620a:f0f:b0:6a9:711b:da07 with SMTP id
 v15-20020a05620a0f0f00b006a9711bda07mr10432271qkl.282.1656408073512; Tue, 28
 Jun 2022 02:21:13 -0700 (PDT)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Tue, 28 Jun 2022 14:21:02 +0500
Message-ID: <CABXGCsP920dX-gFOHjk0Xo-yTaQfoFwP7YT2VsG1=b9X6kYhHg@mail.gmail.com>
Subject: [Bug][5.19-rc0] Between commits fdaf9a5840ac and babf0bb978e3 GPU
 stopped entering in graphic mode.
To:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HOSTED_IMG_FREEM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys.
Between commits fdaf9a5840ac and babf0bb978e3 GPU stopped entering in
graphic mode instead I see black screen with constantly glowing
cursor. Demonstration: https://youtu.be/rGL4LsHMae4
In the kernel logs there are references to hung processes:
[  149.363465] rfkill: input handler disabled
[  249.072478] INFO: task (brt-dbus):1645 blocked for more than 122 seconds.
[  249.072515]       Tainted: G        W    L   --------  ---
5.19.0-0.rc0.20220526gitbabf0bb978e3.4.fc37.x86_64 #1
[  249.072520] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  249.072524] task:(brt-dbus)      state:D stack:14384 pid: 1645
ppid:     1 flags:0x00000002
[  249.072536] Call Trace:
[  249.072540]  <TASK>
[  249.072551]  __schedule+0x492/0x1640
[  249.072560]  ? lock_is_held_type+0xe8/0x140
[  249.072569]  ? find_held_lock+0x32/0x80
[  249.072584]  schedule+0x4e/0xb0
[  249.072591]  schedule_preempt_disabled+0x14/0x20
[  249.072597]  __mutex_lock+0x423/0x890
[  249.072608]  ? amdgpu_ctx_mgr_entity_flush+0x32/0xc0 [amdgpu]
[  249.072818]  ? amdgpu_ctx_mgr_entity_flush+0x32/0xc0 [amdgpu]
[  249.073010]  amdgpu_ctx_mgr_entity_flush+0x32/0xc0 [amdgpu]
[  249.073207]  amdgpu_flush+0x25/0x40 [amdgpu]
[  249.074088]  filp_close+0x31/0x70
[  249.074097]  __close_range+0x130/0x320
[  249.074108]  __x64_sys_close_range+0x13/0x20
[  249.074113]  do_syscall_64+0x5b/0x80
[  249.074120]  ? lockdep_hardirqs_on+0x7d/0x100
[  249.074127]  ? do_syscall_64+0x67/0x80
[  249.074135]  ? do_syscall_64+0x67/0x80
[  249.074140]  ? lockdep_hardirqs_on+0x7d/0x100
[  249.074147]  ? do_syscall_64+0x67/0x80
[  249.074154]  ? lock_is_held_type+0xe8/0x140
[  249.074164]  ? asm_exc_page_fault+0x27/0x30
[  249.074171]  ? lockdep_hardirqs_on+0x7d/0x100
[  249.074178]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  249.074184] RIP: 0033:0x7fd71f54f97b
[  249.074208] RSP: 002b:00007fffc8e752a8 EFLAGS: 00000246 ORIG_RAX:
00000000000001b4
[  249.074215] RAX: ffffffffffffffda RBX: 00007fffc8e752b0 RCX: 00007fd71f54f97b
[  249.074220] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000027
[  249.074224] RBP: 00007fffc8e75330 R08: 0000000000000000 R09: 00007fffc8e75380
[  249.074228] R10: 00007fffc8e751f0 R11: 0000000000000246 R12: 0000000000000002
[  249.074232] R13: 00007fffc8e75340 R14: 0000000000000000 R15: 0000000000000002
[  249.074252]  </TASK>
[  249.074261] INFO: task (ostnamed):1718 blocked for more than 122 seconds.
[  249.074266]       Tainted: G        W    L   --------  ---
5.19.0-0.rc0.20220526gitbabf0bb978e3.4.fc37.x86_64 #1
[  249.074285] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  249.074289] task:(ostnamed)      state:D stack:14552 pid: 1718
ppid:     1 flags:0x00000006
[  249.074299] Call Trace:
[  249.074302]  <TASK>
[  249.074310]  __schedule+0x492/0x1640
[  249.074316]  ? lock_is_held_type+0xe8/0x140
[  249.074324]  ? find_held_lock+0x32/0x80
[  249.074339]  schedule+0x4e/0xb0
[  249.074346]  schedule_preempt_disabled+0x14/0x20
[  249.074352]  __mutex_lock+0x423/0x890
[  249.074361]  ? amdgpu_ctx_mgr_entity_flush+0x32/0xc0 [amdgpu]
[  249.074564]  ? amdgpu_ctx_mgr_entity_flush+0x32/0xc0 [amdgpu]
[  249.074754]  amdgpu_ctx_mgr_entity_flush+0x32/0xc0 [amdgpu]
[  249.074950]  amdgpu_flush+0x25/0x40 [amdgpu]
[  249.075133]  filp_close+0x31/0x70
[  249.075140]  __close_range+0x130/0x320
[  249.075150]  __x64_sys_close_range+0x13/0x20
[  249.075154]  do_syscall_64+0x5b/0x80
[  249.075164]  ? lock_is_held_type+0xe8/0x140
[  249.075175]  ? do_syscall_64+0x67/0x80
[  249.075180]  ? lockdep_hardirqs_on+0x7d/0x100
[  249.075187]  ? do_syscall_64+0x67/0x80
[  249.075194]  ? lock_is_held_type+0xe8/0x140
[  249.075204]  ? asm_exc_page_fault+0x27/0x30
[  249.075210]  ? lockdep_hardirqs_on+0x7d/0x100
[  249.075217]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  249.075222] RIP: 0033:0x7fd71f54f97b
[  249.075231] RSP: 002b:00007fffc8e752a8 EFLAGS: 00000246 ORIG_RAX:
00000000000001b4
[  249.075237] RAX: ffffffffffffffda RBX: 00007fffc8e752b0 RCX: 00007fd71f54f97b
[  249.075241] RDX: 0000000000000000 RSI: 00000000000000b9 RDI: 0000000000000027
[  249.075245] RBP: 00007fffc8e75330 R08: 0000000000000000 R09: 00007fffc8e75380
[  249.075249] R10: 00007fffc8e751f0 R11: 0000000000000246 R12: 0000000000000004
[  249.075253] R13: 00007fffc8e75340 R14: 0000000000000000 R15: 0000000000000003
[  249.075289]  </TASK>
[  249.075294] INFO: task (pcscd):1749 blocked for more than 122 seconds.
[  249.075298]       Tainted: G        W    L   --------  ---
5.19.0-0.rc0.20220526gitbabf0bb978e3.4.fc37.x86_64 #1
[  249.075302] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  249.075306] task:(pcscd)         state:D stack:14256 pid: 1749
ppid:     1 flags:0x00000002
[  249.075314] Call Trace:
[  249.075318]  <TASK>
[  249.075325]  __schedule+0x492/0x1640
[  249.075331]  ? lock_is_held_type+0xe8/0x140
[  249.075339]  ? find_held_lock+0x32/0x80
[  249.075353]  schedule+0x4e/0xb0
[  249.075360]  schedule_preempt_disabled+0x14/0x20
[  249.075365]  __mutex_lock+0x423/0x890
[  249.075375]  ? amdgpu_ctx_mgr_entity_flush+0x32/0xc0 [amdgpu]
[  249.075574]  ? amdgpu_ctx_mgr_entity_flush+0x32/0xc0 [amdgpu]
[  249.075764]  amdgpu_ctx_mgr_entity_flush+0x32/0xc0 [amdgpu]
[  249.075960]  amdgpu_flush+0x25/0x40 [amdgpu]
[  249.076143]  filp_close+0x31/0x70
[  249.076150]  __close_range+0x130/0x320
[  249.076160]  __x64_sys_close_range+0x13/0x20
[  249.076164]  do_syscall_64+0x5b/0x80
[  249.076169]  ? do_syscall_64+0x67/0x80
[  249.076175]  ? lockdep_hardirqs_on+0x7d/0x100
[  249.076182]  ? do_syscall_64+0x67/0x80
[  249.076188]  ? do_syscall_64+0x67/0x80
[  249.076194]  ? lockdep_hardirqs_on+0x7d/0x100
[  249.076201]  ? do_syscall_64+0x67/0x80
[  249.076206]  ? do_syscall_64+0x67/0x80
[  249.076211]  ? lockdep_hardirqs_on+0x7d/0x100
[  249.076218]  ? do_syscall_64+0x67/0x80
[  249.076223]  ? lock_is_held_type+0xe8/0x140
[  249.076233]  ? asm_exc_page_fault+0x27/0x30
[  249.076239]  ? lockdep_hardirqs_on+0x7d/0x100
[  249.076246]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  249.076251] RIP: 0033:0x7fd71f54f97b
[  249.076259] RSP: 002b:00007fffc8e752a8 EFLAGS: 00000246 ORIG_RAX:
00000000000001b4
[  249.076265] RAX: ffffffffffffffda RBX: 00007fffc8e752b0 RCX: 00007fd71f54f97b
[  249.076287] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 000000000000004c
[  249.076291] RBP: 00007fffc8e75330 R08: 0000000000000000 R09: 00007fffc8e75380
[  249.076295] R10: 00007fffc8e751f0 R11: 0000000000000246 R12: 0000000000000003
[  249.076300] R13: 00007fffc8e75340 R14: 0000000000000000 R15: 0000000000000003
[  249.076319]  </TASK>
[  249.076323]
               Showing all locks held in the system:
[  249.076335] 1 lock held by khungtaskd/183:
[  249.076340]  #0: ffffffff84169060 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x15/0x16b
[  249.076364] 3 locks held by systemd-journal/868:
[  249.076376] 3 locks held by gnome-shell/1626:
[  249.076380]  #0: ffff9f2b248e4680
(&sig->cred_guard_mutex){+.+.}-{3:3}, at: bprm_execve+0x3c/0x880
[  249.076394]  #1: ffff9f2b248e4728
(&sig->exec_update_lock){++++}-{3:3}, at: begin_new_exec+0x384/0xcc0
[  249.076407]  #2: ffff9f2b3a95ec58 (&mgr->lock#3){+.+.}-{3:3}, at:
amdgpu_ctx_mgr_entity_flush+0x32/0xc0 [amdgpu]
[  249.076609] 1 lock held by (brt-dbus)/1645:
[  249.076613]  #0: ffff9f2b3a95ec58 (&mgr->lock#3){+.+.}-{3:3}, at:
amdgpu_ctx_mgr_entity_flush+0x32/0xc0 [amdgpu]
[  249.076814] 1 lock held by (ostnamed)/1718:
[  249.076818]  #0: ffff9f2b3a95ec58 (&mgr->lock#3){+.+.}-{3:3}, at:
amdgpu_ctx_mgr_entity_flush+0x32/0xc0 [amdgpu]
[  249.077018] 1 lock held by (pcscd)/1749:
[  249.077022]  #0: ffff9f2b3a95ec58 (&mgr->lock#3){+.+.}-{3:3}, at:
amdgpu_ctx_mgr_entity_flush+0x32/0xc0 [amdgpu]

[  249.077226] =============================================

[  335.093113] kworker/dying (297) used greatest stack depth: 11608 bytes left
[  335.093254] kworker/dying (241) used greatest stack depth: 11360 bytes left
Full kernel log is here: https://pastebin.com/0YHs6wyB

Naturally, I tried to find the problematic commit via git bisect. It
was the longest bisect in my life, I needed to collect the core 565
times and it took three weeks. This is what explains why I am writing
only now, and not immediately. The most annoying thing is that it
looks like I wasted three weeks because the exact commit was never
found. My bisect log can be found here: https://pastebin.com/AhLMNfyv

If you open it you will see a lot of skip steps. This is due to the
fact that in these steps I observe a problem when loading the kernel
hangs on the messages on screen:
[drm] amdgpu kernel modesetting enabled.
amdgpu: Ignoring ACPI CRAT on non-APU system
amdgpu: Virtual CRAT table created for CPU
amdgpu: Topology: Add CPU node
Here is photo of boot screen:
https://i.postimg.cc/DwVbYP4b/IMG-20220525-130140.jpg

And the following trace is written to the log:
[    8.173558] [drm] amdgpu kernel modesetting enabled.
[    8.196766] amdgpu: Ignoring ACPI CRAT on non-APU system
[    8.196846] amdgpu: Virtual CRAT table created for CPU
[    8.197015] amdgpu: Topology: Add CPU node
[    8.201791] Console: switching to colour dummy device 80x25
[    8.215200] page:00000000b17305fd refcount:0 mapcount:0
mapping:0000000000000000 index:0x0 pfn:0x1029c00
[    8.215224] head:00000000b17305fd order:0 compound_mapcount:-6459
compound_pincount:0
[    8.215243] flags: 0x17ffffc0010000(head|node=0|zone=2|lastcpupid=0x1fffff)
[    8.215261] raw: 0017ffffc0010000 ffffe6c480a70008 ffffe6c480a70008
0000000000000000
[    8.215279] raw: 0000000000000000 0000000000000000 00000000ffffffff
0000000000000000
[    8.215296] page dumped because: VM_BUG_ON_PAGE(compound &&
compound_order(page) != order)
[    8.215324] ------------[ cut here ]------------
[    8.215340] kernel BUG at mm/page_alloc.c:1329!
[    8.215358] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[    8.215363] CPU: 20 PID: 584 Comm: systemd-udevd Tainted: G
W         5.18.0-rc1-004-c6ed9f66eb70aeaac9998bd3552ada740d90e20c+
#357
[    8.215370] Hardware name: System manufacturer System Product
Name/ROG STRIX X570-I GAMING, BIOS 4403 04/27/2022
[    8.215375] RIP: 0010:free_pcp_prepare+0x455/0x650
[    8.215381] Code: ff ff 48 8b 43 48 a8 01 0f 84 48 ff ff ff 48 83
e8 01 48 39 c3 0f 84 3b ff ff ff 48 c7 c6 08 f0 85 aa 48 89 df e8 5b
cb fc ff <0f> 0b 4c 89 ef 48 89 14 24 41 83 c6 01 e8 b9 ed ff ff 48 8b
14 24
[    8.215390] RSP: 0018:ffffbb7dc23779d8 EFLAGS: 00010296
[    8.215394] RAX: 000000000000004e RBX: ffffe6c480a70000 RCX: 0000000000000000
[    8.215399] RDX: 0000000000000001 RSI: ffffffffaa89db77 RDI: 00000000ffffffff
[    8.215402] RBP: 0000000000000009 R08: 0000000000000000 R09: ffffbb7dc23777c0
[    8.215406] R10: 0000000000000003 R11: ffffa08bae1fefe8 R12: 0000000000000000
[    8.215410] R13: ffffa07c817eadc0 R14: 00000000fffffe00 R15: ffffe6c480a70000
[    8.215414] FS:  00007f35b2f1ab40(0000) GS:ffffa08b5d200000(0000)
knlGS:0000000000000000
[    8.215419] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.215422] CR2: 00005631caec1878 CR3: 000000017d09c000 CR4: 0000000000350ee0
[    8.215427] Call Trace:
[    8.215429]  <TASK>
[    8.215431]  ? find_held_lock+0x32/0x80
[    8.215436]  free_unref_page+0x25/0x280
[    8.215440]  __vunmap+0x261/0x3d0
[    8.215444]  drm_fbdev_cleanup+0x6b/0xc0
[    8.215449]  drm_fbdev_fb_destroy+0x15/0x30
[    8.215453]  unregister_framebuffer+0x2e/0x40
[    8.215458]  drm_client_dev_unregister+0x6e/0xe0
[    8.215464]  drm_dev_unregister+0x34/0x90
[    8.215467]  drm_dev_unplug+0x24/0x40
[    8.215471]  simpledrm_remove+0x11/0x20
[    8.215475]  platform_remove+0x1f/0x40
[    8.215479]  device_release_driver_internal+0x1b8/0x220
[    8.215484]  bus_remove_device+0xef/0x160
[    8.215488]  device_del+0x18c/0x3f0
[    8.215492]  platform_device_del.part.0+0x13/0x70
[    8.215496]  platform_device_unregister+0x1c/0x30
[    8.215500]  drm_aperture_detach_drivers+0xa3/0xd0
[    8.215505]  drm_aperture_remove_conflicting_pci_framebuffers+0x3f/0x70
[    8.215511]  amdgpu_pci_probe+0x126/0x3c0 [amdgpu]
[    8.215672]  local_pci_probe+0x41/0x80
[    8.215677]  pci_device_probe+0xaa/0x200
[    8.215681]  really_probe+0x1a0/0x370
[    8.215685]  __driver_probe_device+0xfb/0x170
[    8.215689]  driver_probe_device+0x1f/0x90
[    8.215693]  __driver_attach+0xbe/0x1a0
[    8.215697]  ? __device_attach_driver+0xe0/0xe0
[    8.215701]  bus_for_each_dev+0x65/0x90
[    8.215705]  bus_add_driver+0x150/0x1f0
[    8.215709]  driver_register+0x89/0xd0
[    8.215713]  ? 0xffffffffc044e000
[    8.215719]  do_one_initcall+0x69/0x350
[    8.215724]  ? do_init_module+0x22/0x260
[    8.215728]  ? rcu_read_lock_sched_held+0x3b/0x70
[    8.215732]  ? trace_kmalloc+0x3b/0x100
[    8.215737]  ? kmem_cache_alloc_trace+0x1eb/0x3a0
[    8.215742]  do_init_module+0x4a/0x260
[    8.215745]  __do_sys_finit_module+0x93/0xf0
[    8.215751]  do_syscall_64+0x3a/0x80
[    8.215756]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[    8.215761] RIP: 0033:0x7f35b3acb62d
[    8.215765] Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e
fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c3 c7 0c 00 f7 d8 64 89
01 48
[    8.215773] RSP: 002b:00007ffc39f6ef68 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[    8.215778] RAX: ffffffffffffffda RBX: 00005631cae55830 RCX: 00007f35b3acb62d
[    8.215782] RDX: 0000000000000000 RSI: 00005631cae6ceb0 RDI: 0000000000000011
[    8.215786] RBP: 00005631cae6ceb0 R08: 0000000000000000 R09: 00007f35b3b98c80
[    8.215790] R10: 0000000000000011 R11: 0000000000000246 R12: 0000000000020000
[    8.215794] R13: 00005631cae74660 R14: 0000000000000000 R15: 00005631cae805d0
[    8.215800]  </TASK>
[    8.215801] Modules linked in: amdgpu(+) drm_ttm_helper ttm
crct10dif_pclmul crc32_pclmul iommu_v2 crc32c_intel gpu_sched ucsi_ccg
nvme drm_buddy typec_ucsi ghash_clmulni_intel igb ccp drm_dp_helper
typec sp5100_tco nvme_core dca wmi ip6_tables ip_tables ipmi_devintf
ipmi_msghandler fuse
[    8.215825] ---[ end trace 0000000000000000 ]---
[    8.215828] RIP: 0010:free_pcp_prepare+0x455/0x650
[    8.215832] Code: ff ff 48 8b 43 48 a8 01 0f 84 48 ff ff ff 48 83
e8 01 48 39 c3 0f 84 3b ff ff ff 48 c7 c6 08 f0 85 aa 48 89 df e8 5b
cb fc ff <0f> 0b 4c 89 ef 48 89 14 24 41 83 c6 01 e8 b9 ed ff ff 48 8b
14 24
[    8.215841] RSP: 0018:ffffbb7dc23779d8 EFLAGS: 00010296
[    8.215844] RAX: 000000000000004e RBX: ffffe6c480a70000 RCX: 0000000000000000
[    8.215848] RDX: 0000000000000001 RSI: ffffffffaa89db77 RDI: 00000000ffffffff
[    8.215852] RBP: 0000000000000009 R08: 0000000000000000 R09: ffffbb7dc23777c0
[    8.215856] R10: 0000000000000003 R11: ffffa08bae1fefe8 R12: 0000000000000000
[    8.215860] R13: ffffa07c817eadc0 R14: 00000000fffffe00 R15: ffffe6c480a70000
[    8.215864] FS:  00007f35b2f1ab40(0000) GS:ffffa08b5d200000(0000)
knlGS:0000000000000000
[    8.215875] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.215879] CR2: 00005631caec1878 CR3: 000000017d09c000 CR4: 0000000000350ee0
[    8.216344] systemd-udevd (584) used greatest stack depth: 12776 bytes left
Full kernel log is here: https://pastebin.com/rDAjKpSg

Please help me get rid of the bug that crashes systemd-udevd so I can
find the exact commit that caused the GPU hang.

Or, based on the trace of the hung process, help fix the problem.

Thank you all in advance.

UPD:
I am still observing the issue rc1-rc4 :(

My hardware specs:
GPU: 6900XT
CPU: 3950X
M/B: ROG Strix X570-I Gaming
RAM: 64GB
SSD: Intel Optane 905P


-- 
Best Regards,
Mike Gavrilov.
