Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BDE56D378
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 05:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiGKDql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 23:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGKDqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 23:46:39 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C9C12A9C;
        Sun, 10 Jul 2022 20:46:38 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id r6so964693plg.3;
        Sun, 10 Jul 2022 20:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qmBhjPhdel7Ory0h+LtHmaoT8CpQHwHtjRSzAczsGS8=;
        b=UY5oZcsZHFdGH9KcetDN8dqr2Mf0qiwqMqlLdkQ+0PNZPPWK8nytWfBrVg68lCyEAN
         jrVXhCD+p/9vhueaNcEswnstaaqhbi96KvKB1URC0IEAGTbb7bQ3L2sJKv8fP4/q3fdz
         qnhDuiRe5eJunmVyfmUC7y6G6huMy6rKKY2vpo7MUN+GN+8Yg69bDGSpiExtmJG6nmwc
         HGrj6W5Zy4EILKOUdTTBtFEUayRpo9P6vRZIShjByCsnQmdWy7cHknQIBwTn6y+6JaHt
         7Jslc7TiuDWWVL3D1WVwoeXWF4xp0s+zIBfTFhbW89tgNx9jEYuB6VyOj7QkOyyjH+tF
         MEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qmBhjPhdel7Ory0h+LtHmaoT8CpQHwHtjRSzAczsGS8=;
        b=lW5XsM5Ug36xO2IG5WEDJ05OaLK0lJUFbyFcnZ+M9IrMk7oKMUvxPcYektebMRiiWl
         6kgcY/6e7/mqfr05N47emBXPmi3GAaG5AMNL0e6chQInCkHBmsg/KzwbpYmYZvBZtRPH
         HrtKYMl/SrENWMvE2yxVjCC0nrK77Svtih0104wgJ962pKeo0KA7MxNOOlgH1L+361sF
         plWcSucp8trLUL0f3d6ygFnfFPB89aR1ZArQ+s5GjlzHshFyzxaGdtz5EhEMb6uAbhct
         S8o40QAGJ/JiJFSsPg1yrkCMGJnRqxN6jKvQIz2Gt2N2L4OP381u4klGqu+RbP8taPgT
         qLYw==
X-Gm-Message-State: AJIora9nE8xLPrP8dHA3WUflrwnWfEU5CkMwnt+n+tGg2g+/imONtWp+
        PvL2bclOOjtx5p/zl6xzvBk=
X-Google-Smtp-Source: AGRyM1uXqBxzEnWgTK+S6bqpqoqltGNYamS7CTaFawotYp6lLuQkplQPx4DboSyk03U1rFf9/7Vqqw==
X-Received: by 2002:a17:90b:1b48:b0:1ef:a90d:eae1 with SMTP id nv8-20020a17090b1b4800b001efa90deae1mr15050227pjb.68.1657511198328;
        Sun, 10 Jul 2022 20:46:38 -0700 (PDT)
Received: from localhost.localdomain (47-72-206-164.dsl.dyn.ihug.co.nz. [47.72.206.164])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902eccd00b001664d88aab3sm3447949plh.240.2022.07.10.20.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 20:46:37 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, arnd@arndb.de, linux-kernel@vger.kernel.org,
        darren@os.amperecomputing.com, yangyicong@hisilicon.com,
        huzhanyuan@oppo.com, lipeifeng@oppo.com, zhangshiming@oppo.com,
        guojian@oppo.com, realmz6@gmail.com, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        Barry Song <21cnbao@gmail.com>
Subject: [PATCH v2 0/4] mm: arm64: bring up BATCHED_UNMAP_TLB_FLUSH
Date:   Mon, 11 Jul 2022 15:46:11 +1200
Message-Id: <20220711034615.482895-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Though ARM64 has the hardware to do tlb shootdown, the hardware
broadcasting is not free.
A simplest micro benchmark shows even on snapdragon 888 with only
8 cores, the overhead for ptep_clear_flush is huge even for paging
out one page mapped by only one process:
5.36%  a.out    [kernel.kallsyms]  [k] ptep_clear_flush

While pages are mapped by multiple processes or HW has more CPUs,
the cost should become even higher due to the bad scalability of
tlb shootdown.

The same benchmark can result in 16.99% CPU consumption on ARM64
server with around 100 cores according to Yicong's test on patch
4/4.

This patchset leverages the existing BATCHED_UNMAP_TLB_FLUSH by
1. only send tlbi instructions in the first stage -
	arch_tlbbatch_add_mm()
2. wait for the completion of tlbi by dsb while doing tlbbatch
	sync in arch_tlbbatch_flush()
My testing on snapdragon shows the overhead of ptep_clear_flush
is removed by the patchset. The micro benchmark becomes 5% faster
even for one page mapped by single process on snapdragon 888.


-v2:
1. Collected Yicong's test result on kunpeng920 ARM64 server;
2. Removed the redundant vma parameter in arch_tlbbatch_add_mm()
   according to the comments of Peter Zijlstra and Dave Hansen
3. Added ARCH_HAS_MM_CPUMASK rather than checking if mm_cpumask
   is empty according to the comments of Nadav Amit

Thanks, Yicong, Peter, Dave and Nadav for your testing or reviewing
, and comments.

-v1:
https://lore.kernel.org/lkml/20220707125242.425242-1-21cnbao@gmail.com/

Barry Song (4):
  Revert "Documentation/features: mark BATCHED_UNMAP_TLB_FLUSH doesn't
    apply to ARM64"
  mm: rmap: Allow platforms without mm_cpumask to defer TLB flush
  mm: rmap: Extend tlbbatch APIs to fit new platforms
  arm64: support batched/deferred tlb shootdown during page reclamation

 Documentation/features/arch-support.txt       |  1 -
 .../features/vm/TLB/arch-support.txt          |  2 +-
 arch/arm/Kconfig                              |  1 +
 arch/arm64/Kconfig                            |  1 +
 arch/arm64/include/asm/tlbbatch.h             | 12 ++++++++++
 arch/arm64/include/asm/tlbflush.h             | 23 +++++++++++++++++--
 arch/loongarch/Kconfig                        |  1 +
 arch/mips/Kconfig                             |  1 +
 arch/openrisc/Kconfig                         |  1 +
 arch/powerpc/Kconfig                          |  1 +
 arch/riscv/Kconfig                            |  1 +
 arch/s390/Kconfig                             |  1 +
 arch/um/Kconfig                               |  1 +
 arch/x86/Kconfig                              |  1 +
 arch/x86/include/asm/tlbflush.h               |  3 ++-
 mm/Kconfig                                    |  3 +++
 mm/rmap.c                                     | 14 +++++++----
 17 files changed, 59 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/include/asm/tlbbatch.h

-- 
2.25.1

