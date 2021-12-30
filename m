Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DF0481F79
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 20:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241772AbhL3TMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 14:12:49 -0500
Received: from out0.migadu.com ([94.23.1.103]:57533 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240271AbhL3TMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 14:12:48 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1640891566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BxXk+lPKIYPO8LJ4HIf1Lr8qWbs9W4BbC4wotT6dbm0=;
        b=np1HMaAQZPYNwvU62GN3RNmvX13DQu36fSpW2YJX1JlXslXRTM6HSnklPY2GonotI9oA45
        Ze9Yac1qapgh0Z1/Oc0e7ue8Nap1+3/Gqt2JbbzLGBovKXWzOM0CBN5lap7uw3SGgbvmcA
        luzUQfPyEuo7439rwSkqNC7Lxqoko5s=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm v5 00/39] kasan, vmalloc, arm64: add vmalloc tagging support for SW/HW_TAGS
Date:   Thu, 30 Dec 2021 20:12:02 +0100
Message-Id: <cover.1640891329.git.andreyknvl@google.com>
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

https://github.com/xairy/linux/tree/up-kasan-vmalloc-tags-v5-akpm

About half of patches are cleanups I went for along the way. None of
them seem to be important enough to go through stable, so I decided
not to split them out into separate patches/series.

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

Thanks!

Changes in v4->v5:
- Rebase onto fresh mm.
- Mention optimization intention in the comment for __GFP_ZEROTAGS.
- Replace "kasan: simplify kasan_init_hw_tags" with "kasan: clean up
  feature flags for HW_TAGS mode".
- Use true as kasan_flag_vmalloc static key default.
- Cosmetic changes to __def_gfpflag_names_kasan and __GFP_BITS_SHIFT.

Changes in v3->v4:
- Rebase onto fresh mm.
- Rename KASAN_VMALLOC_NOEXEC to KASAN_VMALLOC_PROT_NORMAL.
- Compare prot with PAGE_KERNEL instead of using pgprot_nx() to
  indentify normal non-executable mappings.
- Rename arch_vmalloc_pgprot_modify() to arch_vmap_pgprot_tagged().
- Move checks from arch_vmap_pgprot_tagged() to __vmalloc_node_range()
  as the same condition is used for other things in subsequent patches.
- Use proper kasan_hw_tags_enabled() checks instead of
  IS_ENABLED(CONFIG_KASAN_HW_TAGS).
- Set __GFP_SKIP_KASAN_UNPOISON and __GFP_SKIP_ZERO flags instead of
  resetting.
- Only define KASAN GFP flags when when HW_TAGS KASAN is enabled.
- Move setting KASAN GFP flags to __vmalloc_node_range() and do it
  only for normal non-executable mapping when HW_TAGS KASAN is enabled.
- Add new GFP flags to include/trace/events/mmflags.h.
- Don't forget to save tagged addr to vm_struct->addr for VM_ALLOC
  so that find_vm_area(addr)->addr == addr for vmalloc().
- Reset pointer tag in change_memory_common().
- Add test checks for set_memory_*() on vmalloc() allocations.
- Minor patch descriptions and comments fixes.

Changes in v2->v3:
- Rebase onto mm.
- New patch: "kasan, arm64: reset pointer tags of vmapped stacks".
- New patch: "kasan, vmalloc: don't tag executable vmalloc allocations".
- New patch: "kasan, arm64: don't tag executable vmalloc allocations".
- Allowing enabling KASAN_VMALLOC with SW/HW_TAGS is moved to
  "kasan: allow enabling KASAN_VMALLOC and SW/HW_TAGS", as this can only
  be done once executable allocations are no longer tagged.
- Minor fixes, see patches for lists of changes.

Changes in v1->v2:
- Move memory init for vmalloc() into vmalloc code for HW_TAGS KASAN.
- Minor fixes and code reshuffling, see patches for lists of changes.

Acked-by: Marco Elver <elver@google.com>

Andrey Konovalov (39):
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
  kasan, page_alloc: rework kasan_unpoison_pages call site
  kasan: clean up metadata byte definitions
  kasan: define KASAN_VMALLOC_INVALID for SW_TAGS
  kasan, x86, arm64, s390: rename functions for modules shadow
  kasan, vmalloc: drop outdated VM_KASAN comment
  kasan: reorder vmalloc hooks
  kasan: add wrappers for vmalloc hooks
  kasan, vmalloc: reset tags in vmalloc functions
  kasan, fork: reset pointer tags of vmapped stacks
  kasan, arm64: reset pointer tags of vmapped stacks
  kasan, vmalloc: add vmalloc tagging for SW_TAGS
  kasan, vmalloc, arm64: mark vmalloc mappings as pgprot_tagged
  kasan, vmalloc: unpoison VM_ALLOC pages after mapping
  kasan, mm: only define ___GFP_SKIP_KASAN_POISON with HW_TAGS
  kasan, page_alloc: allow skipping unpoisoning for HW_TAGS
  kasan, page_alloc: allow skipping memory init for HW_TAGS
  kasan, vmalloc: add vmalloc tagging for HW_TAGS
  kasan, vmalloc: only tag normal vmalloc allocations
  kasan, arm64: don't tag executable vmalloc allocations
  kasan: mark kasan_arg_stacktrace as __initdata
  kasan: clean up feature flags for HW_TAGS mode
  kasan: add kasan.vmalloc command line flag
  kasan: allow enabling KASAN_VMALLOC and SW/HW_TAGS
  arm64: select KASAN_VMALLOC for SW/HW_TAGS modes
  kasan: documentation updates
  kasan: improve vmalloc tests

 Documentation/dev-tools/kasan.rst   |  17 ++-
 arch/arm64/Kconfig                  |   2 +-
 arch/arm64/include/asm/vmalloc.h    |   6 +
 arch/arm64/include/asm/vmap_stack.h |   5 +-
 arch/arm64/kernel/module.c          |   5 +-
 arch/arm64/mm/pageattr.c            |   2 +-
 arch/arm64/net/bpf_jit_comp.c       |   3 +-
 arch/s390/kernel/module.c           |   2 +-
 arch/x86/kernel/module.c            |   2 +-
 include/linux/gfp.h                 |  35 +++--
 include/linux/kasan.h               |  97 +++++++++-----
 include/linux/vmalloc.h             |  18 +--
 include/trace/events/mmflags.h      |  14 +-
 kernel/fork.c                       |   1 +
 kernel/scs.c                        |   4 +-
 lib/Kconfig.kasan                   |  20 +--
 lib/test_kasan.c                    | 189 ++++++++++++++++++++++++++-
 mm/kasan/common.c                   |   4 +-
 mm/kasan/hw_tags.c                  | 193 ++++++++++++++++++++++------
 mm/kasan/kasan.h                    |  18 ++-
 mm/kasan/shadow.c                   |  63 +++++----
 mm/page_alloc.c                     | 157 +++++++++++++++-------
 mm/vmalloc.c                        |  99 +++++++++++---
 23 files changed, 736 insertions(+), 220 deletions(-)

-- 
2.25.1

