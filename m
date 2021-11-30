Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A7A464064
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 22:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344242AbhK3VoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:44:07 -0500
Received: from out0.migadu.com ([94.23.1.103]:57160 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236406AbhK3VoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 16:44:02 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1638308438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Rcspyw3aJSs9x/mVwJKJ/FdDOElM4iaddbIoQBCce4s=;
        b=gni20/GnmdqNCy/t7JZgLCPTaUWKmqmwegB9OeXRMlKYtEeroZthHsvwu+NnCfAKsJdgrr
        UQ9gav+YKIGqDmWpPO5WPb3a0BkAhEvPAkKIyg2J2mqK770A/PYB5XsVGwf8h5w1GShu1h
        hejV8Bh2Dj3+cJ4AEK5F6PxyLvxERxo=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 00/31] kasan, vmalloc, arm64: add vmalloc tagging support for SW/HW_TAGS
Date:   Tue, 30 Nov 2021 22:39:06 +0100
Message-Id: <cover.1638308023.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Hi,

This patchset adds vmalloc tagging support for SW_TAGS and HW_TAGS
KASAN modes.

About half of patches are cleanups I went for along the way. None of
them seem to be important enough to go through stable, so I decided
not to split them out into separate patches/series.

I'll keep the patchset based on the mainline for now. Once the
high-level issues are resolved, I'll rebase onto mm - there might be
a few conflicts right now.

The patchset is partially based on an early version of the HW_TAGS
patchset by Vincenzo that had vmalloc support. Thus, I added a
Co-developed-by tag into a few patches.

SW_TAGS vmalloc tagging support is straightforward. It reuses all of
the generic KASAN machinery, but uses shadow memory to store tags
instead of magic values. Naturally, vmalloc tagging requires adding
a few kasan_reset_tag() annotations to the vmalloc code.

HW_TAGS vmalloc tagging support stands out. HW_TAGS KASAN is based on
Arm MTE, which can only assigns tags to physical memory. As a result,
HW_TAGS KASAN only tags vmalloc() allocations, which are backed by
page_alloc memory. It ignores vmap() and others.

Two things about the patchset that might be questionable, and I'd like
to get input on:

1. In this version of the pathset, if both HW_TAGS KASAN and memory
   initialization are enabled, the memory for vmalloc() allocations is
   initialized by page_alloc, while the tags are assigned in vmalloc.
   Initially I thought that moving memory initialization into vmalloc
   would be confusing, but I don't have any good arguments to support
   that. So unless anyone has objecttions, I will move memory
   initialization for HW_TAGS KASAN into vmalloc in v2.

2. In this version of the patchset, when VMAP_STACK is enabled, pointer
   tags of stacks allocated via vmalloc() are reset, see the "kasan,
   fork: don't tag stacks allocated with vmalloc" patch. However,
   allowing sp to be tagged works just fine in my testing setup. Does
   anyone has an idea of why having a tagged sp in the kernel could be
   bad? If not, I can drop the mentioned patch.

Thanks!

Andrey Konovalov (31):
  kasan, page_alloc: deduplicate should_skip_kasan_poison
  kasan, page_alloc: move tag_clear_highpage out of
    kernel_init_free_pages
  kasan, page_alloc: merge kasan_free_pages into free_pages_prepare
  kasan, page_alloc: simplify kasan_poison_pages call site
  kasan, page_alloc: init memory of skipped pages on free
  mm: clarify __GFP_ZEROTAGS comment
  kasan: only apply __GFP_ZEROTAGS when memory is zeroed
  kasan, page_alloc: refactor init checks in post_alloc_hook
  kasan, page_alloc: merge kasan_alloc_pages into post_alloc_hook
  kasan, page_alloc: combine tag_clear_highpage calls in post_alloc_hook
  kasan, page_alloc: move SetPageSkipKASanPoison in post_alloc_hook
  kasan, page_alloc: move kernel_init_free_pages in post_alloc_hook
  kasan, page_alloc: simplify kasan_unpoison_pages call site
  kasan: clean up metadata byte definitions
  kasan: define KASAN_VMALLOC_INVALID for SW_TAGS
  kasan, x86, arm64, s390: rename functions for modules shadow
  kasan, vmalloc: drop outdated VM_KASAN comment
  kasan: reorder vmalloc hooks
  kasan: add wrappers for vmalloc hooks
  kasan, vmalloc: reset tags in vmalloc functions
  kasan, fork: don't tag stacks allocated with vmalloc
  kasan, vmalloc: add vmalloc support to SW_TAGS
  kasan, arm64: allow KASAN_VMALLOC with SW_TAGS
  kasan, vmalloc, arm64: mark vmalloc mappings as pgprot_tagged
  kasan, vmalloc: don't unpoison VM_ALLOC pages before mapping
  kasan, page_alloc: allow skipping unpoisoning for HW_TAGS
  kasan, vmalloc: add vmalloc support to HW_TAGS
  kasan: add kasan.vmalloc command line flag
  kasan, arm64: allow KASAN_VMALLOC with HW_TAGS
  kasan: documentation updates
  kasan: improve vmalloc tests

 Documentation/dev-tools/kasan.rst |  17 ++-
 arch/arm64/Kconfig                |   2 +-
 arch/arm64/include/asm/vmalloc.h  |  10 ++
 arch/arm64/kernel/module.c        |   2 +-
 arch/s390/kernel/module.c         |   2 +-
 arch/x86/kernel/module.c          |   2 +-
 include/linux/gfp.h               |  17 ++-
 include/linux/kasan.h             |  90 +++++++++------
 include/linux/vmalloc.h           |  18 ++-
 kernel/fork.c                     |   1 +
 lib/Kconfig.kasan                 |  20 ++--
 lib/test_kasan.c                  | 181 +++++++++++++++++++++++++++++-
 mm/kasan/common.c                 |   4 +-
 mm/kasan/hw_tags.c                | 142 +++++++++++++++++++----
 mm/kasan/kasan.h                  |  16 ++-
 mm/kasan/shadow.c                 |  54 +++++----
 mm/page_alloc.c                   | 138 +++++++++++++++--------
 mm/vmalloc.c                      |  65 +++++++++--
 18 files changed, 597 insertions(+), 184 deletions(-)

-- 
2.25.1

