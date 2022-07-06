Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC0A5690F2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbiGFRng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbiGFRnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:43:17 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052522AE0A;
        Wed,  6 Jul 2022 10:43:08 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id he28so19263609qtb.13;
        Wed, 06 Jul 2022 10:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bsiYdF140lek56kOGdYEMP+oPunyoPAlImPHAu3g5u8=;
        b=NPXXmNmhnTAUw7ICcNGeIxJ5vsU42BuzCHVIw7U0wgmWSIUhHiiX76DVJhin01Ae6J
         VtrgTgrULN0cyGFDKEr1KiuC3D1M8jD3Nev3SWq2Hc7Cnf6B+a2/GH/n5mpf1hIgdeaD
         LbIEk4LmlYJU/7REGKX8ygv9rEInbkb0SrYgVDfimCUaLQccTYkc0ixsbJvAjoM/xFpX
         XtiNJ8cf5bVFAugBOHbDa1Ts5+q54HlwmDnACyfSFwErtPNgLj4TnDlb0xF0tK+rgY7D
         mdmAgXnbigaTLd1Nad4oG+UeSpx7S7YX3ofYoDllgY6j+FgFHqKXlfqPOSwfMQjHx+EX
         zvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bsiYdF140lek56kOGdYEMP+oPunyoPAlImPHAu3g5u8=;
        b=qmK55jncjvDU2QgV9wnDDADLN0rn/z1a9CURiaZza9yo9zGOqyCjeBtk3+qGY61xNM
         l9QvQ/vr4oacn1wamZUWN5RgnW+N+/veRSYQ+cS588D+xLPeSrvpdRpZCdhRS9lE3WQW
         CObmAyKIM7fC4qLxMYwqkmpM4qv5a2D1h3Q1pjyTdcfdIBbSuqq6jq7g2npNZuUsEcVx
         RF5PFE1RS6lmhIZ2aSrc+zokIkaxnSj+6IrF9GhuITSPqqYohwxu1ZHoqKhmqz5td5yI
         e8RJsuyVHgglRJqOqWd5SIt8D50P9jwCbwHfl80psonIWteoLUqI/82WZ9RNsZRyQtzT
         zdqw==
X-Gm-Message-State: AJIora8YaY/PhFSGxPo/l9KJcyp1yXcCAjL0cySrhZtV55w1sBykture
        Jb775hg4UkdhlMP0iEA+qY9DCAFAvnJs4A==
X-Google-Smtp-Source: AGRyM1u3Eg279VZtdb+HrzmXr37fexjkVU9Kw1aFwkdrskBr5dQ42vlXQmrHIwx7jOCWelAxyW3I8A==
X-Received: by 2002:a0c:f40c:0:b0:472:ff75:49ce with SMTP id h12-20020a0cf40c000000b00472ff7549cemr10840543qvl.91.1657129385794;
        Wed, 06 Jul 2022 10:43:05 -0700 (PDT)
Received: from localhost (c-69-254-185-160.hsd1.ar.comcast.net. [69.254.185.160])
        by smtp.gmail.com with ESMTPSA id j4-20020a05620a410400b006a6278a2b31sm20362880qko.75.2022.07.06.10.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 10:43:04 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 08/10] headers/deps: mm: Split <linux/gfp_types.h> out of <linux/gfp.h>
Date:   Wed,  6 Jul 2022 10:42:51 -0700
Message-Id: <20220706174253.4175492-9-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220706174253.4175492-1-yury.norov@gmail.com>
References: <20220706174253.4175492-1-yury.norov@gmail.com>
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

From: Ingo Molnar <mingo@kernel.org>

This is a much smaller header.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/gfp.h       | 345 +------------------------------------
 include/linux/gfp_types.h | 348 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 350 insertions(+), 343 deletions(-)
 create mode 100644 include/linux/gfp_types.h

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 52f2c873a7d4..f314be58fa77 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -2,354 +2,13 @@
 #ifndef __LINUX_GFP_H
 #define __LINUX_GFP_H
 
+#include <linux/gfp_types.h>
+
 #include <linux/mmzone.h>
 #include <linux/topology.h>
 
-/* The typedef is in types.h but we want the documentation here */
-#if 0
-/**
- * typedef gfp_t - Memory allocation flags.
- *
- * GFP flags are commonly used throughout Linux to indicate how memory
- * should be allocated.  The GFP acronym stands for get_free_pages(),
- * the underlying memory allocation function.  Not every GFP flag is
- * supported by every function which may allocate memory.  Most users
- * will want to use a plain ``GFP_KERNEL``.
- */
-typedef unsigned int __bitwise gfp_t;
-#endif
-
 struct vm_area_struct;
 
-/*
- * In case of changes, please don't forget to update
- * include/trace/events/mmflags.h and tools/perf/builtin-kmem.c
- */
-
-/* Plain integer GFP bitmasks. Do not use this directly. */
-#define ___GFP_DMA		0x01u
-#define ___GFP_HIGHMEM		0x02u
-#define ___GFP_DMA32		0x04u
-#define ___GFP_MOVABLE		0x08u
-#define ___GFP_RECLAIMABLE	0x10u
-#define ___GFP_HIGH		0x20u
-#define ___GFP_IO		0x40u
-#define ___GFP_FS		0x80u
-#define ___GFP_ZERO		0x100u
-#define ___GFP_ATOMIC		0x200u
-#define ___GFP_DIRECT_RECLAIM	0x400u
-#define ___GFP_KSWAPD_RECLAIM	0x800u
-#define ___GFP_WRITE		0x1000u
-#define ___GFP_NOWARN		0x2000u
-#define ___GFP_RETRY_MAYFAIL	0x4000u
-#define ___GFP_NOFAIL		0x8000u
-#define ___GFP_NORETRY		0x10000u
-#define ___GFP_MEMALLOC		0x20000u
-#define ___GFP_COMP		0x40000u
-#define ___GFP_NOMEMALLOC	0x80000u
-#define ___GFP_HARDWALL		0x100000u
-#define ___GFP_THISNODE		0x200000u
-#define ___GFP_ACCOUNT		0x400000u
-#define ___GFP_ZEROTAGS		0x800000u
-#ifdef CONFIG_KASAN_HW_TAGS
-#define ___GFP_SKIP_ZERO		0x1000000u
-#define ___GFP_SKIP_KASAN_UNPOISON	0x2000000u
-#define ___GFP_SKIP_KASAN_POISON	0x4000000u
-#else
-#define ___GFP_SKIP_ZERO		0
-#define ___GFP_SKIP_KASAN_UNPOISON	0
-#define ___GFP_SKIP_KASAN_POISON	0
-#endif
-#ifdef CONFIG_LOCKDEP
-#define ___GFP_NOLOCKDEP	0x8000000u
-#else
-#define ___GFP_NOLOCKDEP	0
-#endif
-/* If the above are modified, __GFP_BITS_SHIFT may need updating */
-
-/*
- * Physical address zone modifiers (see linux/mmzone.h - low four bits)
- *
- * Do not put any conditional on these. If necessary modify the definitions
- * without the underscores and use them consistently. The definitions here may
- * be used in bit comparisons.
- */
-#define __GFP_DMA	((__force gfp_t)___GFP_DMA)
-#define __GFP_HIGHMEM	((__force gfp_t)___GFP_HIGHMEM)
-#define __GFP_DMA32	((__force gfp_t)___GFP_DMA32)
-#define __GFP_MOVABLE	((__force gfp_t)___GFP_MOVABLE)  /* ZONE_MOVABLE allowed */
-#define GFP_ZONEMASK	(__GFP_DMA|__GFP_HIGHMEM|__GFP_DMA32|__GFP_MOVABLE)
-
-/**
- * DOC: Page mobility and placement hints
- *
- * Page mobility and placement hints
- * ---------------------------------
- *
- * These flags provide hints about how mobile the page is. Pages with similar
- * mobility are placed within the same pageblocks to minimise problems due
- * to external fragmentation.
- *
- * %__GFP_MOVABLE (also a zone modifier) indicates that the page can be
- * moved by page migration during memory compaction or can be reclaimed.
- *
- * %__GFP_RECLAIMABLE is used for slab allocations that specify
- * SLAB_RECLAIM_ACCOUNT and whose pages can be freed via shrinkers.
- *
- * %__GFP_WRITE indicates the caller intends to dirty the page. Where possible,
- * these pages will be spread between local zones to avoid all the dirty
- * pages being in one zone (fair zone allocation policy).
- *
- * %__GFP_HARDWALL enforces the cpuset memory allocation policy.
- *
- * %__GFP_THISNODE forces the allocation to be satisfied from the requested
- * node with no fallbacks or placement policy enforcements.
- *
- * %__GFP_ACCOUNT causes the allocation to be accounted to kmemcg.
- */
-#define __GFP_RECLAIMABLE ((__force gfp_t)___GFP_RECLAIMABLE)
-#define __GFP_WRITE	((__force gfp_t)___GFP_WRITE)
-#define __GFP_HARDWALL   ((__force gfp_t)___GFP_HARDWALL)
-#define __GFP_THISNODE	((__force gfp_t)___GFP_THISNODE)
-#define __GFP_ACCOUNT	((__force gfp_t)___GFP_ACCOUNT)
-
-/**
- * DOC: Watermark modifiers
- *
- * Watermark modifiers -- controls access to emergency reserves
- * ------------------------------------------------------------
- *
- * %__GFP_HIGH indicates that the caller is high-priority and that granting
- * the request is necessary before the system can make forward progress.
- * For example, creating an IO context to clean pages.
- *
- * %__GFP_ATOMIC indicates that the caller cannot reclaim or sleep and is
- * high priority. Users are typically interrupt handlers. This may be
- * used in conjunction with %__GFP_HIGH
- *
- * %__GFP_MEMALLOC allows access to all memory. This should only be used when
- * the caller guarantees the allocation will allow more memory to be freed
- * very shortly e.g. process exiting or swapping. Users either should
- * be the MM or co-ordinating closely with the VM (e.g. swap over NFS).
- * Users of this flag have to be extremely careful to not deplete the reserve
- * completely and implement a throttling mechanism which controls the
- * consumption of the reserve based on the amount of freed memory.
- * Usage of a pre-allocated pool (e.g. mempool) should be always considered
- * before using this flag.
- *
- * %__GFP_NOMEMALLOC is used to explicitly forbid access to emergency reserves.
- * This takes precedence over the %__GFP_MEMALLOC flag if both are set.
- */
-#define __GFP_ATOMIC	((__force gfp_t)___GFP_ATOMIC)
-#define __GFP_HIGH	((__force gfp_t)___GFP_HIGH)
-#define __GFP_MEMALLOC	((__force gfp_t)___GFP_MEMALLOC)
-#define __GFP_NOMEMALLOC ((__force gfp_t)___GFP_NOMEMALLOC)
-
-/**
- * DOC: Reclaim modifiers
- *
- * Reclaim modifiers
- * -----------------
- * Please note that all the following flags are only applicable to sleepable
- * allocations (e.g. %GFP_NOWAIT and %GFP_ATOMIC will ignore them).
- *
- * %__GFP_IO can start physical IO.
- *
- * %__GFP_FS can call down to the low-level FS. Clearing the flag avoids the
- * allocator recursing into the filesystem which might already be holding
- * locks.
- *
- * %__GFP_DIRECT_RECLAIM indicates that the caller may enter direct reclaim.
- * This flag can be cleared to avoid unnecessary delays when a fallback
- * option is available.
- *
- * %__GFP_KSWAPD_RECLAIM indicates that the caller wants to wake kswapd when
- * the low watermark is reached and have it reclaim pages until the high
- * watermark is reached. A caller may wish to clear this flag when fallback
- * options are available and the reclaim is likely to disrupt the system. The
- * canonical example is THP allocation where a fallback is cheap but
- * reclaim/compaction may cause indirect stalls.
- *
- * %__GFP_RECLAIM is shorthand to allow/forbid both direct and kswapd reclaim.
- *
- * The default allocator behavior depends on the request size. We have a concept
- * of so called costly allocations (with order > %PAGE_ALLOC_COSTLY_ORDER).
- * !costly allocations are too essential to fail so they are implicitly
- * non-failing by default (with some exceptions like OOM victims might fail so
- * the caller still has to check for failures) while costly requests try to be
- * not disruptive and back off even without invoking the OOM killer.
- * The following three modifiers might be used to override some of these
- * implicit rules
- *
- * %__GFP_NORETRY: The VM implementation will try only very lightweight
- * memory direct reclaim to get some memory under memory pressure (thus
- * it can sleep). It will avoid disruptive actions like OOM killer. The
- * caller must handle the failure which is quite likely to happen under
- * heavy memory pressure. The flag is suitable when failure can easily be
- * handled at small cost, such as reduced throughput
- *
- * %__GFP_RETRY_MAYFAIL: The VM implementation will retry memory reclaim
- * procedures that have previously failed if there is some indication
- * that progress has been made else where.  It can wait for other
- * tasks to attempt high level approaches to freeing memory such as
- * compaction (which removes fragmentation) and page-out.
- * There is still a definite limit to the number of retries, but it is
- * a larger limit than with %__GFP_NORETRY.
- * Allocations with this flag may fail, but only when there is
- * genuinely little unused memory. While these allocations do not
- * directly trigger the OOM killer, their failure indicates that
- * the system is likely to need to use the OOM killer soon.  The
- * caller must handle failure, but can reasonably do so by failing
- * a higher-level request, or completing it only in a much less
- * efficient manner.
- * If the allocation does fail, and the caller is in a position to
- * free some non-essential memory, doing so could benefit the system
- * as a whole.
- *
- * %__GFP_NOFAIL: The VM implementation _must_ retry infinitely: the caller
- * cannot handle allocation failures. The allocation could block
- * indefinitely but will never return with failure. Testing for
- * failure is pointless.
- * New users should be evaluated carefully (and the flag should be
- * used only when there is no reasonable failure policy) but it is
- * definitely preferable to use the flag rather than opencode endless
- * loop around allocator.
- * Using this flag for costly allocations is _highly_ discouraged.
- */
-#define __GFP_IO	((__force gfp_t)___GFP_IO)
-#define __GFP_FS	((__force gfp_t)___GFP_FS)
-#define __GFP_DIRECT_RECLAIM	((__force gfp_t)___GFP_DIRECT_RECLAIM) /* Caller can reclaim */
-#define __GFP_KSWAPD_RECLAIM	((__force gfp_t)___GFP_KSWAPD_RECLAIM) /* kswapd can wake */
-#define __GFP_RECLAIM ((__force gfp_t)(___GFP_DIRECT_RECLAIM|___GFP_KSWAPD_RECLAIM))
-#define __GFP_RETRY_MAYFAIL	((__force gfp_t)___GFP_RETRY_MAYFAIL)
-#define __GFP_NOFAIL	((__force gfp_t)___GFP_NOFAIL)
-#define __GFP_NORETRY	((__force gfp_t)___GFP_NORETRY)
-
-/**
- * DOC: Action modifiers
- *
- * Action modifiers
- * ----------------
- *
- * %__GFP_NOWARN suppresses allocation failure reports.
- *
- * %__GFP_COMP address compound page metadata.
- *
- * %__GFP_ZERO returns a zeroed page on success.
- *
- * %__GFP_ZEROTAGS zeroes memory tags at allocation time if the memory itself
- * is being zeroed (either via __GFP_ZERO or via init_on_alloc, provided that
- * __GFP_SKIP_ZERO is not set). This flag is intended for optimization: setting
- * memory tags at the same time as zeroing memory has minimal additional
- * performace impact.
- *
- * %__GFP_SKIP_KASAN_UNPOISON makes KASAN skip unpoisoning on page allocation.
- * Only effective in HW_TAGS mode.
- *
- * %__GFP_SKIP_KASAN_POISON makes KASAN skip poisoning on page deallocation.
- * Typically, used for userspace pages. Only effective in HW_TAGS mode.
- */
-#define __GFP_NOWARN	((__force gfp_t)___GFP_NOWARN)
-#define __GFP_COMP	((__force gfp_t)___GFP_COMP)
-#define __GFP_ZERO	((__force gfp_t)___GFP_ZERO)
-#define __GFP_ZEROTAGS	((__force gfp_t)___GFP_ZEROTAGS)
-#define __GFP_SKIP_ZERO ((__force gfp_t)___GFP_SKIP_ZERO)
-#define __GFP_SKIP_KASAN_UNPOISON ((__force gfp_t)___GFP_SKIP_KASAN_UNPOISON)
-#define __GFP_SKIP_KASAN_POISON   ((__force gfp_t)___GFP_SKIP_KASAN_POISON)
-
-/* Disable lockdep for GFP context tracking */
-#define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
-
-/* Room for N __GFP_FOO bits */
-#define __GFP_BITS_SHIFT (27 + IS_ENABLED(CONFIG_LOCKDEP))
-#define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
-
-/**
- * DOC: Useful GFP flag combinations
- *
- * Useful GFP flag combinations
- * ----------------------------
- *
- * Useful GFP flag combinations that are commonly used. It is recommended
- * that subsystems start with one of these combinations and then set/clear
- * %__GFP_FOO flags as necessary.
- *
- * %GFP_ATOMIC users can not sleep and need the allocation to succeed. A lower
- * watermark is applied to allow access to "atomic reserves".
- * The current implementation doesn't support NMI and few other strict
- * non-preemptive contexts (e.g. raw_spin_lock). The same applies to %GFP_NOWAIT.
- *
- * %GFP_KERNEL is typical for kernel-internal allocations. The caller requires
- * %ZONE_NORMAL or a lower zone for direct access but can direct reclaim.
- *
- * %GFP_KERNEL_ACCOUNT is the same as GFP_KERNEL, except the allocation is
- * accounted to kmemcg.
- *
- * %GFP_NOWAIT is for kernel allocations that should not stall for direct
- * reclaim, start physical IO or use any filesystem callback.
- *
- * %GFP_NOIO will use direct reclaim to discard clean pages or slab pages
- * that do not require the starting of any physical IO.
- * Please try to avoid using this flag directly and instead use
- * memalloc_noio_{save,restore} to mark the whole scope which cannot
- * perform any IO with a short explanation why. All allocation requests
- * will inherit GFP_NOIO implicitly.
- *
- * %GFP_NOFS will use direct reclaim but will not use any filesystem interfaces.
- * Please try to avoid using this flag directly and instead use
- * memalloc_nofs_{save,restore} to mark the whole scope which cannot/shouldn't
- * recurse into the FS layer with a short explanation why. All allocation
- * requests will inherit GFP_NOFS implicitly.
- *
- * %GFP_USER is for userspace allocations that also need to be directly
- * accessibly by the kernel or hardware. It is typically used by hardware
- * for buffers that are mapped to userspace (e.g. graphics) that hardware
- * still must DMA to. cpuset limits are enforced for these allocations.
- *
- * %GFP_DMA exists for historical reasons and should be avoided where possible.
- * The flags indicates that the caller requires that the lowest zone be
- * used (%ZONE_DMA or 16M on x86-64). Ideally, this would be removed but
- * it would require careful auditing as some users really require it and
- * others use the flag to avoid lowmem reserves in %ZONE_DMA and treat the
- * lowest zone as a type of emergency reserve.
- *
- * %GFP_DMA32 is similar to %GFP_DMA except that the caller requires a 32-bit
- * address. Note that kmalloc(..., GFP_DMA32) does not return DMA32 memory
- * because the DMA32 kmalloc cache array is not implemented.
- * (Reason: there is no such user in kernel).
- *
- * %GFP_HIGHUSER is for userspace allocations that may be mapped to userspace,
- * do not need to be directly accessible by the kernel but that cannot
- * move once in use. An example may be a hardware allocation that maps
- * data directly into userspace but has no addressing limitations.
- *
- * %GFP_HIGHUSER_MOVABLE is for userspace allocations that the kernel does not
- * need direct access to but can use kmap() when access is required. They
- * are expected to be movable via page reclaim or page migration. Typically,
- * pages on the LRU would also be allocated with %GFP_HIGHUSER_MOVABLE.
- *
- * %GFP_TRANSHUGE and %GFP_TRANSHUGE_LIGHT are used for THP allocations. They
- * are compound allocations that will generally fail quickly if memory is not
- * available and will not wake kswapd/kcompactd on failure. The _LIGHT
- * version does not attempt reclaim/compaction at all and is by default used
- * in page fault path, while the non-light is used by khugepaged.
- */
-#define GFP_ATOMIC	(__GFP_HIGH|__GFP_ATOMIC|__GFP_KSWAPD_RECLAIM)
-#define GFP_KERNEL	(__GFP_RECLAIM | __GFP_IO | __GFP_FS)
-#define GFP_KERNEL_ACCOUNT (GFP_KERNEL | __GFP_ACCOUNT)
-#define GFP_NOWAIT	(__GFP_KSWAPD_RECLAIM)
-#define GFP_NOIO	(__GFP_RECLAIM)
-#define GFP_NOFS	(__GFP_RECLAIM | __GFP_IO)
-#define GFP_USER	(__GFP_RECLAIM | __GFP_IO | __GFP_FS | __GFP_HARDWALL)
-#define GFP_DMA		__GFP_DMA
-#define GFP_DMA32	__GFP_DMA32
-#define GFP_HIGHUSER	(GFP_USER | __GFP_HIGHMEM)
-#define GFP_HIGHUSER_MOVABLE	(GFP_HIGHUSER | __GFP_MOVABLE | \
-			 __GFP_SKIP_KASAN_POISON)
-#define GFP_TRANSHUGE_LIGHT	((GFP_HIGHUSER_MOVABLE | __GFP_COMP | \
-			 __GFP_NOMEMALLOC | __GFP_NOWARN) & ~__GFP_RECLAIM)
-#define GFP_TRANSHUGE	(GFP_TRANSHUGE_LIGHT | __GFP_DIRECT_RECLAIM)
-
 /* Convert GFP flags to their corresponding migrate type */
 #define GFP_MOVABLE_MASK (__GFP_RECLAIMABLE|__GFP_MOVABLE)
 #define GFP_MOVABLE_SHIFT 3
diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
new file mode 100644
index 000000000000..06fc85cee23f
--- /dev/null
+++ b/include/linux/gfp_types.h
@@ -0,0 +1,348 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_GFP_TYPES_H
+#define __LINUX_GFP_TYPES_H
+
+/* The typedef is in types.h but we want the documentation here */
+#if 0
+/**
+ * typedef gfp_t - Memory allocation flags.
+ *
+ * GFP flags are commonly used throughout Linux to indicate how memory
+ * should be allocated.  The GFP acronym stands for get_free_pages(),
+ * the underlying memory allocation function.  Not every GFP flag is
+ * supported by every function which may allocate memory.  Most users
+ * will want to use a plain ``GFP_KERNEL``.
+ */
+typedef unsigned int __bitwise gfp_t;
+#endif
+
+/*
+ * In case of changes, please don't forget to update
+ * include/trace/events/mmflags.h and tools/perf/builtin-kmem.c
+ */
+
+/* Plain integer GFP bitmasks. Do not use this directly. */
+#define ___GFP_DMA		0x01u
+#define ___GFP_HIGHMEM		0x02u
+#define ___GFP_DMA32		0x04u
+#define ___GFP_MOVABLE		0x08u
+#define ___GFP_RECLAIMABLE	0x10u
+#define ___GFP_HIGH		0x20u
+#define ___GFP_IO		0x40u
+#define ___GFP_FS		0x80u
+#define ___GFP_ZERO		0x100u
+#define ___GFP_ATOMIC		0x200u
+#define ___GFP_DIRECT_RECLAIM	0x400u
+#define ___GFP_KSWAPD_RECLAIM	0x800u
+#define ___GFP_WRITE		0x1000u
+#define ___GFP_NOWARN		0x2000u
+#define ___GFP_RETRY_MAYFAIL	0x4000u
+#define ___GFP_NOFAIL		0x8000u
+#define ___GFP_NORETRY		0x10000u
+#define ___GFP_MEMALLOC		0x20000u
+#define ___GFP_COMP		0x40000u
+#define ___GFP_NOMEMALLOC	0x80000u
+#define ___GFP_HARDWALL		0x100000u
+#define ___GFP_THISNODE		0x200000u
+#define ___GFP_ACCOUNT		0x400000u
+#define ___GFP_ZEROTAGS		0x800000u
+#ifdef CONFIG_KASAN_HW_TAGS
+#define ___GFP_SKIP_ZERO		0x1000000u
+#define ___GFP_SKIP_KASAN_UNPOISON	0x2000000u
+#define ___GFP_SKIP_KASAN_POISON	0x4000000u
+#else
+#define ___GFP_SKIP_ZERO		0
+#define ___GFP_SKIP_KASAN_UNPOISON	0
+#define ___GFP_SKIP_KASAN_POISON	0
+#endif
+#ifdef CONFIG_LOCKDEP
+#define ___GFP_NOLOCKDEP	0x8000000u
+#else
+#define ___GFP_NOLOCKDEP	0
+#endif
+/* If the above are modified, __GFP_BITS_SHIFT may need updating */
+
+/*
+ * Physical address zone modifiers (see linux/mmzone.h - low four bits)
+ *
+ * Do not put any conditional on these. If necessary modify the definitions
+ * without the underscores and use them consistently. The definitions here may
+ * be used in bit comparisons.
+ */
+#define __GFP_DMA	((__force gfp_t)___GFP_DMA)
+#define __GFP_HIGHMEM	((__force gfp_t)___GFP_HIGHMEM)
+#define __GFP_DMA32	((__force gfp_t)___GFP_DMA32)
+#define __GFP_MOVABLE	((__force gfp_t)___GFP_MOVABLE)  /* ZONE_MOVABLE allowed */
+#define GFP_ZONEMASK	(__GFP_DMA|__GFP_HIGHMEM|__GFP_DMA32|__GFP_MOVABLE)
+
+/**
+ * DOC: Page mobility and placement hints
+ *
+ * Page mobility and placement hints
+ * ---------------------------------
+ *
+ * These flags provide hints about how mobile the page is. Pages with similar
+ * mobility are placed within the same pageblocks to minimise problems due
+ * to external fragmentation.
+ *
+ * %__GFP_MOVABLE (also a zone modifier) indicates that the page can be
+ * moved by page migration during memory compaction or can be reclaimed.
+ *
+ * %__GFP_RECLAIMABLE is used for slab allocations that specify
+ * SLAB_RECLAIM_ACCOUNT and whose pages can be freed via shrinkers.
+ *
+ * %__GFP_WRITE indicates the caller intends to dirty the page. Where possible,
+ * these pages will be spread between local zones to avoid all the dirty
+ * pages being in one zone (fair zone allocation policy).
+ *
+ * %__GFP_HARDWALL enforces the cpuset memory allocation policy.
+ *
+ * %__GFP_THISNODE forces the allocation to be satisfied from the requested
+ * node with no fallbacks or placement policy enforcements.
+ *
+ * %__GFP_ACCOUNT causes the allocation to be accounted to kmemcg.
+ */
+#define __GFP_RECLAIMABLE ((__force gfp_t)___GFP_RECLAIMABLE)
+#define __GFP_WRITE	((__force gfp_t)___GFP_WRITE)
+#define __GFP_HARDWALL   ((__force gfp_t)___GFP_HARDWALL)
+#define __GFP_THISNODE	((__force gfp_t)___GFP_THISNODE)
+#define __GFP_ACCOUNT	((__force gfp_t)___GFP_ACCOUNT)
+
+/**
+ * DOC: Watermark modifiers
+ *
+ * Watermark modifiers -- controls access to emergency reserves
+ * ------------------------------------------------------------
+ *
+ * %__GFP_HIGH indicates that the caller is high-priority and that granting
+ * the request is necessary before the system can make forward progress.
+ * For example, creating an IO context to clean pages.
+ *
+ * %__GFP_ATOMIC indicates that the caller cannot reclaim or sleep and is
+ * high priority. Users are typically interrupt handlers. This may be
+ * used in conjunction with %__GFP_HIGH
+ *
+ * %__GFP_MEMALLOC allows access to all memory. This should only be used when
+ * the caller guarantees the allocation will allow more memory to be freed
+ * very shortly e.g. process exiting or swapping. Users either should
+ * be the MM or co-ordinating closely with the VM (e.g. swap over NFS).
+ * Users of this flag have to be extremely careful to not deplete the reserve
+ * completely and implement a throttling mechanism which controls the
+ * consumption of the reserve based on the amount of freed memory.
+ * Usage of a pre-allocated pool (e.g. mempool) should be always considered
+ * before using this flag.
+ *
+ * %__GFP_NOMEMALLOC is used to explicitly forbid access to emergency reserves.
+ * This takes precedence over the %__GFP_MEMALLOC flag if both are set.
+ */
+#define __GFP_ATOMIC	((__force gfp_t)___GFP_ATOMIC)
+#define __GFP_HIGH	((__force gfp_t)___GFP_HIGH)
+#define __GFP_MEMALLOC	((__force gfp_t)___GFP_MEMALLOC)
+#define __GFP_NOMEMALLOC ((__force gfp_t)___GFP_NOMEMALLOC)
+
+/**
+ * DOC: Reclaim modifiers
+ *
+ * Reclaim modifiers
+ * -----------------
+ * Please note that all the following flags are only applicable to sleepable
+ * allocations (e.g. %GFP_NOWAIT and %GFP_ATOMIC will ignore them).
+ *
+ * %__GFP_IO can start physical IO.
+ *
+ * %__GFP_FS can call down to the low-level FS. Clearing the flag avoids the
+ * allocator recursing into the filesystem which might already be holding
+ * locks.
+ *
+ * %__GFP_DIRECT_RECLAIM indicates that the caller may enter direct reclaim.
+ * This flag can be cleared to avoid unnecessary delays when a fallback
+ * option is available.
+ *
+ * %__GFP_KSWAPD_RECLAIM indicates that the caller wants to wake kswapd when
+ * the low watermark is reached and have it reclaim pages until the high
+ * watermark is reached. A caller may wish to clear this flag when fallback
+ * options are available and the reclaim is likely to disrupt the system. The
+ * canonical example is THP allocation where a fallback is cheap but
+ * reclaim/compaction may cause indirect stalls.
+ *
+ * %__GFP_RECLAIM is shorthand to allow/forbid both direct and kswapd reclaim.
+ *
+ * The default allocator behavior depends on the request size. We have a concept
+ * of so called costly allocations (with order > %PAGE_ALLOC_COSTLY_ORDER).
+ * !costly allocations are too essential to fail so they are implicitly
+ * non-failing by default (with some exceptions like OOM victims might fail so
+ * the caller still has to check for failures) while costly requests try to be
+ * not disruptive and back off even without invoking the OOM killer.
+ * The following three modifiers might be used to override some of these
+ * implicit rules
+ *
+ * %__GFP_NORETRY: The VM implementation will try only very lightweight
+ * memory direct reclaim to get some memory under memory pressure (thus
+ * it can sleep). It will avoid disruptive actions like OOM killer. The
+ * caller must handle the failure which is quite likely to happen under
+ * heavy memory pressure. The flag is suitable when failure can easily be
+ * handled at small cost, such as reduced throughput
+ *
+ * %__GFP_RETRY_MAYFAIL: The VM implementation will retry memory reclaim
+ * procedures that have previously failed if there is some indication
+ * that progress has been made else where.  It can wait for other
+ * tasks to attempt high level approaches to freeing memory such as
+ * compaction (which removes fragmentation) and page-out.
+ * There is still a definite limit to the number of retries, but it is
+ * a larger limit than with %__GFP_NORETRY.
+ * Allocations with this flag may fail, but only when there is
+ * genuinely little unused memory. While these allocations do not
+ * directly trigger the OOM killer, their failure indicates that
+ * the system is likely to need to use the OOM killer soon.  The
+ * caller must handle failure, but can reasonably do so by failing
+ * a higher-level request, or completing it only in a much less
+ * efficient manner.
+ * If the allocation does fail, and the caller is in a position to
+ * free some non-essential memory, doing so could benefit the system
+ * as a whole.
+ *
+ * %__GFP_NOFAIL: The VM implementation _must_ retry infinitely: the caller
+ * cannot handle allocation failures. The allocation could block
+ * indefinitely but will never return with failure. Testing for
+ * failure is pointless.
+ * New users should be evaluated carefully (and the flag should be
+ * used only when there is no reasonable failure policy) but it is
+ * definitely preferable to use the flag rather than opencode endless
+ * loop around allocator.
+ * Using this flag for costly allocations is _highly_ discouraged.
+ */
+#define __GFP_IO	((__force gfp_t)___GFP_IO)
+#define __GFP_FS	((__force gfp_t)___GFP_FS)
+#define __GFP_DIRECT_RECLAIM	((__force gfp_t)___GFP_DIRECT_RECLAIM) /* Caller can reclaim */
+#define __GFP_KSWAPD_RECLAIM	((__force gfp_t)___GFP_KSWAPD_RECLAIM) /* kswapd can wake */
+#define __GFP_RECLAIM ((__force gfp_t)(___GFP_DIRECT_RECLAIM|___GFP_KSWAPD_RECLAIM))
+#define __GFP_RETRY_MAYFAIL	((__force gfp_t)___GFP_RETRY_MAYFAIL)
+#define __GFP_NOFAIL	((__force gfp_t)___GFP_NOFAIL)
+#define __GFP_NORETRY	((__force gfp_t)___GFP_NORETRY)
+
+/**
+ * DOC: Action modifiers
+ *
+ * Action modifiers
+ * ----------------
+ *
+ * %__GFP_NOWARN suppresses allocation failure reports.
+ *
+ * %__GFP_COMP address compound page metadata.
+ *
+ * %__GFP_ZERO returns a zeroed page on success.
+ *
+ * %__GFP_ZEROTAGS zeroes memory tags at allocation time if the memory itself
+ * is being zeroed (either via __GFP_ZERO or via init_on_alloc, provided that
+ * __GFP_SKIP_ZERO is not set). This flag is intended for optimization: setting
+ * memory tags at the same time as zeroing memory has minimal additional
+ * performace impact.
+ *
+ * %__GFP_SKIP_KASAN_UNPOISON makes KASAN skip unpoisoning on page allocation.
+ * Only effective in HW_TAGS mode.
+ *
+ * %__GFP_SKIP_KASAN_POISON makes KASAN skip poisoning on page deallocation.
+ * Typically, used for userspace pages. Only effective in HW_TAGS mode.
+ */
+#define __GFP_NOWARN	((__force gfp_t)___GFP_NOWARN)
+#define __GFP_COMP	((__force gfp_t)___GFP_COMP)
+#define __GFP_ZERO	((__force gfp_t)___GFP_ZERO)
+#define __GFP_ZEROTAGS	((__force gfp_t)___GFP_ZEROTAGS)
+#define __GFP_SKIP_ZERO ((__force gfp_t)___GFP_SKIP_ZERO)
+#define __GFP_SKIP_KASAN_UNPOISON ((__force gfp_t)___GFP_SKIP_KASAN_UNPOISON)
+#define __GFP_SKIP_KASAN_POISON   ((__force gfp_t)___GFP_SKIP_KASAN_POISON)
+
+/* Disable lockdep for GFP context tracking */
+#define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
+
+/* Room for N __GFP_FOO bits */
+#define __GFP_BITS_SHIFT (27 + IS_ENABLED(CONFIG_LOCKDEP))
+#define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
+
+/**
+ * DOC: Useful GFP flag combinations
+ *
+ * Useful GFP flag combinations
+ * ----------------------------
+ *
+ * Useful GFP flag combinations that are commonly used. It is recommended
+ * that subsystems start with one of these combinations and then set/clear
+ * %__GFP_FOO flags as necessary.
+ *
+ * %GFP_ATOMIC users can not sleep and need the allocation to succeed. A lower
+ * watermark is applied to allow access to "atomic reserves".
+ * The current implementation doesn't support NMI and few other strict
+ * non-preemptive contexts (e.g. raw_spin_lock). The same applies to %GFP_NOWAIT.
+ *
+ * %GFP_KERNEL is typical for kernel-internal allocations. The caller requires
+ * %ZONE_NORMAL or a lower zone for direct access but can direct reclaim.
+ *
+ * %GFP_KERNEL_ACCOUNT is the same as GFP_KERNEL, except the allocation is
+ * accounted to kmemcg.
+ *
+ * %GFP_NOWAIT is for kernel allocations that should not stall for direct
+ * reclaim, start physical IO or use any filesystem callback.
+ *
+ * %GFP_NOIO will use direct reclaim to discard clean pages or slab pages
+ * that do not require the starting of any physical IO.
+ * Please try to avoid using this flag directly and instead use
+ * memalloc_noio_{save,restore} to mark the whole scope which cannot
+ * perform any IO with a short explanation why. All allocation requests
+ * will inherit GFP_NOIO implicitly.
+ *
+ * %GFP_NOFS will use direct reclaim but will not use any filesystem interfaces.
+ * Please try to avoid using this flag directly and instead use
+ * memalloc_nofs_{save,restore} to mark the whole scope which cannot/shouldn't
+ * recurse into the FS layer with a short explanation why. All allocation
+ * requests will inherit GFP_NOFS implicitly.
+ *
+ * %GFP_USER is for userspace allocations that also need to be directly
+ * accessibly by the kernel or hardware. It is typically used by hardware
+ * for buffers that are mapped to userspace (e.g. graphics) that hardware
+ * still must DMA to. cpuset limits are enforced for these allocations.
+ *
+ * %GFP_DMA exists for historical reasons and should be avoided where possible.
+ * The flags indicates that the caller requires that the lowest zone be
+ * used (%ZONE_DMA or 16M on x86-64). Ideally, this would be removed but
+ * it would require careful auditing as some users really require it and
+ * others use the flag to avoid lowmem reserves in %ZONE_DMA and treat the
+ * lowest zone as a type of emergency reserve.
+ *
+ * %GFP_DMA32 is similar to %GFP_DMA except that the caller requires a 32-bit
+ * address. Note that kmalloc(..., GFP_DMA32) does not return DMA32 memory
+ * because the DMA32 kmalloc cache array is not implemented.
+ * (Reason: there is no such user in kernel).
+ *
+ * %GFP_HIGHUSER is for userspace allocations that may be mapped to userspace,
+ * do not need to be directly accessible by the kernel but that cannot
+ * move once in use. An example may be a hardware allocation that maps
+ * data directly into userspace but has no addressing limitations.
+ *
+ * %GFP_HIGHUSER_MOVABLE is for userspace allocations that the kernel does not
+ * need direct access to but can use kmap() when access is required. They
+ * are expected to be movable via page reclaim or page migration. Typically,
+ * pages on the LRU would also be allocated with %GFP_HIGHUSER_MOVABLE.
+ *
+ * %GFP_TRANSHUGE and %GFP_TRANSHUGE_LIGHT are used for THP allocations. They
+ * are compound allocations that will generally fail quickly if memory is not
+ * available and will not wake kswapd/kcompactd on failure. The _LIGHT
+ * version does not attempt reclaim/compaction at all and is by default used
+ * in page fault path, while the non-light is used by khugepaged.
+ */
+#define GFP_ATOMIC	(__GFP_HIGH|__GFP_ATOMIC|__GFP_KSWAPD_RECLAIM)
+#define GFP_KERNEL	(__GFP_RECLAIM | __GFP_IO | __GFP_FS)
+#define GFP_KERNEL_ACCOUNT (GFP_KERNEL | __GFP_ACCOUNT)
+#define GFP_NOWAIT	(__GFP_KSWAPD_RECLAIM)
+#define GFP_NOIO	(__GFP_RECLAIM)
+#define GFP_NOFS	(__GFP_RECLAIM | __GFP_IO)
+#define GFP_USER	(__GFP_RECLAIM | __GFP_IO | __GFP_FS | __GFP_HARDWALL)
+#define GFP_DMA		__GFP_DMA
+#define GFP_DMA32	__GFP_DMA32
+#define GFP_HIGHUSER	(GFP_USER | __GFP_HIGHMEM)
+#define GFP_HIGHUSER_MOVABLE	(GFP_HIGHUSER | __GFP_MOVABLE | \
+			 __GFP_SKIP_KASAN_POISON)
+#define GFP_TRANSHUGE_LIGHT	((GFP_HIGHUSER_MOVABLE | __GFP_COMP | \
+			 __GFP_NOMEMALLOC | __GFP_NOWARN) & ~__GFP_RECLAIM)
+#define GFP_TRANSHUGE	(GFP_TRANSHUGE_LIGHT | __GFP_DIRECT_RECLAIM)
+
+#endif /* __LINUX_GFP_TYPES_H */
-- 
2.34.1

