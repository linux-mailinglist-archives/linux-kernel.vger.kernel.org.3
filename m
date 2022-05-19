Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7441652DCCF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243932AbiESSaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243927AbiESSaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:30:06 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AC4EBEB0
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:30:05 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o13-20020a17090a9f8d00b001df3fc52ea7so9490269pjp.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FUYzfmiDx2t3eNvqtBM4IkuZfRBiStdddEtxJ1+Q5P4=;
        b=GCHHR8ZSisnYohqEDPLBYQ3HyYlNXRP543l8qieE+hzqeFk2RzGhvF1IW0gQ/BZvxN
         FYto33uL+FTb4M31UXjjqhG/qBhMj4RgxLqoVeFGDV4E0+ieEpKCASBIzDj153jLrqfe
         k/xETDYLHODUtNDtSn9qJINC44jUfw74udaVmqh6xS/ewHG5y4cSjixM2vkJfhC6Qh4+
         0TOG23hegKwtWQLaqAgoNwo9UcGLD6c8ZnRWX7oCZ3kpHnaJE6L6yP5xfZZUPc6RoDSI
         4tb7CjjVEO2nb4j6N50iAnhCPwMdb49CyBk1thQItcEo4SbvTZDsiq3LIsNOqwlrlVdC
         /M9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FUYzfmiDx2t3eNvqtBM4IkuZfRBiStdddEtxJ1+Q5P4=;
        b=hQW2zw3J2aEq4GRAKCvYyRjiXrK8Paxv4vagE57GJDQccxExkGJRspl5DheJy4PB9Q
         33xXUA1Coi3lic9dZ2IF7nlqCdpZ1KSdwPQN45fnAOP/5jrj+Na4dKbjzZPDpm5v1O50
         PqpFXuG7qaIsBflnBMr9ON6juzDGQxkJnOeEAcf9zJgI0FoI60R2UMUG6TkqdE7uQLOF
         dWJ2S0uRj3VyhpJ70lHWOdoFOjpBj9AVCU5+FHbuurh6XzwcAKH1xngF3BWtJOV4caEo
         V+LB1fDN3U2wWrZ6u0FwIabJlMRba5fi6YYvT0btHR0gR+m/JOQT2qUtdtPhVt0jZXh1
         FU9A==
X-Gm-Message-State: AOAM531RxbADR3ACTyEWcart0U7thI9TJh9s7ERs7NAm1q6NSp/HBvo9
        PKY24KEr8xfKggMtGc3jR6w=
X-Google-Smtp-Source: ABdhPJwp4Jg119KHzbAw6F3jp3rGg9319BFrF5433ADIYxmAsVsWv9pyRUYCnkHI29ja3f53was0Jg==
X-Received: by 2002:a17:903:1c7:b0:161:9d6f:376a with SMTP id e7-20020a17090301c700b001619d6f376amr6024015plh.147.1652985004975;
        Thu, 19 May 2022 11:30:04 -0700 (PDT)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id z5-20020a63e105000000b003c14af505f6sm3884674pgh.14.2022.05.19.11.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 11:30:04 -0700 (PDT)
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Suren Baghdasaryan <surenb@google.com>,
        Chih-En Lin <shiyn.lin@gmail.com>,
        Colin Cross <ccross@google.com>,
        Feng Tang <feng.tang@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mike Rapoport <rppt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, Kaiyang Zhao <zhao776@purdue.edu>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Jim Huang <jserv.tw@gmail.com>
Subject: [RFC PATCH 0/6] Introduce Copy-On-Write to Page Table
Date:   Fri, 20 May 2022 02:31:21 +0800
Message-Id: <20220519183127.3909598-1-shiyn.lin@gmail.com>
X-Mailer: git-send-email 2.36.1
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

When creating the user process, it usually uses the Copy-On-Write (COW)
mechanism to save the memory usage and the cost of time for copying.
COW defers the work of copying private memory and shares it across the
processes as read-only. If either process wants to write in these
memories, it will page fault and copy the shared memory, so the process
will now get its private memory right here, which is called break COW.

Presently this kind of technology is only used as the mapping memory.
It still needs to copy the entire page table from the parent.
It might cost a lot of time and memory to copy each page table when the
parent already has a lot of page tables allocated. For example, here is
the state table for mapping the 1 GB memory of forking.

	    mmap before fork         mmap after fork
MemTotal:       32746776 kB             32746776 kB
MemFree:        31468152 kB             31463244 kB
AnonPages:       1073836 kB              1073628 kB
Mapped:            39520 kB                39992 kB
PageTables:         3356 kB                 5432 kB

This patch introduces Copy-On-Write to the page table. This patch only
implements the COW on the PTE level. It's based on the paper
On-Demand Fork [1]. Summary of the implementation for the paper:

- Only implements the COW to the anonymous mapping
- Only do COW to the PTE table which the range is all covered by a
  single VMA.
- Use the reference count to control the COW PTE table lifetime.
  Decrease the counter when breaking COW or dereference the COW PTE
  table. When the counter reduces to zero, free the PTE table.

The paper is based on v5.6, and this patch is for v.518-rc6. And, this
patch has some differences between the version of paper. To reduce the
work of duplicating page tables, I adapted the restriction of the COW
page table. Excluding the brk and shared memory, it will do the COW to
all the PTE tables. With a reference count of one, we reuse the table
when breaking COW. To handle the page table state of the process, it
adds the ownership of the COW PTE table. It uses the address of the PMD
index for the ownership of the PTE table to maintain the COW PTE table
state to the RSS and pgtable_bytes.

If we do the COW to the PTE table once as the time we touch the PMD
entry, it cannot preserves the reference count of the COW PTE table.
Since the address range of VMA may overlap the PTE table, the copying
function will use VMA to travel the page table for copying it.
So it may increase the reference count of the COW PTE table multiple
times in one COW page table forking. Generically it will only increase
once time as the child reference it. To solve this problem, it needs to
check the destination of PMD entry does exist. And the reference count
of the source PTE table is more than one before doing the COW.

Here is the patch of a state table for mapping the 1 GB memory of
forking.

            mmap before fork         mmap after fork
MemTotal:       32746776 kB             32746776 kB
MemFree:        31471324 kB             31468888 kB
AnonPages:       1073628 kB              1073660 kB
Mapped:            39264 kB                39504 kB
PageTables:         3304 kB                 3396 kB

TODO list:
- Handle the swap
- Rewrite the TLB flush for zapping the COW PTE table.
- Experiment COW to the entire page table. (Now just for PTE level)
- Bug in some case from copy_pte_range()::vm_normal_page()::print_bad_pte().
- Bug of Bad RSS counter in multiple times COW PTE table forking.

[1] https://dl.acm.org/doi/10.1145/3447786.3456258

This patch is based on v5.18-rc6.

---

Chih-En Lin (6):
  mm: Add a new mm flag for Copy-On-Write PTE table
  mm: clone3: Add CLONE_COW_PGTABLE flag
  mm, pgtable: Add ownership for the PTE table
  mm: Add COW PTE fallback function
  mm, pgtable: Add the reference counter for COW PTE
  mm: Expand Copy-On-Write to PTE table

 include/linux/mm.h             |   2 +
 include/linux/mm_types.h       |   2 +
 include/linux/pgtable.h        |  44 +++++
 include/linux/sched/coredump.h |   5 +-
 include/uapi/linux/sched.h     |   1 +
 kernel/fork.c                  |   6 +-
 mm/memory.c                    | 329 ++++++++++++++++++++++++++++++---
 mm/mmap.c                      |   4 +
 mm/mremap.c                    |   5 +
 9 files changed, 373 insertions(+), 25 deletions(-)

-- 
2.36.1

