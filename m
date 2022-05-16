Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304E0527DDD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240525AbiEPGwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240651AbiEPGvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:51:17 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB601113A
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:51:15 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2fee010f509so26149317b3.11
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=WtJcp6p7F7Zx5ASUnudcGO+8dHaIwXHyfKly8cDbuMA=;
        b=oB2Ym7tGmxL3Mlm+Wc1BXaW8WLPTji+h+AaKCmX2oOE1nEnLZi9o83zPuBaDTSladG
         LC7dVQHIRm5V1RDgF9NS0qR3UaEUy9kvm6P0jx1CDCs4WE1Ev2BPY88pTRgqM/xDn8KN
         EeW6jdO0/EJ086wo/u53BxdRlojUD1DJVxq0J4TricFtGgMSda8uHaMOnSC4FU+1Nu+A
         vtAH/FQmLLG9MTqLaQ+QgabCdfwOFXRUhGiNSkqDbwT7JH0Ds+9W7z7KictLR52hMQ6R
         Zg97pjSruiAqRBSaqDyOYetlLuJLVC5WxbaWIvwLn2LOut6Y0y564psgFxVuFzfnsv68
         wBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=WtJcp6p7F7Zx5ASUnudcGO+8dHaIwXHyfKly8cDbuMA=;
        b=CewRs4aDd/vFgxCIL1XjvFYxm/UNjUdlA5fCXhbO/3QTblIZrtATD00n47h2X0/p4l
         tLa/l5s5/kBCbCwZEj0TEWOxjjGgJFCqGPRcFTuK04WQi5S08JmeyXjnbWJaJEM5gTPy
         cWLMAtLre0/XAPGYkrtJJ3gqi1h/BbZsL14IdIZPopdu6rBzCG4qP9DSnKqsUaLJMJgz
         SWhmxw7ITa6iV2IYT5GH7uw1apTzdUHtMz63m5Z993LXjmlYWUHDsgel6TGmM171+SWr
         7dKptnd3qVyw5MF0BiCng87tXYgOghZNvfLiTlxIKv5M0BgCl3EQlqbbk3LUDnxxmu58
         H6iw==
X-Gm-Message-State: AOAM533vVBju0O3PhZDoMA62sGVShLk3n8TdX4ftcgPWJUB53f2maxCR
        rI475Ir4Ke0Cn122DBMJ5iopYo1IbBZcRtuu63R3jg==
X-Google-Smtp-Source: ABdhPJzlok8aacHYgGi100CNNq62mWJ4OfwGkBms8SJ6eKfBCxXNgSs1LakblRxkgfX/CqfHP+t6a2ECtWrIWmBWeK0=
X-Received: by 2002:a81:2f8c:0:b0:2fe:ed42:21ca with SMTP id
 v134-20020a812f8c000000b002feed4221camr4783213ywv.120.1652683874940; Sun, 15
 May 2022 23:51:14 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 16 May 2022 12:21:04 +0530
Message-ID: <CA+G9fYtU7i356bhfGSVaZUkeqE2gE-GE0NQ1iqxJEH_u4BZjSw@mail.gmail.com>
Subject: [next ] kernel BUG at mm/mmap.c:3235! - invalid opcode: 0000 [#1]
 PREEMPT SMP NOPTI
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Yang Shi <shy828301@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Song Liu <song@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        David Howells <dhowells@redhat.com>,
        SeongJae Park <sj@kernel.org>, Will Deacon <will@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While running LTP mm tests on x86_64 the following kernel BUG was noticed
on Linux next-20220513 [1].

mmapstress01    1  TPASS  :  Test passed
mmapstress02    1  TPASS  :  Test passed
mmapstress03    0  TINFO  :  uname.machine=x86_64 kernel is 64bit
mmapstress03    1  TPASS  :  Test passed
[  666.897222] ------------[ cut here ]------------
[  666.897260] kernel BUG at mm/mmap.c:3235!
[  666.897285] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[  666.899420] CPU: 3 PID: 25230 Comm: mmapstress03 Not tainted
5.18.0-rc6-next-20220513 #1
[  666.900552] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[  666.901868] RIP: 0010:exit_mmap+0x32c/0x3a0
[  666.902542] Code: 87 78 03 00 00 00 00 00 02 0f 84 41 fe ff ff 4c
89 ff e8 37 bb fa ff f0 41 80 8f 7a 03 00 00 20 e9 2b fe ff ff e8 74
e5 e1 00 <0f> 0b 65 8b 05 b3 ab 63 55 89 c0 48 0f a3 05 39 4b f0 01 0f
83 36
[  666.905542] RSP: 0018:ffff991342abbd10 EFLAGS: 00010202
[  666.906334] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff93ea0353540c
[  666.907464] RDX: ffffffffffffffff RSI: 0000000000000000 RDI: ffff991342abbd18
[  666.908589] RBP: ffff991342abbe08 R08: 00007ffe337a6fff R09: 0000000000000009
[  666.909745] R10: ffffffffffffff00 R11: ffff991342abbd40 R12: 0000000000000058
[  666.910810] R13: ffff991342abbd18 R14: 0000000000000012 R15: ffff93ea07f8d800
[  666.911940] FS:  00007fad8494b580(0000) GS:ffff93ea3bd80000(0000)
knlGS:0000000000000000
[  666.913153] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  666.914147] CR2: 0000000000bba268 CR3: 0000000075610000 CR4: 00000000003506e0
[  666.915119] Call Trace:
[  666.915473]  <TASK>
[  666.915805]  __mmput+0x47/0x100
[  666.916280]  mmput+0x20/0x30
[  666.916677]  exit_mm+0xe7/0x150
[  666.917116]  do_exit+0x1c5/0xa40
[  666.917566]  ? __audit_syscall_entry+0x109/0x130
[  666.918220]  do_group_exit+0x54/0xb0
[  666.918708]  __do_sys_exit_group+0xf/0x10
[  666.919249]  __se_sys_exit_group+0xe/0x10
[  666.919790]  __x64_sys_exit_group+0x12/0x20
[  666.920356]  do_syscall_64+0x35/0x60
[  666.920876]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  666.921561] RIP: 0033:0x7fad842c1846
[  666.922095] Code: Unable to access opcode bytes at RIP 0x7fad842c181c.
[  666.922959] RSP: 002b:00007ffe336ad8b8 EFLAGS: 00000246 ORIG_RAX:
00000000000000e7
[  666.923954] RAX: ffffffffffffffda RBX: 00007fad845a9740 RCX: 00007fad842c1846
[  666.924895] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
[  666.925846] RBP: 0000000000000000 R08: 00000000000000e7 R09: ffffffffffffff80
[  666.926779] R10: 0000000000000002 R11: 0000000000000246 R12: 00007fad845a9740
[  666.927711] R13: 0000000000000001 R14: 00007fad845b2628 R15: 0000000000000000
[  666.928671]  </TASK>
[  666.928976] Modules linked in:
[  666.929491] ---[ end trace 0000000000000000 ]---
[  666.929502] RIP: 0010:exit_mmap+0x32c/0x3a0
[  666.929508] Code: 87 78 03 00 00 00 00 00 02 0f 84 41 fe ff ff 4c
89 ff e8 37 bb fa ff f0 41 80 8f 7a 03 00 00 20 e9 2b fe ff ff e8 74
e5 e1 00 <0f> 0b 65 8b 05 b3 ab 63 55 89 c0 48 0f a3 05 39 4b f0 01 0f
83 36
[  666.929511] RSP: 0018:ffff991342abbd10 EFLAGS: 00010202
[  666.929513] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff93ea0353540c
[  666.929516] RDX: ffffffffffffffff RSI: 0000000000000000 RDI: ffff991342abbd18
[  666.929518] RBP: ffff991342abbe08 R08: 00007ffe337a6fff R09: 0000000000000009
[  666.929520] R10: ffffffffffffff00 R11: ffff991342abbd40 R12: 0000000000000058
[  666.929522] R13: ffff991342abbd18 R14: 0000000000000012 R15: ffff93ea07f8d800
[  666.929527] FS:  00007fad8494b580(0000) GS:ffff93ea3bd80000(0000)
knlGS:0000000000000000
[  666.929531] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  666.929535] CR2: 0000000000bba268 CR3: 0000000075610000 CR4: 00000000003506e0
[  666.929540] Fixing recursive fault but reboot is needed!
[  666.929544] BUG: using smp_processor_id() in preemptible [00000000]
code: mmapstress03/25230
[  666.929562] caller is debug_smp_processor_id+0x17/0x20
[  666.929575] CPU: 3 PID: 25230 Comm: mmapstress03 Tainted: G      D
         5.18.0-rc6-next-20220513 #1
[  666.929580] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[  666.929582] Call Trace:
[  666.929584]  <TASK>
[  666.929586]  dump_stack_lvl+0x6c/0x9a
[  666.929590]  dump_stack+0x10/0x12
[  666.929594]  check_preemption_disabled+0x10f/0x120
[  666.929606]  debug_smp_processor_id+0x17/0x20
[  666.929609]  __schedule+0x36/0x600
[  666.929618]  ? trace_preempt_on+0x31/0x40
[  666.929634]  do_task_dead+0x41/0x50
[  666.929661]  make_task_dead+0xd3/0xe0
[  666.929664]  rewind_stack_and_make_dead+0x17/0x18
[  666.929702] RIP: 0033:0x7fad842c1846
[  666.929705] Code: Unable to access opcode bytes at RIP 0x7fad842c181c.
[  666.929706] RSP: 002b:00007ffe336ad8b8 EFLAGS: 00000246 ORIG_RAX:
00000000000000e7
[  666.929709] RAX: ffffffffffffffda RBX: 00007fad845a9740 RCX: 00007fad842c1846
[  666.929710] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
[  666.929711] RBP: 0000000000000000 R08: 00000000000000e7 R09: ffffffffffffff80
[  666.929712] R10: 0000000000000002 R11: 0000000000000246 R12: 00007fad845a9740
[  666.929714] R13: 0000000000000001 R14: 00007fad845b2628 R15: 0000000000000000
[  666.929717]  </TASK>
[  666.929718] BUG: scheduling while atomic: mmapstress03/25230/0x00000000
[  666.929721] Modules linked in:
[  666.929722] Preemption disabled at:
[  666.929728] [<ffffffffaa82a574>] do_task_dead+0x24/0x50
[  666.929733] CPU: 3 PID: 25230 Comm: mmapstress03 Tainted: G      D
         5.18.0-rc6-next-20220513 #1
[  666.929736] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[  666.929738] Call Trace:
[  666.929739]  <TASK>
[  666.929739]  dump_stack_lvl+0x6c/0x9a
[  666.929743]  ? do_task_dead+0x24/0x50
[  666.929747]  dump_stack+0x10/0x12
[  666.929750]  __schedule_bug+0xd2/0x100
[  666.929753]  __schedule+0x471/0x600
[  666.929756]  ? trace_preempt_on+0x31/0x40
[  666.929759]  do_task_dead+0x41/0x50
[  666.929763]  make_task_dead+0xd3/0xe0
[  666.929766]  rewind_stack_and_make_dead+0x17/0x18
[  666.929768] RIP: 0033:0x7fad842c1846
[  666.929771] Code: Unable to access opcode bytes at RIP 0x7fad842c181c.
[  666.929772] RSP: 002b:00007ffe336ad8b8 EFLAGS: 00000246 ORIG_RAX:
00000000000000e7
[  666.929774] RAX: ffffffffffffffda RBX: 00007fad845a9740 RCX: 00007fad842c1846
[  666.929775] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
[  666.929777] RBP: 0000000000000000 R08: 00000000000000e7 R09: ffffffffffffff80
[  666.929778] R10: 0000000000000002 R11: 0000000000000246 R12: 00007fad845a9740
[  666.929779] R13: 0000000000000001 R14: 00007fad845b2628 R15:
0000000000000000Running with 50*40 (== 2000) tasks.


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


metadata:
  git_ref: master
  git_repo: ''
  git_sha: 1e1b28b936aed946122b4e0991e7144fdbbfd77e
  git_describe: next-20220513
  kernel_version: 5.18.0-rc6
  kernel-config: https://builds.tuxbuild.com/296PqKcUcCQSykZbASUqmdlP33g/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/538244935
  artifact-location: https://builds.tuxbuild.com/296PqKcUcCQSykZbASUqmdlP33g
  toolchain: clang-12

--
Linaro LKFT
https://lkft.linaro.org

[1] https://lkft.validation.linaro.org/scheduler/job/5021584#L2916
