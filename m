Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F694B60E4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 03:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbiBOCTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 21:19:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbiBOCS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 21:18:56 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5238C2C13E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:18:47 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id r9so6081125qta.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=Lxapmp7hvxMfhcEgIR9IOKw4+JdJYHsOl4yuqp6IrFE=;
        b=KammbQQB7R7dcpVFa/OeFRwAi3DqIw3osyJ9PcJUn3GRd6kE34NSu+P4nFNuG4pfDY
         iGaFmYZFOJwOJcOvYp+Vp8DYMJ5hz/ipx5Up784xHTLb7jYSo2zMOZVB2KIkdZThHZhx
         m2Vnvd3Mwvm5P5Gnu8IT46eBeHfiMRey+r0gjyxDehWhxjvcGZqx60ET5YpD3VYT0ehS
         RzTtTEhSAUOh/gVTpmXBGiIsa9ylrILctpkm0Ymmrzuzlp0ImepqEecpEMny6ZvmoQQ2
         KapyAO9cotXHvrwmDb01DlhSQ9ya43UfZ+Vk68sKX7bC/4HpIeXTn+emDiKneuo2LLkJ
         2oYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=Lxapmp7hvxMfhcEgIR9IOKw4+JdJYHsOl4yuqp6IrFE=;
        b=AiO8b7IHG5Mt4adQ3mggBrWXaP9hhjf8dU6Wrr9b0bD8t16dH4MFuCohhhccabLMMC
         Rb2PTHorEDbLx1le9ARXXW66Fysi4OY6cEvQu2r3LVgGpItHheTJ8658LV5AVkyp3MCv
         qIdrSmgC73GUjmd2GvzvzMPDqQU08OZmX8f5gyUcITkGwRJwo+liwsc1rJoGHdeGYvtk
         M0s0zPnUs8XWxoZ0tNdYwtSCjeAqmS9VZ6QQYk5lG/YIKi/Gb6wwP/8d6JTiciee45HK
         flqfGzEPdzx2Ul31ZYIA+lRlfdc9k1arC0TPv9kpddtGUKvkDngQ3OvcrjV7Gsq75Mtx
         x0rw==
X-Gm-Message-State: AOAM530qiWjRq8j6HS1hPALbZB4act+p1qJMRX600IIc/0wnEnoBp2Pr
        9xSZF9dPHgSYEwwqcZz6yY4DOQ==
X-Google-Smtp-Source: ABdhPJzmILMNMpour4YK5+aHp3FRrJ3sl/MFwG0q57Lm5bb6veWgY8T0mK5xdiGd6mw7JDnG+bW1ow==
X-Received: by 2002:a05:622a:487:: with SMTP id p7mr1323742qtx.426.1644891526299;
        Mon, 14 Feb 2022 18:18:46 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c20sm19128387qtb.58.2022.02.14.18.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 18:18:45 -0800 (PST)
Date:   Mon, 14 Feb 2022 18:18:34 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 00/13] mm/munlock: rework of mlock+munlock page handling
Message-ID: <55a49083-37f9-3766-1de9-9feea7428ac@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

I wondered whether to post this munlocking rework in
https://lore.kernel.org/linux-mm/35c340a6-96f-28a0-2b7b-2f9fbddc01f@google.com/

There the discussion was OOM reaping, but the main reason for the rework
has been catastrophic contention on i_mmap_rwsem when exiting from
multiply mlocked files; and frustration with how contorted munlocking is.

tl;dr
 mm/mlock.c                |  637 +++++++++++++++-----------------------
 23 files changed, 514 insertions(+), 780 deletions(-)

v1 of the series was posted on 6 Feb 2022:
https://lore.kernel.org/linux-mm/8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com/
Preview of v2 changed patches 01 04 07 10 11 were posted on 13 Feb 2022.
Here is the full v2 series, in case this is easier to manage:
based again on 5.17-rc2, applies also to -rc3 and -rc4.

Andrew, many thanks for including v1 and fixes in mmotm: please now replace

mm-munlock-delete-page_mlock-and-all-its-works.patch
mm-munlock-delete-foll_mlock-and-foll_populate.patch
mm-munlock-delete-munlock_vma_pages_all-allow-oomreap.patch
mm-munlock-rmap-call-mlock_vma_page-munlock_vma_page.patch
mm-munlock-replace-clear_page_mlock-by-final-clearance.patch
mm-munlock-maintain-page-mlock_count-while-unevictable.patch
mm-munlock-mlock_pte_range-when-mlocking-or-munlocking.patch
mm-migrate-__unmap_and_move-push-good-newpage-to-lru.patch
mm-munlock-delete-smp_mb-from-__pagevec_lru_add_fn.patch
mm-munlock-mlock_page-munlock_page-batch-by-pagevec.patch
mm-munlock-mlock_page-munlock_page-batch-by-pagevec-fix.patch
mm-munlock-mlock_page-munlock_page-batch-by-pagevec-fix-2.patch
mm-munlock-page-migration-needs-mlock-pagevec-drained.patch
mm-thp-collapse_file-do-try_to_unmapttu_batch_flush.patch
mm-thp-shrink_page_list-avoid-splitting-vm_locked-thp.patch

by the following thirteen of v2. As before, some easy fixups will be
needed to apply in mm/huge_memory.c, but otherwise expected to be clean.

Many thanks to Vlastimil Babka for his review of 01 through 11, and
to Matthew Wilcox for graciously volunteering to rebase his over these.

At present there's no update to Documentation/vm/unevictable-lru.rst:
that always needs a different mindset, can follow later, please refer
to commit messages for now.

There are two half-related mm/thp patches at the end: enhancements
we've had for a long time, but needed more after the mlock changes.

01/13 mm/munlock: delete page_mlock() and all its works
02/13 mm/munlock: delete FOLL_MLOCK and FOLL_POPULATE
03/13 mm/munlock: delete munlock_vma_pages_all(), allow oomreap
04/13 mm/munlock: rmap call mlock_vma_page() munlock_vma_page()
05/13 mm/munlock: replace clear_page_mlock() by final clearance
06/13 mm/munlock: maintain page->mlock_count while unevictable
07/13 mm/munlock: mlock_pte_range() when mlocking or munlocking
08/13 mm/migrate: __unmap_and_move() push good newpage to LRU
09/13 mm/munlock: delete smp_mb() from __pagevec_lru_add_fn()
10/13 mm/munlock: mlock_page() munlock_page() batch by pagevec
11/13 mm/munlock: page migration needs mlock pagevec drained
12/13 mm/thp: collapse_file() do try_to_unmap(TTU_BATCH_FLUSH)
13/13 mm/thp: shrink_page_list() avoid splitting VM_LOCKED THP

 include/linux/mm.h        |    2 
 include/linux/mm_inline.h |   11 
 include/linux/mm_types.h  |   19 +
 include/linux/rmap.h      |   23 -
 kernel/events/uprobes.c   |    7 
 mm/gup.c                  |   43 --
 mm/huge_memory.c          |   55 ---
 mm/hugetlb.c              |    4 
 mm/internal.h             |   66 ++-
 mm/khugepaged.c           |   14 
 mm/ksm.c                  |   12 
 mm/madvise.c              |    5 
 mm/memcontrol.c           |    3 
 mm/memory.c               |   45 --
 mm/migrate.c              |   42 +-
 mm/mlock.c                |  637 +++++++++++++++-----------------------
 mm/mmap.c                 |   32 -
 mm/mmzone.c               |    7 
 mm/oom_kill.c             |    2 
 mm/rmap.c                 |  156 ++-------
 mm/swap.c                 |   89 ++---
 mm/userfaultfd.c          |   14 
 mm/vmscan.c               |    6 
 23 files changed, 514 insertions(+), 780 deletions(-)

Hugh
