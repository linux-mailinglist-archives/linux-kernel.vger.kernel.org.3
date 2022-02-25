Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26574C44B6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbiBYMkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiBYMk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:40:29 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DE91D97FA
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:39:57 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D7F203F1B6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 12:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645792796;
        bh=HCBpo4PsqJUx1yHp1r7/10LuebIPFGAh3ml+5ybdqeU=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=hhFSyT+1TaQbd3EhcPzGukM2wb5hxzzNsDdMV7Emtbqvfpk95udMphQ1cMTcfyRdP
         8Kmvfh/28AiaG239xpl0GlGDOabidVHmF7+zFuHRo4elIqyTcSF+HWzU5Fa+5Q34VP
         YtnQahxItKi60alkGKeqBjYkY3e15hoxi4ePTGYnPJGNfpKlT/ca4Jjm16ndjVRWap
         VOgwGbzD5n7bvvwEkTMXLFSb/hmKJn/hOzHtABMheJoTUBvVuQgrCzNsOBKLNWHiHC
         2o/pWItoivGi+m8SIiWbCwohpHmMIx5hrX7MZrKpiSTy0qrstEoBKtTuLAYLSimh5d
         Wr5UIHvRzyQWw==
Received: by mail-wm1-f70.google.com with SMTP id h206-20020a1c21d7000000b003552c13626cso1515999wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:39:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HCBpo4PsqJUx1yHp1r7/10LuebIPFGAh3ml+5ybdqeU=;
        b=HvIQLyxWLLoqPhuzTUt3iDM2FAoAnSQ5P+0hPJIvS9JFEbQ/LYqwnUptHKPN4k7c1+
         HdlpXy9cKzgXGDDAyYfU8gyFLmdISPInNzAs7B/HRwpOI3M4XNIPr6h7LC4hUgziTFrf
         z1DQAbi4QH5RqPVqQuBI67tBW+78H8DsXaG2HqTuQgtJJ9a63cqgalCcjHMlD39/S63n
         LQn7yr3JpzKyL4h67xD/d9kTmkcbaRD2dXhkYzK6oxEUcFygzZjKiUvuyHvkz1RC2seT
         NozqPOui2Ix8OnWyQ/ZI0Nos5MTwpMbkyHMFTRURnCvthhRtZDOOzb27xAv+ESdlSdtT
         TuLA==
X-Gm-Message-State: AOAM532z+0LpdgXqIk0RpsFPm8ukgUEdBKW3vE06UGxAcP0bLh7sWFGL
        1LpoTjH4FsnlYYTX/TAeaDtYYSbkjptbAM6X5bODOVdEq8WUgoMJkxXOc6uQqC0DYdDzg26p599
        hayu7NOjCCbj9pntw9E63pBxxQg1Owst9LLcuoNstNQ==
X-Received: by 2002:a05:600c:4e8d:b0:37c:4e20:baa6 with SMTP id f13-20020a05600c4e8d00b0037c4e20baa6mr2571100wmq.19.1645792796224;
        Fri, 25 Feb 2022 04:39:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9QofFekuLpagTizNm0Nvue0YJrwM7JnOms0+vyselmIfyGv4HfSWC7mWt/qp/V+q7KV98Kw==
X-Received: by 2002:a05:600c:4e8d:b0:37c:4e20:baa6 with SMTP id f13-20020a05600c4e8d00b0037c4e20baa6mr2571082wmq.19.1645792796034;
        Fri, 25 Feb 2022 04:39:56 -0800 (PST)
Received: from localhost.localdomain (lfbn-gre-1-195-1.w90-112.abo.wanadoo.fr. [90.112.158.1])
        by smtp.gmail.com with ESMTPSA id m1-20020adfdc41000000b001edb7520438sm2216981wrj.115.2022.02.25.04.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 04:39:55 -0800 (PST)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Nick Hu <nickhu@andestech.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: [PATCH -fixes v3 0/6] Fixes KASAN and other along the way
Date:   Fri, 25 Feb 2022 13:39:47 +0100
Message-Id: <20220225123953.3251327-1-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by Aleksandr, syzbot riscv is broken since commit
54c5639d8f50 ("riscv: Fix asan-stack clang build"). This commit actually
breaks KASAN_INLINE which is not fixed in this series, that will come later
when found.

Nevertheless, this series fixes small things that made the syzbot
configuration + KASAN_OUTLINE fail to boot.

Note that even though the config at [1] boots fine with this series, I
was not able to boot the small config at [2] which fails because
kasan_poison receives a really weird address 0x4075706301000000 (maybe a
kasan person could provide some hint about what happens below in
do_ctors -> __asan_register_globals):

Thread 2 hit Breakpoint 1, kasan_poison (addr=<optimized out>, size=<optimized out>, value=<optimized out>, init=<optimized out>) at /home/alex/work/linux/mm/kasan/shadow.c:90
90		if (WARN_ON((unsigned long)addr & KASAN_GRANULE_MASK))
1: x/i $pc
=> 0xffffffff80261712 <kasan_poison>:	andi	a4,a0,7
5: /x $a0 = 0x4075706301000000

Thread 2 hit Breakpoint 2, handle_exception () at /home/alex/work/linux/arch/riscv/kernel/entry.S:27
27		csrrw tp, CSR_SCRATCH, tp
1: x/i $pc
=> 0xffffffff80004098 <handle_exception>:	csrrw	tp,sscratch,tp
5: /x $a0 = 0xe80eae0b60200000
(gdb) bt
#0  handle_exception () at /home/alex/work/linux/arch/riscv/kernel/entry.S:27
#1  0xffffffff80261746 in kasan_poison (addr=<optimized out>, size=<optimized out>, value=<optimized out>, init=<optimized out>)
    at /home/alex/work/linux/mm/kasan/shadow.c:98
#2  0xffffffff802618b4 in kasan_unpoison (addr=<optimized out>, size=<optimized out>, init=<optimized out>)
    at /home/alex/work/linux/mm/kasan/shadow.c:138
#3  0xffffffff80260876 in register_global (global=<optimized out>) at /home/alex/work/linux/mm/kasan/generic.c:214
#4  __asan_register_globals (globals=<optimized out>, size=<optimized out>) at /home/alex/work/linux/mm/kasan/generic.c:226
#5  0xffffffff8125efac in _sub_I_65535_1 ()
#6  0xffffffff81201b32 in do_ctors () at /home/alex/work/linux/init/main.c:1156
#7  do_basic_setup () at /home/alex/work/linux/init/main.c:1407
#8  kernel_init_freeable () at /home/alex/work/linux/init/main.c:1613
#9  0xffffffff81153ddc in kernel_init (unused=<optimized out>) at /home/alex/work/linux/init/main.c:1502
#10 0xffffffff800041c0 in handle_exception () at /home/alex/work/linux/arch/riscv/kernel/entry.S:231


Thanks again to Aleksandr for narrowing down the issues fixed here.


[1] https://gist.github.com/a-nogikh/279c85c2d24f47efcc3e865c08844138
[2] https://gist.github.com/AlexGhiti/a5a0cab0227e2bf38f9d12232591c0e4

Changes in v3:
- Add PATCH 5/6 and PATCH 6/6

Changes in v2:
- Fix kernel test robot failure regarding KERN_VIRT_SIZE that is
  undefined for nommu config

Alexandre Ghiti (6):
  riscv: Fix is_linear_mapping with recent move of KASAN region
  riscv: Fix config KASAN && SPARSEMEM && !SPARSE_VMEMMAP
  riscv: Fix DEBUG_VIRTUAL false warnings
  riscv: Fix config KASAN && DEBUG_VIRTUAL
  riscv: Move high_memory initialization to setup_bootmem
  riscv: Fix kasan pud population

 arch/riscv/include/asm/page.h    | 2 +-
 arch/riscv/include/asm/pgtable.h | 1 +
 arch/riscv/mm/Makefile           | 3 +++
 arch/riscv/mm/init.c             | 2 +-
 arch/riscv/mm/kasan_init.c       | 8 +++++---
 arch/riscv/mm/physaddr.c         | 4 +---
 6 files changed, 12 insertions(+), 8 deletions(-)

-- 
2.32.0

