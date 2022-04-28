Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9137B513ABF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 19:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244399AbiD1RYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 13:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243792AbiD1RX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 13:23:59 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C5D56C38
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:20:43 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id z8so6049042oix.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Roq2TCNlJolW+UNGrAsJqI9FsrN5b4UJAlTVqbM92fs=;
        b=PFo432YB6aB7og9Pl+768H0A9ltaAWWrfDSkWWaDjyVEmziI63ElFUQA2fRMj6l7ca
         BuKmd4xxMv0EzvOKhz2vM5qKY41bX9wADrMLECFXaK3CS7lhrdAnXYWLnRVniYUQMmSp
         x2uCAfsw/pRUHmUNxFoVDvANp9bi4IJZHfy+too5yy7TmQHmWqUiOJ4VWz/DjkF8KZza
         BOrAohEZLNhjvA4e3oeMrM4/Gs5yy2gz5DCixCeRCN7CX2OYrSG1ALq5xP9kx63s/bon
         FMSCiBzAfVXKRJWkVe4hTF4WVMtfO96DEEkvJfb2ZrL+Ta1OjzWGWY+KQh/ZTS5nV5Tt
         PVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=Roq2TCNlJolW+UNGrAsJqI9FsrN5b4UJAlTVqbM92fs=;
        b=zwQFQaLtYb1+S6aq6cwmFw8EPqTFPAl3jr0xRCz54Uc8BTGoDVSTq9gtnsxw5t1xsD
         t1jm9KMqdga9+FFXQip1aM03GED2E+XEFWpeYwsqLDNMoVQq1vqi2U4PcxD4CkEYqU7e
         79jxOdxUYD53IQ4pqCMLTtoXoIpfE3dvTH4YV/7y6CPId+EdfI8FAqq2d92F9GWcBkNo
         oiCyB3Sz03D7UujlJSjh++6YXQo1iL8mJeYaCL5m9ugDG19MKpShjr75ji+DrKhaQZH8
         3zz22jcxjp1T3eTFw+bK3bdl9DPpGHnYQXJ6mVLpzNG1+UIK+3NeLaKyca0I2j7mUG+x
         1sCw==
X-Gm-Message-State: AOAM533f0GjeBFKRKvIPg6cFWnyeWLqip8fdBh7Vsis+isyiv8nSztxV
        pJJ5/N5aV3mmd/4NBRXGqwsiAdlszIw=
X-Google-Smtp-Source: ABdhPJxPmVkGJKeOhYQ1A3We1mDVJUUXz7Ce+75s2hBRU8b1P+KEVABho3wAZYykpnnyL4cgJFnuZQ==
X-Received: by 2002:a05:6808:159d:b0:325:7b4d:e28f with SMTP id t29-20020a056808159d00b003257b4de28fmr4403448oiw.223.1651166442913;
        Thu, 28 Apr 2022 10:20:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id dw40-20020a056870772800b000e686d1387csm2071296oab.22.2022.04.28.10.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 10:20:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 28 Apr 2022 10:20:40 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH] mapletree-vs-khugepaged
Message-ID: <20220428172040.GA3623323@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 03:10:45PM -0700, Andrew Morton wrote:
> Fix mapletree for patch series "Make khugepaged collapse readonly FS THP
> more consistent", v3.
> 
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

This patch causes all my sparc64 boot tests to fail. Bisect and crash logs
attached.

Guenter

---
[   12.624703] Unable to handle kernel paging request at virtual address 0e00000000000000
[   12.624793] tsk->{mm,active_mm}->context = 0000000000000005
[   12.624823] tsk->{mm,active_mm}->pgd = fffff800048b8000
[   12.624849]               \|/ ____ \|/
[   12.624849]               "@'/ .. \`@"
[   12.624849]               /_| \__/ |_\
[   12.624849]                  \__U_/
[   12.624874] init(1): Oops [#1]
[   12.625194] CPU: 0 PID: 1 Comm: init Not tainted 5.18.0-rc4-next-20220428 #1
[   12.625421] TSTATE: 0000009911001606 TPC: 00000000005e6330 TNPC: 00000000005e6334 Y: 00000000    Not tainted
[   12.625455] TPC: <mmap_region+0x150/0x700>
[   12.625503] g0: 0000000000619a00 g1: 0000000000000000 g2: fffff8000488b200 g3: 0000000000000000
[   12.625537] g4: fffff8000414a9a0 g5: fffff8001dd3e000 g6: fffff8000414c000 g7: 0000000000000000
[   12.625569] o0: 0000000000000000 o1: 0000000000000000 o2: 0000000001167b68 o3: 0000000000f51bb8
[   12.625601] o4: fffff80100301fff o5: fffff8000414fc20 sp: fffff8000414f341 ret_pc: 00000000005e6310
[   12.625630] RPC: <mmap_region+0x130/0x700>
[   12.625692] l0: fffff8000488b260 l1: 000000000000008b l2: fffff80100302000 l3: 0000000000000000
[   12.625725] l4: fffff80100301fff l5: 0000000000000000 l6: 30812c2a1dd8556f l7: fffff8000414b438
[   12.625762] i0: fffff800044f58a0 i1: fffff801001ec000 i2: 0e00000000000000 i3: 0000000000000075
[   12.625795] i4: 0000000000000000 i5: fffff8000414fde0 i6: fffff8000414f461 i7: 00000000005e6c58
[   12.625833] I7: <do_mmap+0x378/0x500>
[   12.625906] Call Trace:
[   12.626006] [<00000000005e6c58>] do_mmap+0x378/0x500
[   12.626092] [<00000000005bdc98>] vm_mmap_pgoff+0x78/0x100
[   12.626112] [<00000000005e3d24>] ksys_mmap_pgoff+0x164/0x1c0
[   12.626129] [<0000000000406294>] linux_sparc_syscall+0x34/0x44
[   12.626198] Disabling lock debugging due to kernel taint
[   12.626286] Caller[00000000005e6c58]: do_mmap+0x378/0x500
[   12.626335] Caller[00000000005bdc98]: vm_mmap_pgoff+0x78/0x100
[   12.626354] Caller[00000000005e3d24]: ksys_mmap_pgoff+0x164/0x1c0
[   12.626371] Caller[0000000000406294]: linux_sparc_syscall+0x34/0x44
[   12.626390] Caller[fffff8010001d88c]: 0xfffff8010001d88c
[   12.626537] Instruction DUMP:
[   12.626567]  a6100008
[   12.626678]  02c68006
[   12.626685]  01000000
[   12.626690] <c25e8000>
[   12.626696]  80a04012
[   12.626701]  22600077
[   12.626707]  c25ea088
[   12.626712]  22c4c00a
[   12.626717]  f277a7c7
[   12.626728]
[   12.627169] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009

---
# bad: [bdc61aad77faf67187525028f1f355eff3849f22] Add linux-next specific files for 20220428
# good: [af2d861d4cd2a4da5137f795ee3509e6f944a25b] Linux 5.18-rc4
git bisect start 'HEAD' 'v5.18-rc4'
# good: [a6ffa4aa7e81a54632f3370f4c93fce603160192] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect good a6ffa4aa7e81a54632f3370f4c93fce603160192
# good: [cd63f17e3bb63006f9f88bf7f5947b8e1601bcd9] Merge branch 'edac-for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git
git bisect good cd63f17e3bb63006f9f88bf7f5947b8e1601bcd9
# good: [cee7bbed3e5cc089b5c364ac8ad4a186c2a28bb6] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git
git bisect good cee7bbed3e5cc089b5c364ac8ad4a186c2a28bb6
# good: [d5a23156ea99f10b584221893a6a7d6f6554cde8] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git
git bisect good d5a23156ea99f10b584221893a6a7d6f6554cde8
# good: [2f1fde90d983bc404503100c9c4bbbf1e191bcf4] selftests: cgroup: fix alloc_anon_noexit() instantly freeing memory
git bisect good 2f1fde90d983bc404503100c9c4bbbf1e191bcf4
# good: [fca1db6ff251278c532231552e840c7dc36dfa76] Merge branch 'bitmap-for-next' of https://github.com/norov/linux.git
git bisect good fca1db6ff251278c532231552e840c7dc36dfa76
# good: [40b39116fe8e6fb66e3166ea40138eec506dfd91] perf: use VMA iterator
git bisect good 40b39116fe8e6fb66e3166ea40138eec506dfd91
# bad: [33ef257872566922df2b6bcfdb5330b2388aef53] Docs/{ABI,admin-guide}/damon: update for fixed virtual address ranges monitoring
git bisect bad 33ef257872566922df2b6bcfdb5330b2388aef53
# good: [2d8640f244c1ea6c40acde911d339dabc2ac765d] mm/oom_kill: use maple tree iterators instead of vma linked list
git bisect good 2d8640f244c1ea6c40acde911d339dabc2ac765d
# good: [49d281fa016f2906346f1707e5059b6f7674a948] mm/mmap.c: pass in mapping to __vma_link_file()
git bisect good 49d281fa016f2906346f1707e5059b6f7674a948
# bad: [778ae6914961a857596ccdddb69f34ad1d597cd0] selftets/damon/sysfs: test existence and permission of avail_operations
git bisect bad 778ae6914961a857596ccdddb69f34ad1d597cd0
# bad: [14031cb11d7f48cc0cb19084537e378fa8ce020d] mm/damon/core: add a function for damon_operations registration checks
git bisect bad 14031cb11d7f48cc0cb19084537e378fa8ce020d
# bad: [41fd8be857ee43f2f466fca7c2b66fea39f6540d] mapletree-vs-khugepaged
git bisect bad 41fd8be857ee43f2f466fca7c2b66fea39f6540d
# first bad commit: [41fd8be857ee43f2f466fca7c2b66fea39f6540d] mapletree-vs-khugepaged
