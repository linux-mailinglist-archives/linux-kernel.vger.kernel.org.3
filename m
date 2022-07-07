Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC4E56A2DD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbiGGMx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235856AbiGGMxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:53:04 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5BB2C678;
        Thu,  7 Jul 2022 05:53:04 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q82so11168027pgq.6;
        Thu, 07 Jul 2022 05:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1HOT8eT9LJMvE08pzscJQsZxewmGGQ7hUQZcMynRv0U=;
        b=E+tBAHKbYBb1jyLJZwkH0wefRhu9LBtW28jrUfYjKXn65diHTNvv068WhUeaNGioO5
         4lJmab0dNgevmRk0aajh6aNmoH6aY88oTD+s+d6JBjJSCxRhy1bzM2WTgfLZJdeCBQTO
         5DIRzjZrDeUoz9GX9SIZ45mQAvhzo8CzRZQEx7e9PbpAuqZ6mn7ZQ3aZrfiL/NMyjAZI
         VOHIW0ZeCdxb1oNrRfSKmME3juksIpNzrQ4fpPzqw1zb5lODDJ+ZqxPeMqS2nCMP6Hmi
         ALs+X8EQDoGXFs0vIM212wNczouRDzaMUIpM9ogIH0f/M+CPjNzwrZjx4nwuduqmOpRV
         +7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1HOT8eT9LJMvE08pzscJQsZxewmGGQ7hUQZcMynRv0U=;
        b=gI/nst4YBI7u5OVl4eioPmA0wSC9jyaq0ivAsU/MDbOSMQEsTvFWr7an4CYgsVxOMH
         7CbA0xMOe7uUZlxz1FkOcI73fR9gDgqNGhbLwMeMIrsPM2AjhUbeG86XotFIPPbtiiVK
         h4xKwNWTqBb9Kk4PCFOfyg9UATdqA3w6YJbQwbOEBO/9X+PGgMTKkXPyye9HbW6EsF/x
         0sZmidDF5bW6CHQ2eZpwg61rZ4kRTJLXhyi8gUwysPK5faxAzH5BrnuNh+56+WAYOgtp
         CmavKbX5waHguDiKMXPKlhZVr+2489Id3Le0NZg7j6fVOG5U/STZULoIBQvZtrSXbQio
         Ez4g==
X-Gm-Message-State: AJIora/edxczt3QhDG63g4OOWbyBEi54blwSmuUG5MQ8jTEH9zm3K13B
        0l1iWhpQaFW2WyzZkwE0VKA=
X-Google-Smtp-Source: AGRyM1sl4VKGZh3qbbhRsLLlluOZCr006j4y/s4lIPsX2UllxFxD81/fcATU0Wpwicb9MsZ3+B8cMw==
X-Received: by 2002:a17:90b:33ca:b0:1ec:c617:9660 with SMTP id lk10-20020a17090b33ca00b001ecc6179660mr5091908pjb.95.1657198383576;
        Thu, 07 Jul 2022 05:53:03 -0700 (PDT)
Received: from localhost.localdomain (47-72-206-164.dsl.dyn.ihug.co.nz. [47.72.206.164])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709027e4b00b0016a3b5a46f0sm27907831pln.241.2022.07.07.05.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 05:53:02 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, arnd@arndb.de, linux-kernel@vger.kernel.org,
        darren@os.amperecomputing.com, yangyicong@hisilicon.com,
        huzhanyuan@oppo.com, lipeifeng@oppo.com, zhangshiming@oppo.com,
        guojian@oppo.com, realmz6@gmail.com, Barry Song <21cnbao@gmail.com>
Subject: [PATCH 0/4] mm: arm64: bring up BATCHED_UNMAP_TLB_FLUSH
Date:   Fri,  8 Jul 2022 00:52:38 +1200
Message-Id: <20220707125242.425242-1-21cnbao@gmail.com>
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

Though ARM64 has the hardware to do tlb shootdown, it is not free.
A simplest micro benchmark shows even on snapdragon 888 with only
8 cores, the overhead for ptep_clear_flush is huge even for paging
out one page mapped by only one process:
5.36%  a.out    [kernel.kallsyms]  [k] ptep_clear_flush

While pages are mapped by multiple processes or HW has more CPUs,
the cost should become even higher due to the bad scalability of
tlb shootdown.

This patchset leverages the existing BATCHED_UNMAP_TLB_FLUSH by
1. only send tlbi instructions in the first stage -
	arch_tlbbatch_add_mm()
2. wait for the completion of tlbi by dsb while doing tlbbatch
	sync in arch_tlbbatch_flush()
My testing on snapdragon shows the overhead of ptep_clear_flush
is removed by the patchset. The micro benchmark becomes 5% faster
even for one page mapped by single process on snapdragon 888.

While believing the micro benchmark in 4/4 will perform better
on arm64 servers, I don't have a hardware to test. Thus,
Hi Yicong,
Would you like to run the same test in 4/4 on Kunpeng920?
Hi Darren,
Would you like to run the same test in 4/4 on Ampere's ARM64 server?
Remember to enable zRAM swap device so that pageout can actually
work for the micro benchmark.
thanks!

Barry Song (4):
  Revert "Documentation/features: mark BATCHED_UNMAP_TLB_FLUSH doesn't
    apply to ARM64"
  mm: rmap: Allow platforms without mm_cpumask to defer TLB flush
  mm: rmap: Extend tlbbatch APIs to fit new platforms
  arm64: support batched/deferred tlb shootdown during page reclamation

 Documentation/features/arch-support.txt       |  1 -
 .../features/vm/TLB/arch-support.txt          |  2 +-
 arch/arm64/Kconfig                            |  1 +
 arch/arm64/include/asm/tlbbatch.h             | 12 +++++++++++
 arch/arm64/include/asm/tlbflush.h             | 13 ++++++++++++
 arch/x86/include/asm/tlbflush.h               |  4 +++-
 mm/rmap.c                                     | 21 +++++++++++++------
 7 files changed, 45 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/include/asm/tlbbatch.h

-- 
2.25.1

