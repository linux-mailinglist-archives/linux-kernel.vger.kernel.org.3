Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FC6527DAB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240325AbiEPGfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240312AbiEPGfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:35:06 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622342DAAC
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:35:05 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2fb965b34easo142022977b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=iR9aLyTCUrCQTmGQIq1Vjzn6XchFor3q3vBzEcA+Dwo=;
        b=M5o3yifV/slzgFkpgWrzXE9fAPU/VJSxh1jDp0BmdMwrGB3oG/o3ATfop+5rsa9bDq
         PGNUxC7MyRtlLJjvL7y1LX4b9SxyCj01wvoeDh7jZgWdqdazeLKgYy7tQU7jnTmFgjAr
         iU3qKTzIKhiAc7SGSp3wvns1FptUuEkL9C/9dxjJIpOedcvS38mSVDjQ3cBWIJYbupU/
         PFCVO1lfTGC0w61UOiLb1VIuPdRjywt9IwDlIHempEeRtc6CJbYotuHxuJxAvWcM/2NK
         ktUJNWj9BxKKl6wOeVnZQzUb5vaGeJRoLfKKyALoXrp/6nSeXDhBbOSlwYLZr1luhNLV
         7gWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=iR9aLyTCUrCQTmGQIq1Vjzn6XchFor3q3vBzEcA+Dwo=;
        b=L9Dq3Hk+zZQ8eEVI1XGGC8HgJWOpHeN3Fwk00k3uOC137h4NohJoECl1yc40V9qgAg
         UZQxFEXvR2GaEUx1THxEnw6zJV6UIk3yekXypdyCyaODZmvGei0O6hK9JM14FrzcbGra
         XVPCZDYc90UjHV0pO7ACXiCBtgzkuBWZ3WXuG44w3Pu0ZfjQmIBIlz9TRqtFwt1XQ2Rh
         Hxn56CqZDbLinLIyt7Zn80B2AOUQXASDi2X1Kl82xryTG86V3WAR6rXmNXjbZ2UKwZZK
         0SIbpg/9mzGkbDws/O8Ew7R0N1aGE+j0wXqlxW3X9Bk9YL2Iuheqtm5MKRXvJx7B9DPg
         9DTg==
X-Gm-Message-State: AOAM5306sXAmJTGihr7zaTopBRplgKVW6DvPB4AhY4pBwuqjDVrsBVhL
        kIwqkKou8OhbrQjDDxb1Zx6FhMbhAw5NONOAc8hBzznNvMc6zQ==
X-Google-Smtp-Source: ABdhPJzqvgg34QoFkC3e7GY8miDyWhpODxkBdYQD8rxFuXcOsJtoGO8d9h7uSkJ6pO7KHiMVJlz2ZNTrtpulrAi84x8=
X-Received: by 2002:a81:478b:0:b0:2ea:da8c:5c21 with SMTP id
 u133-20020a81478b000000b002eada8c5c21mr18734148ywa.189.1652682903905; Sun, 15
 May 2022 23:35:03 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 16 May 2022 12:04:53 +0530
Message-ID: <CA+G9fYuOHwkkqTdcqGa7kazBwCOF-P0Kw0gthvAzjU0t5EVSAQ@mail.gmail.com>
Subject: BUG: kernel NULL pointer dereference, address: 00000004 - mas_update_gap
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While running LTP sched tests on i386 the following kernel BUG noticed on
Linux next-20220513 [1].

Running with 50*40 (== 2000) tasks.
Time: 7.618
Running with 20*40 (== 800) tasks.
[   75.590440] BUG: kernel NULL pointer dereference, address: 00000004
[   75.596710] #PF: supervisor read access in kernel mode
[   75.601842] #PF: error_code(0x0000) - not-present page
[   75.606979] *pde = 00000000
[   75.609858] Oops: 0000 [#1] PREEMPT SMP
[   75.613697] CPU: 1 PID: 2694 Comm: hackbench Not tainted
5.18.0-rc6-next-20220513 #1
[   75.621427] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[   75.628898] EIP: mas_update_gap+0xa9/0x290
[   75.632996] Code: 02 89 4d e8 0f 84 ef 01 00 00 89 d6 8b 4d ec 8b
55 f0 81 e6 00 ff ff ff 89 75 e0 21 d1 31 d2 83 f9 06 75 06 8d 96 a8
00 00 00 <3b> 3c 82 0f 84 73 ff ff ff 83 7d e8 01 8b 4d f0 19 d2 83 e2
fc 83
[   75.651735] EAX: 00000001 EBX: e507fd2c ECX: 00000086 EDX: 00000000
[   75.657992] ESI: c6030500 EDI: 40152000 EBP: e507f8ec ESP: e507f8cc
[   75.664248] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010202
[   75.671024] CR0: 80050033 CR2: 00000004 CR3: 25e5f000 CR4: 003506d0
[   75.677283] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   75.683541] DR6: fffe0ff0 DR7: 00000400
[   75.687372] Call Trace:
[   75.689817]  mas_wr_modify+0x193/0x1c20
[   75.693665]  mas_wr_store_entry.isra.0+0x187/0x4d0
[   75.698465]  mas_store_prealloc+0x44/0xe0
[   75.702477]  vma_mas_store+0x2f/0x80
[   75.706057]  __vma_adjust+0x334/0x8e0
[   75.709724]  __split_vma+0x148/0x160
[   75.713303]  do_mas_align_munmap.constprop.0+0xd3/0x3f0
[   75.718529]  ? find_idlest_group+0xdb/0x7f0
[   75.722714]  do_mas_munmap+0x7d/0xb0
[   75.726294]  mmap_region+0x11e/0x6b0
[   75.729875]  ? selinux_msg_queue_msgctl+0xc0/0xc0
[   75.734579]  ? security_mmap_addr+0x2a/0x40
[   75.738765]  ? get_unmapped_area+0x74/0xe0
[   75.742864]  do_mmap+0x3f8/0x500
[   75.746096]  ? file_map_prot_check+0x190/0x190
[   75.750532]  vm_mmap_pgoff+0xc6/0x160
[   75.754192]  ksys_mmap_pgoff+0x50/0x200
[   75.758032]  __ia32_sys_mmap_pgoff+0x2f/0x40
[   75.762302]  __do_fast_syscall_32+0x4c/0xc0
[   75.766478]  do_fast_syscall_32+0x32/0x70
[   75.770482]  do_SYSENTER_32+0x15/0x20
[   75.774141]  entry_SYSENTER_32+0x98/0xf1
[   75.778068] EIP: 0xb7fcf549
[   75.780868] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01
10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f
34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90
8d 76
[   75.799613] EAX: ffffffda EBX: 00000000 ECX: 00005000 EDX: 00000000
[   75.805878] ESI: 00020022 EDI: ffffffff EBP: 00000000 ESP: bfeab8ec
[   75.812134] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246
[   75.818915] Modules linked in: x86_pkg_temp_thermal
[   75.823792] CR2: 0000000000000004
[   75.827104] ---[ end trace 0000000000000000 ]---
[   75.827105] EIP: mas_update_gap+0xa9/0x290
[   75.827107] Code: 02 89 4d e8 0f 84 ef 01 00 00 89 d6 8b 4d ec 8b
55 f0 81 e6 00 ff ff ff 89 75 e0 21 d1 31 d2 83 f9 06 75 06 8d 96 a8
00 00 00 <3b> 3c 82 0f 84 73 ff ff ff 83 7d e8 01 8b 4d f0 19 d2 83 e2
fc 83
[   75.827108] EAX: 00000001 EBX: e507fd2c ECX: 00000086 EDX: 00000000
[   75.827109] ESI: c6030500 EDI: 40152000 EBP: e507f8ec ESP: e507f8cc
[   75.827110] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010202
[   75.827111] CR0: 80050033 CR2: 00000004 CR3: 25e5f000 CR4: 003506d0
[   75.827111] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   75.827112] DR6: fffe0ff0 DR7: 00000400

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

metadata:
  git_ref: master
  git_repo: ''
  git_sha: 1e1b28b936aed946122b4e0991e7144fdbbfd77e
  git_describe: next-20220513
  kernel_version: 5.18.0-rc6
  kernel-config: https://builds.tuxbuild.com/296PiI1oM7N6Vk7m9lxuipmXW7B/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/538244935
  artifact-location: https://builds.tuxbuild.com/296PiI1oM7N6Vk7m9lxuipmXW7B
  toolchain: gcc-11

--
Linaro LKFT
https://lkft.linaro.org

[1] https://lkft.validation.linaro.org/scheduler/job/5021335#L1718
