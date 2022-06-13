Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFBD54A09F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351624AbiFMU61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350558AbiFMUxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:53:18 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F6CCE06
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:15:25 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655151323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NgWb1VypNdq0w5pu2JKIcUVqOUrKW+cW7ICESNAaLXg=;
        b=ArpbYjGfMZCWQq5EaDyLZEZeEQ9OgLgcZ6i1UsjL9TlIoy5Ws3X2IjJEKDa05dVoL4Q84C
        ZLi8Qq3BdwsCPvJ2R5PRZfNUapP8gzSFRsp5H4OyIbUs2SC+lV/llMupf1gpWFGZyuBqP5
        F19ADWzLTve9DNrmU5hDDaFJK/ZCt6A=
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
Subject: [PATCH 00/32] kasan: switch tag-based modes to stack ring from per-object metadata
Date:   Mon, 13 Jun 2022 22:13:51 +0200
Message-Id: <cover.1655150842.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

The ring buffer is lock-free.

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

The current implementation of the stack ring uses a single ring buffer for
the whole kernel. This might lead to contention due to atomic accesses to
the ring buffer index on multicore systems.

It is unclear to me whether the performance impact from this contention
is significant compared to the slowdown introduced by collecting stack
traces.

While these patches are being reviewed, I will do some tests on the arm64
hardware that I have. However, I do not have a large multicore arm64
system to do proper measurements.

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

Andrey Konovalov (32):
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
  kasan: simplify invalid-free reporting
  kasan: cosmetic changes in report.c
  kasan: use kasan_addr_to_slab in print_address_description
  kasan: move kasan_addr_to_slab to common.c
  kasan: make kasan_addr_to_page static
  kasan: simplify print_report
  kasan: introduce complete_report_info
  kasan: fill in cache and object in complete_report_info
  kasan: rework function arguments in report.c
  kasan: introduce kasan_complete_mode_report_info
  kasan: implement stack ring for tag-based modes
  kasan: better identify bug types for tag-based modes

 include/linux/kasan.h     |  55 +++++-------
 include/linux/slab.h      |   2 +-
 lib/Kconfig.kasan         |   8 --
 mm/kasan/common.c         | 173 ++++----------------------------------
 mm/kasan/generic.c        | 154 ++++++++++++++++++++++++++++++---
 mm/kasan/kasan.h          | 138 ++++++++++++++++++++----------
 mm/kasan/report.c         | 130 +++++++++++++---------------
 mm/kasan/report_generic.c |  45 +++++++++-
 mm/kasan/report_tags.c    | 114 ++++++++++++++++++-------
 mm/kasan/tags.c           |  61 +++++++-------
 10 files changed, 491 insertions(+), 389 deletions(-)

-- 
2.25.1

