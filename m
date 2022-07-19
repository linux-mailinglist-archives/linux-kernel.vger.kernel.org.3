Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DCB578ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbiGSAK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236453AbiGSAKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:10:51 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD9533A31
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:10:50 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658189418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=W6bMOfDQQrC3t+AXklBVrLreFIQ/eHKpGdhG0Mq/jjQ=;
        b=AQGV5pN45heU2T6zsptJT5C1mLwWrRpLzz28LXm/+CmeDIuYqJPxhE3ar/ksSw1TkJyY8j
        rNtgQzNn9yS76nfo43MZTcQmccklJx3U6n2lbpDnTc/I8MRCVj2EjZ27e5d0jkad72/k9U
        8XmN00hx3iPcZWZw6r49iGUPyVkAvJk=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm v2 00/33] kasan: switch tag-based modes to stack ring from per-object metadata
Date:   Tue, 19 Jul 2022 02:09:40 +0200
Message-Id: <cover.1658189199.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

This series makes the tag-based KASAN modes use a ring buffer for storing
stack depot handles for alloc/free stack traces for slab objects instead
of per-object metadata. This ring buffer is referred to as the stack ring.

On each alloc/free of a slab object, the tagged address of the object and
the current stack trace are recorded in the stack ring.

On each bug report, if the accessed address belongs to a slab object, the
stack ring is scanned for matching entries. The newest entries are used to
print the alloc/free stack traces in the report: one entry for alloc and
one for free.

The advantages of this approach over storing stack trace handles in
per-object metadata with the tag-based KASAN modes:

- Allows to find relevant stack traces for use-after-free bugs without
  using quarantine for freed memory. (Currently, if the object was
  reallocated multiple times, the report contains the latest alloc/free
  stack traces, not necessarily the ones relevant to the buggy allocation.)
- Allows to better identify and mark use-after-free bugs, effectively
  making the CONFIG_KASAN_TAGS_IDENTIFY functionality always-on.
- Has fixed memory overhead.

The disadvantage:

- If the affected object was allocated/freed long before the bug happened
  and the stack trace events were purged from the stack ring, the report
  will have no stack traces.

Discussion
==========

The proposed implementation of the stack ring uses a single ring buffer for
the whole kernel. This might lead to contention due to atomic accesses to
the ring buffer index on multicore systems.

At this point, it is unknown whether the performance impact from this
contention would be significant compared to the slowdown introduced by
collecting stack traces due to the planned changes to the latter part,
see the section below.

For now, the proposed implementation is deemed to be good enough, but this
might need to be revisited once the stack collection becomes faster.

A considered alternative is to keep a separate ring buffer for each CPU
and then iterate over all of them when printing a bug report. This approach
requires somehow figuring out which of the stack rings has the freshest
stack traces for an object if multiple stack rings have them.

Further plans
=============

This series is a part of an effort to make KASAN stack trace collection
suitable for production. This requires stack trace collection to be fast
and memory-bounded.

The planned steps are:

1. Speed up stack trace collection (potentially, by using SCS;
   patches on-hold until steps #2 and #3 are completed).
2. Keep stack trace handles in the stack ring (this series).
3. Add a memory-bounded mode to stack depot or provide an alternative
   memory-bounded stack storage.
4. Potentially, implement stack trace collection sampling to minimize
   the performance impact.

Thanks!

---

Changes v1->v2:
- Rework synchronization in the stack ring implementation.
- Dynamically allocate stack ring based on the kasan.stack_ring_size
  command-line parameter.
- Multiple less significant changes, see the notes in patches for details.

Andrey Konovalov (33):
  kasan: check KASAN_NO_FREE_META in __kasan_metadata_size
  kasan: rename kasan_set_*_info to kasan_save_*_info
  kasan: move is_kmalloc check out of save_alloc_info
  kasan: split save_alloc_info implementations
  kasan: drop CONFIG_KASAN_TAGS_IDENTIFY
  kasan: introduce kasan_print_aux_stacks
  kasan: introduce kasan_get_alloc_track
  kasan: introduce kasan_init_object_meta
  kasan: clear metadata functions for tag-based modes
  kasan: move kasan_get_*_meta to generic.c
  kasan: introduce kasan_requires_meta
  kasan: introduce kasan_init_cache_meta
  kasan: drop CONFIG_KASAN_GENERIC check from kasan_init_cache_meta
  kasan: only define kasan_metadata_size for Generic mode
  kasan: only define kasan_never_merge for Generic mode
  kasan: only define metadata offsets for Generic mode
  kasan: only define metadata structs for Generic mode
  kasan: only define kasan_cache_create for Generic mode
  kasan: pass tagged pointers to kasan_save_alloc/free_info
  kasan: move kasan_get_alloc/free_track definitions
  kasan: cosmetic changes in report.c
  kasan: use virt_addr_valid in kasan_addr_to_page/slab
  kasan: use kasan_addr_to_slab in print_address_description
  kasan: make kasan_addr_to_page static
  kasan: simplify print_report
  kasan: introduce complete_report_info
  kasan: fill in cache and object in complete_report_info
  kasan: rework function arguments in report.c
  kasan: introduce kasan_complete_mode_report_info
  kasan: implement stack ring for tag-based modes
  kasan: support kasan.stacktrace for SW_TAGS
  kasan: dynamically allocate stack ring entries
  kasan: better identify bug types for tag-based modes

 Documentation/dev-tools/kasan.rst |  15 ++-
 include/linux/kasan.h             |  55 ++++------
 include/linux/slab.h              |   2 +-
 lib/Kconfig.kasan                 |   8 --
 mm/kasan/common.c                 | 175 +++---------------------------
 mm/kasan/generic.c                | 154 ++++++++++++++++++++++++--
 mm/kasan/hw_tags.c                |  39 +------
 mm/kasan/kasan.h                  | 173 ++++++++++++++++++++---------
 mm/kasan/report.c                 | 117 +++++++++-----------
 mm/kasan/report_generic.c         |  45 +++++++-
 mm/kasan/report_tags.c            | 128 +++++++++++++++++-----
 mm/kasan/sw_tags.c                |   5 +-
 mm/kasan/tags.c                   | 138 ++++++++++++++++++-----
 13 files changed, 620 insertions(+), 434 deletions(-)

-- 
2.25.1

