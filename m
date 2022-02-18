Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025684BBA28
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 14:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbiBRNgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 08:36:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbiBRNgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 08:36:01 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4154DE8685
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 05:35:45 -0800 (PST)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 85D1F4004C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645191341;
        bh=2yMxZwtr/8gF+DdEs5PumNe+/8vsdXtXdAp73EogBDY=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=bA6i/qlgJeDFjaiHw7hcOLwanhFG8KS0Lxxw05ucbGQOLPBdnv1oJR1Yt2wzVbdVq
         Pagm5s+y7Wy8DdJIYM9Sd0NVLP9FR9q+MFBrEQ/T30RSJJcrfWwL6lvGZi2nyR+zz8
         aSDfiVaN1YlzkRpYVAetllr2ja82X+r1dTN8Yb3//RrarC/22j95wksaBQAKkpWnHa
         yPdwJwSlR3EiQ+kN6Zl06ODqHRS7Ekc00x6hRC+NUWRwLqn1c2tqCIvUZlefZOPfgL
         UGQSZrRVxGX4bxhPJiWAv4YVsEShX6+/T8YjXoxcV6GeBQP3+Bdwj7Gmv3BQGW8DxL
         5tkDFv5/FV5pw==
Received: by mail-wm1-f71.google.com with SMTP id c7-20020a1c3507000000b0034a0dfc86aaso5933273wma.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 05:35:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2yMxZwtr/8gF+DdEs5PumNe+/8vsdXtXdAp73EogBDY=;
        b=dlabSvsNnZ/NITSnLxSkFhJhjDgg+BvFHes/eEhJg5EAQfOGiSZE0Htk2HNlYVxKhR
         r9aIQZ1+x4klmMmIQcc6pwDA2vDz1huSKUeW/Z9QAPuMSScJRlfsLXaiu46pSfbjK7hb
         qxbqZj8O/7fM0VklVE+mh7y6LU8tkga2LN/8cC+/j+6dWwLikrvpllKtLoARvOhi5Tji
         cerrATV6wJCV+fiMg9HNbxP8Mfdcy/FC/xjthyN0YFE7LL6eWCllkLT3DwrzJzotXqhN
         +EguK6J2B+UcPG8qsu6iP84DwaMrbUUtVG12UzYrWby7IitBtWeaDnC1CjeUpkb53MJ4
         fyNw==
X-Gm-Message-State: AOAM533QDc1yhYYmfni5R6WdaqOSZ1VlME5/twilakhOsrFUe9r3fxQl
        sKMOust4gQubCZR8KQagRu73PCChyn+pks8Hw0Xu0cVj1ye1NzHKPK728Sa9qnGQdv+Kdu9nKOm
        yN5J2Rm/mZ9VkBvOOMW+Czot0t0YZaoUTOWzUEudkCw==
X-Received: by 2002:a05:600c:1e8e:b0:37b:b9ab:e35d with SMTP id be14-20020a05600c1e8e00b0037bb9abe35dmr10720473wmb.109.1645191340873;
        Fri, 18 Feb 2022 05:35:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyohAygHewTfQYDTOphC1Yoet4IBKeTpab9xavEBbLBq0CfmQQB3UD7pgUqU6ku/vHItAmtOA==
X-Received: by 2002:a05:600c:1e8e:b0:37b:b9ab:e35d with SMTP id be14-20020a05600c1e8e00b0037bb9abe35dmr10720462wmb.109.1645191340715;
        Fri, 18 Feb 2022 05:35:40 -0800 (PST)
Received: from localhost.localdomain (lfbn-gre-1-195-1.w90-112.abo.wanadoo.fr. [90.112.158.1])
        by smtp.gmail.com with ESMTPSA id c4sm21258318wri.22.2022.02.18.05.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 05:35:40 -0800 (PST)
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
Subject: [PATCH -fixes 0/4] Fixes KASAN and other along the way
Date:   Fri, 18 Feb 2022 14:35:09 +0100
Message-Id: <20220218133513.1762929-1-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Alexandre Ghiti (4):
  riscv: Fix is_linear_mapping with recent move of KASAN region
  riscv: Fix config KASAN && SPARSEMEM && !SPARSE_VMEMMAP
  riscv: Fix DEBUG_VIRTUAL false warnings
  riscv: Fix config KASAN && DEBUG_VIRTUAL

 arch/riscv/include/asm/page.h | 2 +-
 arch/riscv/mm/Makefile        | 3 +++
 arch/riscv/mm/kasan_init.c    | 3 +--
 arch/riscv/mm/physaddr.c      | 4 +---
 4 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.32.0

