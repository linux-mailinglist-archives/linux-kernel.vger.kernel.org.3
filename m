Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6C74D2559
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 02:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiCIBMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiCIBLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:11:44 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3AA1516B4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 16:54:09 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id n66-20020a254045000000b0062883b59ddbso522961yba.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 16:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=2eLf1OQ5c5M4ayVX+55KychHLqSf2s8rTUtR5N1e2O4=;
        b=mYotAHnmck7cPQSLQ5H1Jgup5Q0G9nVPyWtfD7SnKNQ/M1hTgghhfpZ4cCWtoxTj44
         csktK1vQp32m/Bge+p2XZSFeDfN3BXrGi2ngYB4B65c8GF5Yvc7CLZrTXZ11atQzrGM5
         VjENj2CN3KFi5es5T3m/Q7BW01EhOnrOo2x7oMaydXpG4LIHJd+ec5LbiaMNTwNwIvnl
         oMFKIdT5QiCz69GuODtpKmAewOxPROVTG3nziYa8tllTKYTT3dkOKF/7mIBANAhva48u
         DRpSchfdmuLJQq9gWHowdHZaMNiPSaR1K16OSkOVXkcsbYAcKUyt1NRFc+fCE0Se/+po
         AJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=2eLf1OQ5c5M4ayVX+55KychHLqSf2s8rTUtR5N1e2O4=;
        b=y4JO6FrSIc9m8pt08qOiA9EmH+Y+XNchXUuf53pgyeInO10sFfdAaUwx7CB598uz9q
         ZZBYC09A6SkNhLZCzfaDCL/F7gceREBNb/kSv12+M00G2LPRhm4Ts5h33Y8KDVwDYh23
         BmOdhZnjw3w7GavKqqOIjignedG4CFH7BeRCBgt17YdWG3wQSolZlaFVKdIbQyPCh472
         Jetw+obcnrxAEWU6nCiMtHLq61yReH8p6vLSnU2UtEomRNJJG2kNLtrNKgv6lmp2vtjY
         Spw7l/F4AIfJtMEbgYeqnfLnTEgB8r9yuyUAN7A4BnNIMnmydcuF4JT94pjkFUfQXXA6
         2gwg==
X-Gm-Message-State: AOAM53119doDXcV9QHwQXwkTZ46ACeieRoilhLBSQoVNJKqg9KAh1vnK
        rApoQPZ/QhiaSmMG2eqOcq2zFfSReBI=
X-Google-Smtp-Source: ABdhPJy2qWRKAnebFlR4r0klAb03fdPmcYWhFD9wA2KdO3CK7iDFRKSpNcQybt31JhmXhU2fP2/5pR0E+WE=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:57a6:54a6:aad1:c0a8])
 (user=yuzhao job=sendgmr) by 2002:a81:1d2:0:b0:2dc:5915:661 with SMTP id
 201-20020a8101d2000000b002dc59150661mr15391184ywb.154.1646783324137; Tue, 08
 Mar 2022 15:48:44 -0800 (PST)
Date:   Tue,  8 Mar 2022 16:47:24 -0700
In-Reply-To: <20220308234723.3834941-1-yuzhao@google.com>
Message-Id: <20220308234723.3834941-15-yuzhao@google.com>
Mime-Version: 1.0
References: <20220308234723.3834941-1-yuzhao@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v8 14/14] mm: multi-gen LRU: design doc
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
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
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
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

Add a design doc.

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
Tested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 Documentation/vm/index.rst        |   1 +
 Documentation/vm/multigen_lru.rst | 156 ++++++++++++++++++++++++++++++
 2 files changed, 157 insertions(+)
 create mode 100644 Documentation/vm/multigen_lru.rst

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
index 000000000000..cde60de16621
--- /dev/null
+++ b/Documentation/vm/multigen_lru.rst
@@ -0,0 +1,156 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Multi-Gen LRU
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Design overview
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Objectives
+----------
+The design objectives are:
+
+* Good representation of access recency
+* Try to profit from spatial locality
+* Fast paths to make obvious choices
+* Simple self-correcting heuristics
+
+The representation of access recency is at the core of all LRU
+implementations. In the multi-gen LRU, each generation represents a
+group of pages with similar access recency. Generations establish a
+common frame of reference and therefore help make better choices,
+e.g., between different memcgs on a computer or different computers in
+a data center (for job scheduling).
+
+Exploiting spatial locality improves efficiency when gathering the
+accessed bit. A rmap walk targets a single page and does not try to
+profit from discovering a young PTE. A page table walk can sweep all
+the young PTEs in an address space, but the address space can be too
+large to make a profit. The key is to optimize both methods and use
+them in combination.
+
+Fast paths reduce code complexity and runtime overhead. Unmapped pages
+do not require TLB flushes; clean pages do not require writeback.
+These facts are only helpful when other conditions, e.g., access
+recency, are similar. With generations as a common frame of reference,
+additional factors stand out. But obvious choices might not be good
+choices; thus self-correction is required.
+
+The benefits of simple self-correcting heuristics are self-evident.
+Again, with generations as a common frame of reference, this becomes
+attainable. Specifically, pages in the same generation can be
+categorized based on additional factors, and a feedback loop can
+statistically compare the refault percentages across those categories
+and infer which of them are better choices.
+
+Assumptions
+-----------
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
+   applications usually do not prepare themselves for major page
+   faults like they do for blocked I/O. E.g., GUI applications
+   commonly use dedicated I/O threads to avoid blocking the rendering
+   threads.
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
+``lrugen->min_seq[]`` separately for anon and file types as clean file
+pages can be evicted regardless of swap constraints. These three
+variables are monotonically increasing.
+
+Generation numbers are truncated into ``order_base_2(MAX_NR_GENS+1)``
+bits in order to fit into the gen counter in ``folio->flags``. Each
+truncated generation number is an index to ``lrugen->lists[]``. The
+sliding window technique is used to track at least ``MIN_NR_GENS`` and
+at most ``MAX_NR_GENS`` generations. The gen counter stores a value
+within ``[1, MAX_NR_GENS]`` while a page is on one of
+``lrugen->lists[]``; otherwise it stores zero.
+
+Each generation is divided into multiple tiers. Tiers represent
+different ranges of numbers of accesses through file descriptors. A
+page accessed ``N`` times through file descriptors is in tier
+``order_base_2(N)``. In contrast to moving across generations, which
+requires the LRU lock, moving across tiers only requires operations on
+``folio->flags`` and therefore has a negligible cost. A feedback loop
+modeled after the PID controller monitors refaults over all the tiers
+from anon and file types and decides which tiers from which types to
+evict or protect.
+
+There are two conceptually independent procedures: the aging and the
+eviction. They form a closed-loop system, i.e., the page reclaim.
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
+follows the same steps just described.
+
+Eviction
+--------
+The eviction consumes old generations. Given an ``lruvec``, it
+increments ``min_seq`` when ``lrugen->lists[]`` indexed by
+``min_seq%MAX_NR_GENS`` becomes empty. To select a type and a tier to
+evict from, it first compares ``min_seq[]`` to select the older type.
+If both types are equally old, it selects the one whose first tier has
+a lower refault percentage. The first tier contains single-use
+unmapped clean pages, which are the best bet. The eviction sorts a
+page according to the gen counter if the aging has found this page
+accessed through page tables and updated the gen counter. It also
+moves a page to the next generation, i.e., ``min_seq+1``, if this page
+was accessed multiple times through file descriptors and the feedback
+loop has detected outlying refaults from the tier this page is in. To
+do this, the feedback loop uses the first tier as the baseline, for
+the reason stated earlier.
+
+Summary
+-------
+The multi-gen LRU can be disassembled into the following parts:
+
+* Generations
+* Page table walks
+* Rmap walks
+* Bloom filters
+* The PID controller
+
+The aging and the eviction is a producer-consumer model; specifically,
+the latter drives the former by the sliding window over generations.
+Within the aging, rmap walks drive page table walks by inserting hot
+densely populated page tables to the Bloom filters. Within the
+eviction, the PID controller uses refaults as the feedback to select
+types to evict and tiers to protect.
--=20
2.35.1.616.g0bdcbb4464-goog

