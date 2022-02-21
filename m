Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C56D4BE98F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379957AbiBUQNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:13:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235938AbiBUQNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:13:39 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0ED7BF56
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:13:15 -0800 (PST)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BB3D73F1B6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 16:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645459988;
        bh=vRzNDqjN6ajBEKsUVpfuJLu9ktKbrLjh36kCMNlOgAc=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=v6CNC7BZR9Ocdtvcv1jam+0lHdQ8OMUZSBLSbigY4Sf5Haf+56Ny33NqBebPNU/b3
         +jrNnad/nQTAkNvXLVYyUtayrtFBY5sk15XC/KjvA3ERCAJ2mZa/IAdhjrOCrb+G0w
         w/22fqlLRTgJMVQWYLOaAwUEwquVydTm8x+wrJoenMQCc7pQg5Pef7nslmdpbuXXHS
         Sch81zexN91+e4wslSXa3qZIS+WfxpyABjNiUs0C+HcM9ZDedUNdqiswx9NmaLsLtU
         D5pebFl8WqdKuoTBSga8sHJNzDEO2s4nxjsr3WvvDZ3fYp2i8IhX9ydfruASOUNlgC
         6+Jb5iPFRyUVw==
Received: by mail-wr1-f70.google.com with SMTP id u9-20020adfae49000000b001e89793bcb0so6133024wrd.17
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:13:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vRzNDqjN6ajBEKsUVpfuJLu9ktKbrLjh36kCMNlOgAc=;
        b=0GvG7+Mu0A195mXwMbFjDWrvYN+2Cdze67V/jlOmF/gyfJSilcFw161LKTjTZ1cYP9
         D/xRUlC053C6LIMHS4/0jfvYOTxn5c8xnjFLQb/JIHgTnb+pF6sJ46jvv8sCnJ64Csj1
         bWOt/KTQqBnnvlpo16a4HOpwI2P+4AVRz5dTAm7E7AcSg7hsSZUoeC2YZ6KQWT4SRkxc
         R1812i+pHb+h6HR/bTpKNyxaSj4uHaY1SDw/8SYlqo5xh0gE11HT841pR+dkOUwHpORy
         bGobwHILM3IczRZkDq2wzWgMZMMhUd8K3em3/Boaz1lyFZxE4qj7iI8MtX3Jk2uvypQe
         M/Pg==
X-Gm-Message-State: AOAM532LTcnBX90lgqFyIhLQJUSc+rW/+8cZ6uLaFczXHnv3TY1Fj73u
        rWIW8kEV5VhfI1O6MxgPhipKuzChwFkYWcB0zGEIAZrb6+N+4FAkoaMKuvU3yRr4NoVBa2FMobL
        1L3wC98TMRYvafd2VzFsq3DIOSrMqBmxUixwyY/vrVA==
X-Received: by 2002:a5d:5546:0:b0:1e7:39f7:92b9 with SMTP id g6-20020a5d5546000000b001e739f792b9mr16109066wrw.5.1645459986980;
        Mon, 21 Feb 2022 08:13:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxYARHj/Mj7yrv5G5MA7LwMLl7DKmEUB0He0crX8AOVYhpRiwKK4744czYz8Tb0FwmorU5iiQ==
X-Received: by 2002:a5d:5546:0:b0:1e7:39f7:92b9 with SMTP id g6-20020a5d5546000000b001e739f792b9mr16109052wrw.5.1645459986740;
        Mon, 21 Feb 2022 08:13:06 -0800 (PST)
Received: from localhost.localdomain (lfbn-gre-1-195-1.w90-112.abo.wanadoo.fr. [90.112.158.1])
        by smtp.gmail.com with ESMTPSA id n7sm7976623wmd.30.2022.02.21.08.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 08:13:06 -0800 (PST)
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
Subject: [PATCH -fixes v2 0/4] Fixes KASAN and other along the way
Date:   Mon, 21 Feb 2022 17:12:28 +0100
Message-Id: <20220221161232.2168364-1-alexandre.ghiti@canonical.com>
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


Changes in v2:
- Fix kernel test robot failure regarding KERN_VIRT_SIZE that is
  undefined for nommu config

Alexandre Ghiti (4):
  riscv: Fix is_linear_mapping with recent move of KASAN region
  riscv: Fix config KASAN && SPARSEMEM && !SPARSE_VMEMMAP
  riscv: Fix DEBUG_VIRTUAL false warnings
  riscv: Fix config KASAN && DEBUG_VIRTUAL

 arch/riscv/include/asm/page.h    | 2 +-
 arch/riscv/include/asm/pgtable.h | 1 +
 arch/riscv/mm/Makefile           | 3 +++
 arch/riscv/mm/kasan_init.c       | 3 +--
 arch/riscv/mm/physaddr.c         | 4 +---
 5 files changed, 7 insertions(+), 6 deletions(-)

-- 
2.32.0

