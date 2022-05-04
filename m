Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2979251B157
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 23:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378901AbiEDVuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbiEDVue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:50:34 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A8C13E09
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 14:46:57 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id m23so3340595ljb.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 14:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MNM2HRIr6bEI0LTItUDhTFIXv/Fm3VOKCBmfFT7P67I=;
        b=LUlsALkwm+C3SzWv0cGRSwaTTRPGUWQQeqagiue8EufkVWQ10J//rVa1HYXgGcc7dz
         GMYaKFQqB50zLn7junISq+1InZ9RXB+P8Ac0U7S1Dr6fjj2bckysN2Tx/FwjZqs2FMSH
         Y6JYGGRbBBr1BiKX65ltr1Ntbzt3vR/HliEVOfW6KLEOTQ31CQry8l6wKyeO42qnejaH
         OfgybvtVXnHlt0klQg089TrYdqIg17RA21dKUe/3m9WOIit2w+kw7ztpitla8m1P/3Rp
         CHxAkYmyk9z769tBZaZCcgXzblx+gcEBMjPoZ8Ixs1KYwoPhKAvOQ9untJxdTQ5b6i/9
         Jg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MNM2HRIr6bEI0LTItUDhTFIXv/Fm3VOKCBmfFT7P67I=;
        b=eAr6m+5psRAc0sX8Th4D9XEVcFQfTxk6AFty+4WlRCWq68oqDsAjAuGekYQUOprnFP
         saz9f6NxJt2uzlW/wRhaTkOIWqJrx33WzjUyJ6aUXjjowmkrb0Yqm0i0emrT82W+V8Wn
         MUadr+DNpjhQd+Hp0eLrhpYIL+qEmQ+uQwgnojGwckncHV8hrFj3vHZGWqoaJzksiv/b
         9Pphr6gDyi98Co2YyIHViOKp1C94K78n6uJI1bJZGzja/wudot9luM7LJ4TSu/WAsW2l
         Q1seSfskcpKoH4jLGSD/JBUkgIAujyEAJY1rSG7ROZObiPZPMKzkeLXxWvmDyiLIlNB+
         3mGw==
X-Gm-Message-State: AOAM531VPIdYbFaemHaQr2AVIwP5XdM+1LSdwf+JoYtqi8NKdSaQ0GYq
        7aJvGCw6v3ushLxhZnSFjyZhyVWZxe6VDIzK+gnEHg==
X-Google-Smtp-Source: ABdhPJxSOgOu1pCUnfOYePv47IyMPAIwwjoruyuBH83KKegFGch5B4RyedJ6qCtqomvTkN53BjjrZhuWpv+aSF0J/sU=
X-Received: by 2002:a2e:9645:0:b0:24f:2e6f:f931 with SMTP id
 z5-20020a2e9645000000b0024f2e6ff931mr13700489ljh.466.1651700815373; Wed, 04
 May 2022 14:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220502181714.3483177-5-zokeefe@google.com> <20220504022511.GC30775@xsang-OptiPlex-9020>
In-Reply-To: <20220504022511.GC30775@xsang-OptiPlex-9020>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Wed, 4 May 2022 14:46:18 -0700
Message-ID: <CAAa6QmT-DiPHaW7k40=iUwoGcG=dRsY=gFem+H8h5oeFj0+huA@mail.gmail.com>
Subject: Re: [mm/khugepaged] 0d006aeaf9: BUG:unable_to_handle_page_fault_for_address
To:     kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, Alex Shi <alex.shi@linux.alibaba.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>, SeongJae Park <sj@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Chris Zankel <chris@zankel.net>, Helge Deller <deller@gmx.de>,
        Hugh Dickins <hughd@google.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Patrick Xia <patrickx@google.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reporting. Fixed in v5.

On Tue, May 3, 2022 at 7:25 PM kernel test robot <oliver.sang@intel.com> wrote:
>
>
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-11):
>
> commit: 0d006aeaf99be94a0dcb727cb6540195f13fd9c3 ("[PATCH v4 04/13] mm/khugepaged: make hugepage allocation context-specific")
> url: https://github.com/intel-lab-lkp/linux/commits/Zach-O-Keefe/mm-khugepaged-record-SCAN_PMD_MAPPED-when-scan_pmd-finds-THP/20220503-031727
> patch link: https://lore.kernel.org/linux-mm/20220502181714.3483177-5-zokeefe@google.com
>
> in testcase: boot
>
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
>
> [   18.854835][   T17] BUG: unable to handle page fault for address: 003c24ca
> [   18.855169][   T17] #PF: supervisor read access in kernel mode
> [   18.855395][   T17] #PF: error_code(0x0000) - not-present page
> [   18.855620][   T17] *pde = 00000000
> [   18.855763][   T17] Oops: 0000 [#1]
> [   18.855903][   T17] CPU: 0 PID: 17 Comm: khugepaged Not tainted 5.18.0-rc5-next-20220502-00004-g0d006aeaf99b #1
> [ 18.856283][ T17] EIP: alloc_charge_hpage (mm/khugepaged.c:951 mm/khugepaged.c:1091)
> [ 18.856498][ T17] Code: 00 00 00 55 89 e5 6a 07 e8 86 c0 ff ff c9 31 d2 89 d1 c3 55 89 e5 a1 28 e6 fa 59 25 80 00 00 00 83 f8 01 19 c0 25 00 fc ff ff <8b> 80 ca 24 3c 00 85 c0 74 0f 8b 42 08 5d 8b 40 04 b8 01 00 00 00
> All code
> ========
>    0:   00 00                   add    %al,(%rax)
>    2:   00 55 89                add    %dl,-0x77(%rbp)
>    5:   e5 6a                   in     $0x6a,%eax
>    7:   07                      (bad)
>    8:   e8 86 c0 ff ff          callq  0xffffffffffffc093
>    d:   c9                      leaveq
>    e:   31 d2                   xor    %edx,%edx
>   10:   89 d1                   mov    %edx,%ecx
>   12:   c3                      retq
>   13:   55                      push   %rbp
>   14:   89 e5                   mov    %esp,%ebp
>   16:   a1 28 e6 fa 59 25 80    movabs 0x802559fae628,%eax
>   1d:   00 00
>   1f:   00 83 f8 01 19 c0       add    %al,-0x3fe6fe08(%rbx)
>   25:   25 00 fc ff ff          and    $0xfffffc00,%eax
>   2a:*  8b 80 ca 24 3c 00       mov    0x3c24ca(%rax),%eax              <-- trapping instruction
>   30:   85 c0                   test   %eax,%eax
>   32:   74 0f                   je     0x43
>   34:   8b 42 08                mov    0x8(%rdx),%eax
>   37:   5d                      pop    %rbp
>   38:   8b 40 04                mov    0x4(%rax),%eax
>   3b:   b8 01 00 00 00          mov    $0x1,%eax
>
> Code starting with the faulting instruction
> ===========================================
>    0:   8b 80 ca 24 3c 00       mov    0x3c24ca(%rax),%eax
>    6:   85 c0                   test   %eax,%eax
>    8:   74 0f                   je     0x19
>    a:   8b 42 08                mov    0x8(%rdx),%eax
>    d:   5d                      pop    %rbp
>    e:   8b 40 04                mov    0x4(%rax),%eax
>   11:   b8 01 00 00 00          mov    $0x1,%eax
> [   18.857217][   T17] EAX: 00000000 EBX: 41172400 ECX: 00000000 EDX: 411d1f7c
> [   18.857487][   T17] ESI: 411d1f7c EDI: 4117245c EBP: 411d1e64 ESP: 411d1e64
> [   18.857750][   T17] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010246
> [   18.858036][   T17] CR0: 80050033 CR2: 003c24ca CR3: 112f3000 CR4: 000406d0
> [   18.858302][   T17] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [   18.858567][   T17] DR6: fffe0ff0 DR7: 00000400
> [   18.858743][   T17] Call Trace:
> [ 18.858871][ T17] ? collapse_huge_page (mm/khugepaged.c:1109)
> [ 18.859066][ T17] ? find_held_lock (kernel/locking/lockdep.c:5156)
> [ 18.859245][ T17] ? khugepaged_scan_pmd (mm/khugepaged.c:1400)
> [ 18.859446][ T17] ? khugepaged_scan_mm_slot (mm/khugepaged.c:2216)
> [ 18.859657][ T17] ? khugepaged_do_scan (mm/khugepaged.c:2290)
> [ 18.859854][ T17] ? khugepaged (mm/khugepaged.c:2340)
> [ 18.860016][ T17] ? khugepaged_defrag_show (mm/khugepaged.c:1076)
> [ 18.860219][ T17] ? kthread (kernel/kthread.c:376)
> [ 18.860374][ T17] ? khugepaged_do_scan (mm/khugepaged.c:2328)
> [ 18.860570][ T17] ? kthread_complete_and_exit (kernel/kthread.c:331)
> [ 18.860781][ T17] ? ret_from_fork (arch/x86/entry/entry_32.S:772)
> [   18.860956][   T17] Modules linked in:
> [   18.861105][   T17] CR2: 00000000003c24ca
> [   18.861262][   T17] ---[ end trace 0000000000000000 ]---
> [ 18.861263][ T17] EIP: alloc_charge_hpage (mm/khugepaged.c:951 mm/khugepaged.c:1091)
> [ 18.861266][ T17] Code: 00 00 00 55 89 e5 6a 07 e8 86 c0 ff ff c9 31 d2 89 d1 c3 55 89 e5 a1 28 e6 fa 59 25 80 00 00 00 83 f8 01 19 c0 25 00 fc ff ff <8b> 80 ca 24 3c 00 85 c0 74 0f 8b 42 08 5d 8b 40 04 b8 01 00 00 00
> All code
> ========
>    0:   00 00                   add    %al,(%rax)
>    2:   00 55 89                add    %dl,-0x77(%rbp)
>    5:   e5 6a                   in     $0x6a,%eax
>    7:   07                      (bad)
>    8:   e8 86 c0 ff ff          callq  0xffffffffffffc093
>    d:   c9                      leaveq
>    e:   31 d2                   xor    %edx,%edx
>   10:   89 d1                   mov    %edx,%ecx
>   12:   c3                      retq
>   13:   55                      push   %rbp
>   14:   89 e5                   mov    %esp,%ebp
>   16:   a1 28 e6 fa 59 25 80    movabs 0x802559fae628,%eax
>   1d:   00 00
>   1f:   00 83 f8 01 19 c0       add    %al,-0x3fe6fe08(%rbx)
>   25:   25 00 fc ff ff          and    $0xfffffc00,%eax
>   2a:*  8b 80 ca 24 3c 00       mov    0x3c24ca(%rax),%eax              <-- trapping instruction
>   30:   85 c0                   test   %eax,%eax
>   32:   74 0f                   je     0x43
>   34:   8b 42 08                mov    0x8(%rdx),%eax
>   37:   5d                      pop    %rbp
>   38:   8b 40 04                mov    0x4(%rax),%eax
>   3b:   b8 01 00 00 00          mov    $0x1,%eax
>
> Code starting with the faulting instruction
> ===========================================
>    0:   8b 80 ca 24 3c 00       mov    0x3c24ca(%rax),%eax
>    6:   85 c0                   test   %eax,%eax
>    8:   74 0f                   je     0x19
>    a:   8b 42 08                mov    0x8(%rdx),%eax
>    d:   5d                      pop    %rbp
>    e:   8b 40 04                mov    0x4(%rax),%eax
>   11:   b8 01 00 00 00          mov    $0x1,%eax
>
>
> To reproduce:
>
>         # build kernel
>         cd linux
>         cp config-5.18.0-rc5-next-20220502-00004-g0d006aeaf99b .config
>         make HOSTCC=gcc-11 CC=gcc-11 ARCH=i386 olddefconfig prepare modules_prepare bzImage modules
>         make HOSTCC=gcc-11 CC=gcc-11 ARCH=i386 INSTALL_MOD_PATH=<mod-install-dir> modules_install
>         cd <mod-install-dir>
>         find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
>
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
>
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
>
>
