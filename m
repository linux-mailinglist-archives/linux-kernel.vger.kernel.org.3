Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E70A46AA5B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351466AbhLFV0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:26:32 -0500
Received: from out0.migadu.com ([94.23.1.103]:60238 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350402AbhLFV0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:26:31 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1638825777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bUuIlOralgF5wobuBntA8UszOUI4AIJ5c+Gdq5HnW/w=;
        b=ov4ZlEF7HlHN4qESa77lsG4wrX/EXUpAmXawqVClVAFLyCHdkWGwYFs09sNB3FC9hS/bev
        KKGJT/hyfMp9Z15N98g9Pjw56z18AMYVWJln1MpFMI17UtpgHsU39p8+ZcuDjcaSJVrZp/
        UjyXBGoaPsNIBi8SibBR0OgoAImVHIk=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 00/34] kasan, vmalloc, arm64: add vmalloc tagging support for SW/HW_TAGS
Date:   Mon,  6 Dec 2021 22:22:04 +0100
Message-Id: <cover.1638825394.git.andreyknvl@google.com>
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

The tree with patches is available here:

https://github.com/xairy/linux/tree/up-kasan-vmalloc-tags-v2

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

Changes in v1->v2:
- Move memory init for vmalloc() into vmalloc code for HW_TAGS KASAN.
- Minor fixes and code reshuffling, see patches for lists of changes.

Thanks!

Andrey Konovalov (34):
  kasan, page_alloc: deduplicate should_skip_kasan_poison
  kasan, page_alloc: move tag_clear_highpage out of
    kernel_init_free_pages
  kasan, page_alloc: merge kasan_free_pages into free_pages_prepare
  kasan, page_alloc: simplify kasan_poison_pages call site
  kasan, page_alloc: init memory of skipped pages on free
  kasan: drop skip_kasan_poison variable in free_pages_prepare
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
  kasan, vmalloc, arm64: mark vmalloc mappings as pgprot_tagged
  kasan, vmalloc: don't unpoison VM_ALLOC pages before mapping
  kasan, page_alloc: allow skipping unpoisoning for HW_TAGS
  kasan, page_alloc: allow skipping memory init for HW_TAGS
  kasan, vmalloc: add vmalloc support to HW_TAGS
  kasan: mark kasan_arg_stacktrace as __initdata
  kasan: simplify kasan_init_hw_tags
  kasan: add kasan.vmalloc command line flag
  arm64: select KASAN_VMALLOC for SW/HW_TAGS modes
  kasan: documentation updates
  kasan: improve vmalloc tests

 Documentation/dev-tools/kasan.rst |  17 ++-
 arch/arm64/Kconfig                |   2 +-
 arch/arm64/include/asm/vmalloc.h  |  10 ++
 arch/arm64/kernel/module.c        |   2 +-
 arch/s390/kernel/module.c         |   2 +-
 arch/x86/kernel/module.c          |   2 +-
 include/linux/gfp.h               |  28 +++--
 include/linux/kasan.h             |  91 +++++++++------
 include/linux/vmalloc.h           |  18 ++-
 kernel/fork.c                     |   1 +
 lib/Kconfig.kasan                 |  20 ++--
 lib/test_kasan.c                  | 181 +++++++++++++++++++++++++++++-
 mm/kasan/common.c                 |   4 +-
 mm/kasan/hw_tags.c                | 157 +++++++++++++++++++++-----
 mm/kasan/kasan.h                  |  16 ++-
 mm/kasan/shadow.c                 |  57 ++++++----
 mm/page_alloc.c                   | 150 +++++++++++++++++--------
 mm/vmalloc.c                      |  72 ++++++++++--
 18 files changed, 631 insertions(+), 199 deletions(-)

-- 
2.25.1

