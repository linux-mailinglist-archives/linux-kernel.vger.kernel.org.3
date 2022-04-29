Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F24A51488B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358669AbiD2LyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239381AbiD2LyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:54:03 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02973190B
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 04:50:45 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2ec42eae76bso82327947b3.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 04:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=8+UiF4eHlVSNXG9RvheOzUYkvX3R2QPVHBEc5if+O5U=;
        b=nU1PwT70GBM3P+Ss4d4U5e3Sy2VUJx6cjyo6IPqlWSvm2KkGN+0ndVUQXJDUMBvwHv
         3n+cKGN8J/IL3Mkr0zX0SB6R0qPKOlqgynb2D3t4JKwZmavRF7ylmpQUEUD14k3nKbVV
         YrnjN+O+DK62xWz0Cyk8Xe+tHxRAmmpdJ/wVh7zc61MipmrhByupXVs0+lz/6ANiwVCN
         efhydQzRl0jQr4IB03RBG6ncSJA+7z+dQum5A88NyA9JUHI2Dm0v0RN9z3kZYQXayn/Z
         B5MVEHhws+zD5NegoouuH27/UTIDFBiT0dJqQtbXXasVPL5KoKGrZ2GoCA8ssiAuEGzy
         9mYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8+UiF4eHlVSNXG9RvheOzUYkvX3R2QPVHBEc5if+O5U=;
        b=hLRyPPYt0x/TLqpzpI2LdlUQaarQm/k+ZGwYfYJztlmnfrQlc7//wly33pkkLx1cgA
         Lt65ECt0c0Oa2e55JgSkQzbZRRSvm0+CZi4DCqUDiFyNb21iZvSG9ffHisW32/eYZLGd
         5AVv50EyZZp8h2mln/EQ4WOqErFqMylD+Sl+Jm8zOSNbb6uyi/L4Vbl0MSP8yLoGO1Nq
         rqxk2A746CWpF98YJrfz+MjH2vwigc+q9Odn2ggncZQyFmVVdIpxNIRdv0/prmx5iWB5
         5BxvxMho3X4CKW6qSrPanM4z3fc15H1Q3l8jZU0pMYuDfJmlaDNRDtFlmoylMfsbuhjR
         0mow==
X-Gm-Message-State: AOAM530rlNupS1v6K5whEgLFCi7RXBpKNOHPetZ3IrpCL8z2doOHSMjt
        5wc8jUqpnLPgFakeCritry5dIC4BS13DV9Ok+2+zjpA6sD2I9g==
X-Google-Smtp-Source: ABdhPJylg5vSCuQ0OMqRstoTj4uABleME0hH8556DRyWoISrzMe/Kiee5tmmBavk0v3AymT+UTcW/YPzzoPu85aeC7o=
X-Received: by 2002:a81:3ac2:0:b0:2f7:f777:a43 with SMTP id
 h185-20020a813ac2000000b002f7f7770a43mr23786579ywa.60.1651233044128; Fri, 29
 Apr 2022 04:50:44 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 29 Apr 2022 17:20:33 +0530
Message-ID: <CA+G9fYvPgTdSU_9BcSrL8qPOhzPSykxa=NdTiT-pb0H+OqBpEg@mail.gmail.com>
Subject: [next] x86: BUG: kernel NULL pointer dereference, address:
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mina Almasry <almasrymina@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Rolf Eike Beer <eb@emlix.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linmiaohe@huawei.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following kernel BUG noticed on Linux next-20220428 on x86_64 while running
selftests x86 fsgsbase_64 test cases.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Test log:
----------
# selftests: x86: fsgsbase_64
# [OK] GSBASE started at 1
# [RUN] Set GS = 0x7, read GSBASE
# [OK] GSBASE reads as 0x1 with invalid GS
# FSGSBASE instructions are enabled
# [RUN] ARCH_SET_GS to 0x0
# [OK] GSBASE was set as expected (selector 0x0)
# [OK] ARCH_GET_GS worked as expected (selector 0x0)
# [RUN] ARCH_SET_GS to 0x1
# [OK] GSBASE was set as expected (selector 0x0)
# [OK] ARCH_GET_GS worked as exp[  199.295202] BUG: kernel NULL
pointer dereference, address: 0000000000000000
[  199.302779] #PF: supervisor read access in kernel mode
[  199.307918] #PF: error_code(0x0000) - not-present page
[  199.313057] PGD 8000000145f05067 P4D 8000000145f05067 PUD 145f04067 PMD 0
[  199.319930] Oops: 0000 [#1] PREEMPT SMP PTI
[  199.324117] CPU: 1 PID: 2948 Comm: sysret_rip_64 Tainted: G
     K   5.18.0-rc4-next-20220428 #1
[  199.333587] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.2 05/23/2018
[  199.340972] RIP: 0010:copy_vma+0x61/0x220
[  199.344983] Code: 48 89 45 d0 31 c0 49 8b 07 49 83 7f 60 00 48 89
45 b8 0f 84 47 01 00 00 48 8d 55 c8 4c 89 ee 4c 89 f7 4c 01 eb e8 2f
ec ff ff <48> 39 18 72 7e 4d 8b 47 20 4d 8b 4f 58 6a 00 48 89 d9 41 ff
b7 90
[  199.363722] RSP: 0018:ffffacf8813bfca0 EFLAGS: 00010292
[  199.368946] RAX: 0000000000000000 RBX: 00007fffffffe000 RCX: 0000000000000001
[  199.376070] RDX: ffffffffffffffff RSI: ffff9c6d04959f00 RDI: ffffacf8813bfc38
[  199.383193] RBP: ffffacf8813bfcf0 R08: 000000000000000b R09: 000000000000000b
[  199.390317] R10: ffff9c6d03e392f0 R11: 0000000000000058 R12: ffffacf8813bfd48
[  199.397441] R13: 00007fffffffd000 R14: ffff9c6ccc331d40 R15: ffff9c6d03e392f0
[  199.404566] FS:  00007fce67a16b80(0000) GS:ffff9c6e2fa80000(0000)
knlGS:0000000000000000
[  199.412644] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  199.418391] CR2: 0000000000000000 CR3: 0000000156398002 CR4: 00000000003706e0
[  199.425521] DR0: 00000000006021a8 DR1: 0000000000400ae9 DR2: 0000000000000000
[  199.432647] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[  199.439778] Call Trace:
[  199.442221]  <TASK>
[  199.444320]  move_vma+0x131/0x4a0
[  199.447644]  __do_sys_mremap+0x35c/0x890
[  199.451578]  ? syscall_trace_enter.constprop.0+0x176/0x230
[  199.457068]  __x64_sys_mremap+0x25/0x30
[  199.460907]  do_syscall_64+0x5c/0x80
[  199.464486]  ? do_syscall_64+0x69/0x80
[  199.468239]  ? syscall_exit_to_user_mode+0x3a/0x50
[  199.473031]  ? do_syscall_64+0x69/0x80
[  199.476786]  ? asm_exc_general_protection+0x8/0x30
[  199.481576]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  199.486631] RIP: 0033:0x7fce66f10bda
[  199.490208] Code: 73 01 c3 48 8b 0d be a2 2b 00 f7 d8 64 89 01 48
83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 19 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8e a2 2b 00 f7 d8 64 89
01 48
[  199.508952] RSP: 002b:00007ffd71e44b28 EFLAGS: 00000206 ORIG_RAX:
0000000000000019
[  199.516511] RAX: ffffffffffffffda RBX: 00007fffffffd000 RCX: 00007fce66f10bda
[  199.523634] RDX: 0000000000001000 RSI: 0000000000001000 RDI: 0000000000402000
[  199.530757] RBP: 0000000000000001 R08: 00007fffffffd000 R09: 00007ffd71e449fc
[  199.537883] R10: 0000000000000003 R11: 0000000000000206 R12: 0000000000000001
[  199.545016] R13: 00007ffd71e44ce0 R14: 0000000000000000 R15: 0000000000000000
[  199.552150]  </TASK>
[  199.554341] Modules linked in: x86_pkg_temp_thermal fuse [last
unloaded: test_klp_livepatch]
[  199.562772] CR2: 0000000000000000
ected (selector [  199.566084] ---[ end trace 0000000000000000 ]---
[  199.566085] RIP: 0010:copy_vma+0x61/0x220
0x0)
# [RUN] AR[  199.566088] Code: 48 89 45 d0 31 c0 49 8b 07 49 83 7f 60
00 48 89 45 b8 0f 84 47 01 00 00 48 8d 55 c8 4c 89 ee 4c 89 f7 4c 01
eb e8 2f ec ff ff <48> 39 18 72 7e 4d 8b 47 20 4d 8b 4f 58 6a 00 48 89
d9 41 ff b7 90
[  199.566089] RSP: 0018:ffffacf8813bfca0 EFLAGS: 00010292
CH_SET_GS to 0x2[  199.566090] RAX: 0000000000000000 RBX:
00007fffffffe000 RCX: 0000000000000001
[  199.566091] RDX: ffffffffffffffff RSI: ffff9c6d04959f00 RDI: ffffacf8813bfc38
00000000
# [OK][  199.566092] RBP: ffffacf8813bfcf0 R08: 000000000000000b R09:
000000000000000b
GSBASE was set [  199.566092] R10: ffff9c6d03e392f0 R11:
0000000000000058 R12: ffffacf8813bfd48
[  199.566093] R13: 00007fffffffd000 R14: ffff9c6ccc331d40 R15: ffff9c6d03e392f0
as expected (sel[  199.566094] FS:  00007fce67a16b80(0000)
GS:ffff9c6e2fa80000(0000) knlGS:0000000000000000
[  199.566095] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
ector 0x0)
# [O[  199.566096] CR2: 0000000000000000 CR3: 0000000156398002 CR4:
00000000003706e0
[  199.566097] DR0: 00000000006021a8 DR1: 0000000000400ae9 DR2: 0000000000000000
K] ARCH_GET_GS w[  199.566098] DR3: 0000000000000000 DR6:
00000000ffff0ff0 DR7: 0000000000000600
orked as expected (selector 0x0)
# [RUN] ARCH_SET_GS to 0x0
# [OK] GSBASE was set as expected (selector 0x0)
# [OK] ARCH_GET_GS worked as expected (selector 0x0)


metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: bdc61aad77faf67187525028f1f355eff3849f22
  git_describe: next-20220428
  kernel_version: 5.18.0-rc4
  kernel-config: https://builds.tuxbuild.com/28Pz4BMeY7pEp28bl5hC46lwjpe/config
  vmlinux : https://builds.tuxbuild.com/28Pz4BMeY7pEp28bl5hC46lwjpe/vmlinux.xz
  System.map : https://builds.tuxbuild.com/28Pz4BMeY7pEp28bl5hC46lwjpe/System.map


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org
