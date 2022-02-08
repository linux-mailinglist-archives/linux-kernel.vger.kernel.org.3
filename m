Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED5D4AD315
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349196AbiBHIU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349217AbiBHITs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:19:48 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3073CC03FEEF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:19:45 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v10-20020a05690204ca00b0061dd584eb83so7598526ybs.21
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=YVgph1S7S/KhnDZWPK/21Kb0iFZ85VY+kaUoodkvSfs=;
        b=LPUUnvP3KiRJOtBK7ehNIOditrPQVm4qb0xako5BDNxKqOTpybfI/rbGsv6Ba4LKZV
         7Vr2/sPq4jXjAPIdnVQ/L2eRjyqHDRO1txkk08bZmum/YLFGtOzKoNedOH+pYN+5L0ls
         ZoBU71ZVqCRbOCvegQZ9X9N5xDhwygiRk4X87KJK7elMXhqbCdXO0LMcMgvNSEmbE10e
         w0w58bxVzDHqb/kEfqSMjn92eikullUCwz6NbYbkR9imkFIUZ8QInzDmS4rqRr7grEjI
         PuyNC9Z/vaakRjNuybtQXQhwtx3VPBbNjAYHAOIIf8JWobHcgVnzzXQT3w7pCqFEIVf7
         xBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=YVgph1S7S/KhnDZWPK/21Kb0iFZ85VY+kaUoodkvSfs=;
        b=eep6nMGH/oij0hoIUjKhNc0M0k4uzn+Wf9cvEbYEVMWgulfwQys1nAiDNKaxD5k6W9
         3hIN0WdhM1rB7q8QNLqPmxVR8BDU9SHDY4OT9gSkIX3Rb3L8sUHWTqb8WieXoEhGzqrr
         oJIszHyM8Galx4VCoCHwsdSgp7FtT2aQVOGSzo4E8TXlrvemyW8l3d+OTbwHWl4XCEot
         sKNzoOGvkbk3Zh00xqxbcNM9op9WWcI4pLchg07Ht2N3ZLCXJ/zr20JedjJ0DbWvC5p/
         2W7u1SjBcU8oc+bg3EIVH6slVp0SgBvhYeqBGHn8qtwGm4xdKsAaSx4mKOEOdmUY4G1t
         0kog==
X-Gm-Message-State: AOAM530HF5kitPVJ9O3Tt8YCqcS6vdgHUs6TItm5G3zUdDI1uUfwwQOE
        doX8kcmEbhsYj7nyyz5ZvTa70zQo5Tk=
X-Google-Smtp-Source: ABdhPJxHfrvdjw/ioGL/CY9F6iMqAfiU4rpWvGJpBLTOZu3nfaPCcOelWryg2+GLyTOhlUoLP6GGbhLqyxo=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:5f31:19c3:21f5:7300])
 (user=yuzhao job=sendgmr) by 2002:a81:7e06:: with SMTP id o6mr3685138ywn.13.1644308384378;
 Tue, 08 Feb 2022 00:19:44 -0800 (PST)
Date:   Tue,  8 Feb 2022 01:19:02 -0700
In-Reply-To: <20220208081902.3550911-1-yuzhao@google.com>
Message-Id: <20220208081902.3550911-13-yuzhao@google.com>
Mime-Version: 1.0
References: <20220208081902.3550911-1-yuzhao@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v7 12/12] mm: multigenerational LRU: documentation
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Larabel <Michael@michaellarabel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Yu Zhao <yuzhao@google.com>, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        "=?UTF-8?q?Holger=20Hoffst=C3=A4tte?=" 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a design doc and an admin guide.

Signed-off-by: Yu Zhao <yuzhao@google.com>
Acked-by: Brian Geffon <bgeffon@google.com>
Acked-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
Acked-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Acked-by: Steven Barrett <steven@liquorix.net>
Acked-by: Suleiman Souhlal <suleiman@google.com>
Tested-by: Daniel Byrne <djbyrne@mtu.edu>
Tested-by: Donald Carr <d@chaos-reins.com>
Tested-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com>
Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
Tested-by: Shuang Zhai <szhai2@cs.rochester.edu>
Tested-by: Sofia Trinh <sofia.trinh@edi.works>
---
 Documentation/admin-guide/mm/index.rst        |   1 +
 Documentation/admin-guide/mm/multigen_lru.rst | 121 ++++++++++++++
 Documentation/vm/index.rst                    |   1 +
 Documentation/vm/multigen_lru.rst             | 152 ++++++++++++++++++
 4 files changed, 275 insertions(+)
 create mode 100644 Documentation/admin-guide/mm/multigen_lru.rst
 create mode 100644 Documentation/vm/multigen_lru.rst

diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-g=
uide/mm/index.rst
index c21b5823f126..2cf5bae62036 100644
--- a/Documentation/admin-guide/mm/index.rst
+++ b/Documentation/admin-guide/mm/index.rst
@@ -32,6 +32,7 @@ the Linux memory management.
    idle_page_tracking
    ksm
    memory-hotplug
+   multigen_lru
    nommu-mmap
    numa_memory_policy
    numaperf
diff --git a/Documentation/admin-guide/mm/multigen_lru.rst b/Documentation/=
admin-guide/mm/multigen_lru.rst
new file mode 100644
index 000000000000..16a543c8b886
--- /dev/null
+++ b/Documentation/admin-guide/mm/multigen_lru.rst
@@ -0,0 +1,121 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Multigenerational LRU
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Quick start
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Build configurations
+--------------------
+:Required: Set ``CONFIG_LRU_GEN=3Dy``.
+
+:Optional: Set ``CONFIG_LRU_GEN_ENABLED=3Dy`` to enable the
+ multigenerational LRU by default.
+
+Runtime configurations
+----------------------
+:Required: Write ``y`` to ``/sys/kernel/mm/lru_gen/enable`` if
+ ``CONFIG_LRU_GEN_ENABLED=3Dn``.
+
+This file accepts different values to enabled or disabled the
+following features:
+
+=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D
+Values Features
+=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D
+0x0001 the multigenerational LRU
+0x0002 clear the accessed bit in leaf page table entries **in large
+       batches**, when MMU sets it (e.g., on x86)
+0x0004 clear the accessed bit in non-leaf page table entries **as
+       well**, when MMU sets it (e.g., on x86)
+[yYnN] apply to all the features above
+=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D
+
+E.g.,
+::
+
+    echo y >/sys/kernel/mm/lru_gen/enabled
+    cat /sys/kernel/mm/lru_gen/enabled
+    0x0007
+    echo 5 >/sys/kernel/mm/lru_gen/enabled
+    cat /sys/kernel/mm/lru_gen/enabled
+    0x0005
+
+Most users should enable or disable all the features unless some of
+them have unforeseen side effects.
+
+Recipes
+=3D=3D=3D=3D=3D=3D=3D
+Personal computers
+------------------
+Personal computers are more sensitive to thrashing because it can
+cause janks (lags when rendering UI) and negatively impact user
+experience. The multigenerational LRU offers thrashing prevention to
+the majority of laptop and desktop users who don't have oomd.
+
+:Thrashing prevention: Write ``N`` to
+ ``/sys/kernel/mm/lru_gen/min_ttl_ms`` to prevent the working set of
+ ``N`` milliseconds from getting evicted. The OOM killer is triggered
+ if this working set can't be kept in memory. Based on the average
+ human detectable lag (~100ms), ``N=3D1000`` usually eliminates
+ intolerable janks due to thrashing. Larger values like ``N=3D3000``
+ make janks less noticeable at the risk of premature OOM kills.
+
+Data centers
+------------
+Data centers want to optimize job scheduling (bin packing) to improve
+memory utilizations. Job schedulers need to estimate whether a server
+can allocate a certain amount of memory for a new job, and this step
+is known as working set estimation, which doesn't impact the existing
+jobs running on this server. They also want to attempt freeing some
+cold memory from the existing jobs, and this step is known as proactive
+reclaim, which improves the chance of landing a new job successfully.
+
+:Optional: Increase ``CONFIG_NR_LRU_GENS`` to support more generations
+ for working set estimation and proactive reclaim.
+
+:Debugfs interface: ``/sys/kernel/debug/lru_gen`` has the following
+ format:
+ ::
+
+   memcg  memcg_id  memcg_path
+     node  node_id
+       min_gen  birth_time  anon_size  file_size
+       ...
+       max_gen  birth_time  anon_size  file_size
+
+ ``min_gen`` is the oldest generation number and ``max_gen`` is the
+ youngest generation number. ``birth_time`` is in milliseconds.
+ ``anon_size`` and ``file_size`` are in pages. The youngest generation
+ represents the group of the MRU pages and the oldest generation
+ represents the group of the LRU pages. For working set estimation, a
+ job scheduler writes to this file at a certain time interval to
+ create new generations, and it ranks available servers based on the
+ sizes of their cold memory defined by this time interval. For
+ proactive reclaim, a job scheduler writes to this file before it
+ tries to land a new job, and if it fails to materialize the cold
+ memory without impacting the existing jobs, it retries on the next
+ server according to the ranking result.
+
+ This file accepts commands in the following subsections. Multiple
+ command lines are supported, so does concatenation with delimiters
+ ``,`` and ``;``.
+
+ ``/sys/kernel/debug/lru_gen_full`` contains additional stats for
+ debugging.
+
+:Working set estimation: Write ``+ memcg_id node_id max_gen
+ [can_swap [full_scan]]`` to ``/sys/kernel/debug/lru_gen`` to invoke
+ the aging. It scans PTEs for hot pages and promotes them to the
+ youngest generation ``max_gen``. Then it creates a new generation
+ ``max_gen+1``. Set ``can_swap`` to ``1`` to scan for hot anon pages
+ when swap is off. Set ``full_scan`` to ``0`` to reduce the overhead
+ as well as the coverage when scanning PTEs.
+
+:Proactive reclaim: Write ``- memcg_id node_id min_gen [swappiness
+ [nr_to_reclaim]]`` to ``/sys/kernel/debug/lru_gen`` to invoke the
+ eviction. It evicts generations less than or equal to ``min_gen``.
+ ``min_gen`` should be less than ``max_gen-1`` as ``max_gen`` and
+ ``max_gen-1`` aren't fully aged and therefore can't be evicted. Use
+ ``nr_to_reclaim`` to limit the number of pages to evict.
diff --git a/Documentation/vm/index.rst b/Documentation/vm/index.rst
index 44365c4574a3..b48434300226 100644
--- a/Documentation/vm/index.rst
+++ b/Documentation/vm/index.rst
@@ -25,6 +25,7 @@ algorithms.  If you are looking for advice on simply allo=
cating memory, see the
    ksm
    memory-model
    mmu_notifier
+   multigen_lru
    numa
    overcommit-accounting
    page_migration
diff --git a/Documentation/vm/multigen_lru.rst b/Documentation/vm/multigen_=
lru.rst
new file mode 100644
index 000000000000..42a277b4e74b
--- /dev/null
+++ b/Documentation/vm/multigen_lru.rst
@@ -0,0 +1,152 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Multigenerational LRU
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Design overview
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+The design objectives are:
+
+* Good representation of access recency
+* Try to profit from spatial locality
+* Fast paths to make obvious choices
+* Simple self-correcting heuristics
+
+The representation of access recency is at the core of all LRU
+implementations. In the multigenerational LRU, each generation
+represents a group of pages with similar access recency (a timestamp).
+Generations establish a common frame of reference and therefore help
+make better choices, e.g., between different memcgs on a computer or
+different computers in a data center (for job scheduling).
+
+Exploiting spatial locality improves the efficiency when gathering the
+accessed bit. A rmap walk targets a single page and doesn't try to
+profit from discovering a young PTE. A page table walk can sweep all
+the young PTEs in an address space, but its search space can be too
+large to make a profit. The key is to optimize both methods and use
+them in combination.
+
+Fast paths reduce code complexity and runtime overhead. Unmapped pages
+don't require TLB flushes; clean pages don't require writeback. These
+facts are only helpful when other conditions, e.g., access recency,
+are similar. With generations as a common frame of reference,
+additional factors stand out. But obvious choices might not be good
+choices; thus self-correction is required.
+
+The benefits of simple self-correcting heuristics are self-evident.
+Again, with generations as a common frame of reference, this becomes
+attainable. Specifically, pages in the same generation are categorized
+based on additional factors, and a feedback loop statistically
+compares the refault percentages across those categories and infers
+which of them are better choices.
+
+The protection of hot pages and the selection of cold pages are based
+on page access channels and patterns. There are two access channels:
+
+* Accesses through page tables
+* Accesses through file descriptors
+
+The protection of the former channel is by design stronger because:
+
+1. The uncertainty in determining the access patterns of the former
+   channel is higher due to the approximation of the accessed bit.
+2. The cost of evicting the former channel is higher due to the TLB
+   flushes required and the likelihood of encountering the dirty bit.
+3. The penalty of underprotecting the former channel is higher because
+   applications usually don't prepare themselves for major page faults
+   like they do for blocked I/O. E.g., GUI applications commonly use
+   dedicated I/O threads to avoid blocking the rendering threads.
+
+There are also two access patterns:
+
+* Accesses exhibiting temporal locality
+* Accesses not exhibiting temporal locality
+
+For the reasons listed above, the former channel is assumed to follow
+the former pattern unless ``VM_SEQ_READ`` or ``VM_RAND_READ`` is
+present, and the latter channel is assumed to follow the latter
+pattern unless outlying refaults have been observed.
+
+Workflow overview
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Evictable pages are divided into multiple generations for each
+``lruvec``. The youngest generation number is stored in
+``lrugen->max_seq`` for both anon and file types as they are aged on
+an equal footing. The oldest generation numbers are stored in
+``lrugen->min_seq[]`` separately for anon and file types as clean
+file pages can be evicted regardless of swap constraints. These three
+variables are monotonically increasing.
+
+Generation numbers are truncated into ``order_base_2(MAX_NR_GENS+1)``
+bits in order to fit into the gen counter in ``folio->flags``. Each
+truncated generation number is an index to ``lrugen->lists[]``. The
+sliding window technique is used to track at least ``MIN_NR_GENS`` and
+at most ``MAX_NR_GENS`` generations. The gen counter stores
+``(seq%MAX_NR_GENS)+1`` while a page is on one of ``lrugen->lists[]``;
+otherwise it stores zero.
+
+Each generation is divided into multiple tiers. Tiers represent
+different ranges of numbers of accesses through file descriptors.
+A page accessed ``N`` times through file descriptors is in tier
+``order_base_2(N)``. In contrast to moving across generations which
+requires the LRU lock, moving across tiers only requires operations on
+``folio->flags`` and therefore has a negligible cost. A feedback loop
+modeled after the PID controller monitors refaults over all the tiers
+from anon and file types and decides which tiers from which types to
+evict or promote.
+
+There are two conceptually independent processes (as in the
+manufacturing process): the aging and the eviction. They form a
+closed-loop system, i.e., the page reclaim.
+
+Aging
+-----
+The aging produces young generations. Given an ``lruvec``, it
+increments ``max_seq`` when ``max_seq-min_seq+1`` approaches
+``MIN_NR_GENS``. The aging promotes hot pages to the youngest
+generation when it finds them accessed through page tables; the
+demotion of cold pages happens consequently when it increments
+``max_seq``. The aging uses page table walks and rmap walks to find
+young PTEs. For the former, it iterates ``lruvec_memcg()->mm_list``
+and calls ``walk_page_range()`` with each ``mm_struct`` on this list
+to scan PTEs. On finding a young PTE, it clears the accessed bit and
+updates the gen counter of the page mapped by this PTE to
+``(max_seq%MAX_NR_GENS)+1``. After each iteration of this list, it
+increments ``max_seq``. For the latter, when the eviction walks the
+rmap and finds a young PTE, the aging scans the adjacent PTEs and
+follows the same steps.
+
+Eviction
+--------
+The eviction consumes old generations. Given an ``lruvec``, it
+increments ``min_seq`` when ``lrugen->lists[]`` indexed by
+``min_seq%MAX_NR_GENS`` becomes empty. To select a type and a tier to
+evict from, it first compares ``min_seq[]`` to select the older type.
+If they are equal, it selects the type whose first tier has a lower
+refault percentage. The first tier contains single-use unmapped clean
+pages, which are the best bet. The eviction sorts a page according to
+the gen counter if the aging has found this page accessed through page
+tables and updated the gen counter. It also promotes a page to the
+next generation, i.e., ``min_seq+1`` rather than ``max_seq``, if this
+page was accessed multiple times through file descriptors and the
+feedback loop has detected outlying refaults from the tier this page
+is in, using the first tier as a baseline.
+
+Summary
+-------
+The multigenerational LRU can be disassembled into the following
+components:
+
+* Generations
+* Page table walks
+* Rmap walks
+* Bloom filters
+* PID controller
+
+Between the aging and the eviction (processes), the latter drives the
+former by the sliding window over generations. Within the aging, rmap
+walks drive page table walks by inserting hot dense page tables to the
+Bloom filters. Within the eviction, the PID controller uses refaults
+as the feedback to turn on or off the eviction of certain types and
+tiers.
--=20
2.35.0.263.gb82422642f-goog

