Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950364AB254
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 22:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238716AbiBFV17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 16:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiBFV16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 16:27:58 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0F7C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 13:27:53 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id t1so4485302qtq.13
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 13:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=zqtCWZR8fUoymI1gulqeyWRyxqO7AdNIEXaSeKYJoAM=;
        b=kqO/dGkR7ZxLu6uzdv1UcwYe2PBhojIF61LbLnI2gnfowsuH9YQ4GKiePJOm4UV4S0
         kI1vcq7XCbJ8uGmdEN7B74kHKjJVfgORIcqXAaRxBvUiK0GyTtQF4dxjjvnDfkW5H0wA
         pmU1AfpN15yefaFud3l6uSYL3PqmoXTzn76klqjoMzVLwb8cY1U6RmfR5nIsZKLlw4SF
         4h2uXpkQI9NTF/Wan27jjVvQcbKD3sYStczmq3zuYF+36sFhdFw6elhvxV2Kfvbv+hmW
         F8JoQqC2vMQ/Es6+jfyIhrbET7x/Q8vLFKjkauyo3/mO2AwntPC3xZFWdJw+B4Kl01cV
         Cx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=zqtCWZR8fUoymI1gulqeyWRyxqO7AdNIEXaSeKYJoAM=;
        b=L3UxPy1MeSSwC+UsOnrrYDMyJVs8WLywURMM7l0VM+q9px2+3/scn9/xpvK7QSDSvL
         M2xRliQ1aKJiTzNKIV/nYkjh3zCXsZPpfap398bk1y9WRYSJDuXl3vMMoGiLhvH4QZhq
         dNHs0Sjrd2ZQZsfLd0FaRO6/JmoM3TNxnOui0fO0UZmeXY4PR0cwGR3k2U+QRD5ZD8uW
         6WAyxadHvlriqNqLALntI7LG+xUB59Rne8hMyhyUOf4ryXljF4cUgIiGirX1C4VUgKm4
         z6ktng+vZcz/Je1zy20QL44DzOxRY8Br5mOQZooHQaWt+6680cmReYBfea4YXAxHX+zK
         vZ6Q==
X-Gm-Message-State: AOAM533kDiRyGYn+zIGcC1GdJ9U8H7d93Rbux3aKOvj7UpwatnQa8lxf
        ibCMX2oy9q+CLm87M/VI0RQaxw==
X-Google-Smtp-Source: ABdhPJz5Tu/r8mnrKYdIrl/e/+oMWgxDcrxeVttb0N1e1D1ZK6ss3WrC744gLeUyabu6oL9mLlNQfQ==
X-Received: by 2002:ac8:5aca:: with SMTP id d10mr6091273qtd.565.1644182872541;
        Sun, 06 Feb 2022 13:27:52 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b9sm4372948qkj.24.2022.02.06.13.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 13:27:52 -0800 (PST)
Date:   Sun, 6 Feb 2022 13:27:41 -0800 (PST)
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
Subject: [PATCH 00/13] mm/munlock: rework of mlock+munlock page handling
Message-ID: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com>
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

Here it is based on 5.17-rc2, applies also to -rc3, almost cleanly to
mmotm 2022-02-03-21-58 (needs two easy fixups in mm/huge_memory.c); but
likely to conflict (I hope not fundamentally) with several concurrent
large patchsets.

tl;dr
 mm/mlock.c  |  634 +++++++++++++++-----------------------
 23 files changed, 510 insertions(+), 779 deletions(-)

In my own opinion, this is ready to go in: that whatever its defects,
it's a big practical improvement over what's presently there.  Others
may differ; and it may be too much to arrive at a quick opinion on.
My hope is that it will strike a chord with some who have laboured in
this area in the past: I'll be short of time to do much more with it,
so maybe someone else could take over if necessary.

At present there's no update to Documentation/vm/unevictable-lru.rst:
that always needs a different mindset, can follow later, please refer
to commit messages for now.

There are two half-related mm/thp patches at the end: enhancements
we've had for a long time, but more suited after the mlock changes.

01/13 mm/munlock: delete page_mlock() and all its works
02/13 mm/munlock: delete FOLL_MLOCK and FOLL_POPULATE gupflags
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
 mm/internal.h             |   64 ++-
 mm/khugepaged.c           |   14 
 mm/ksm.c                  |   12 
 mm/madvise.c              |    5 
 mm/memcontrol.c           |    3 
 mm/memory.c               |   45 --
 mm/migrate.c              |   42 +-
 mm/mlock.c                |  634 +++++++++++++++-----------------------
 mm/mmap.c                 |   32 -
 mm/mmzone.c               |    7 
 mm/oom_kill.c             |    2 
 mm/rmap.c                 |  156 ++-------
 mm/swap.c                 |   89 ++---
 mm/userfaultfd.c          |   14 
 mm/vmscan.c               |    6 
 23 files changed, 510 insertions(+), 779 deletions(-)

Hugh
