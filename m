Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4153E4987EC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244957AbiAXSKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245123AbiAXSJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:09:56 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0757CC06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:09:56 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id e81so26753447oia.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v6jRI9epvX7ZG9JJREEDqZFqkweKboDzqXireE4QkNA=;
        b=YkS6CDPg4banfwbviYA741MZOfFey2yAA81DuOEliUIqxHAqKpkwTOqs3giGTVPvhf
         p5HvxcrBBGhjJUConF628JGNgss5ihCK9nAwXFENA+2HjjdSbmgPMxobC+DR0BioNIDV
         w6jMu79A/VPhjJWJ/sdqVebU8Oz9OD3fKuI8ZXtvdoedsuhryepTbFqk7bAwRxXjN8hx
         RyBt4Rd1PmQWRf8+TLpPHzJnRpYSoiK+F+lqOUTb/0Z9tS06JDIco5cl+OgXz9J7H2b5
         T6wDFRLBTvCFzjDuOJIfSV/2PacI00+kY51DhvpSEOwe/zj8d+A4RWOfoVM7DAz9iP66
         ugDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v6jRI9epvX7ZG9JJREEDqZFqkweKboDzqXireE4QkNA=;
        b=T4PL6HLZ2FLNwK5BWsDMoO9x1H8ZSFBHO7L/umjX9bOQqzYsTmhaVPZQvE8vptU7+7
         cZ6KAJ9hweGdfd4ou5lkhEjJ11Rf1WgWvz1lQF3GdC7GJz7TtC/V+vPCayxzBRCfDZer
         HfKsCsnxZRh/KGoUyFEoF3V2ou9hmu9r4hoEZH+Bo7Q3YBZaPlc96e4iOPThVXM8Lcb7
         hNvhGC5OFV2LyD5jgoW65cayqoW7E2sPIcRDCIjM+pj8Ooy+obvncKznWVX63QuF/2Vo
         mZt6Nud/1ooWTyTTrt0hSWtiDjAYwRyvDY2il9nZiQ5urWRVriauVVsYt+J/jV2CuPIt
         6/Sw==
X-Gm-Message-State: AOAM5309eSTxoW4KC4xM3YnDOcdhGHHX9rBuIXR5JbDdQLIV6qJEXn3w
        1giJgDy72DOCDsvRIPeNnOtj7NGiTstaYN65hcNjtA==
X-Google-Smtp-Source: ABdhPJyY7M8uxVK4MREiN+NodPzkzckeZhTZH2CvzINRvGh77ED6ySLK8r5sqOW4kya1FsDbqq4v7Pb4p8ZrtSfK6r8=
X-Received: by 2002:a05:6808:15a6:: with SMTP id t38mr2513927oiw.154.1643047795220;
 Mon, 24 Jan 2022 10:09:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.1643047180.git.andreyknvl@google.com>
In-Reply-To: <cover.1643047180.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 24 Jan 2022 19:09:43 +0100
Message-ID: <CANpmjNO2Lwq5+zy3pGj=cetMdB7qLmP0WWjbSCYucPVjEt4kWw@mail.gmail.com>
Subject: Re: [PATCH v6 00/39] kasan, vmalloc, arm64: add vmalloc tagging
 support for SW/HW_TAGS
To:     andrey.konovalov@linux.dev
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2022 at 19:02, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Hi,
>
> This patchset adds vmalloc tagging support for SW_TAGS and HW_TAGS
> KASAN modes.
[...]
>
> Acked-by: Marco Elver <elver@google.com>

FYI, my Ack may get lost here - on rebase you could apply it to all
patches to carry it forward. As-is, Andrew would still have to apply
it manually.

An Ack to the cover letter saves replying to each patch and thus
generating less emails, which I think is preferred.

My Ack is still valid, given v6 is mainly a rebase and I don't see any
major changes.

Thanks,
-- Marco

> Andrey Konovalov (39):
>   kasan, page_alloc: deduplicate should_skip_kasan_poison
>   kasan, page_alloc: move tag_clear_highpage out of
>     kernel_init_free_pages
>   kasan, page_alloc: merge kasan_free_pages into free_pages_prepare
>   kasan, page_alloc: simplify kasan_poison_pages call site
>   kasan, page_alloc: init memory of skipped pages on free
>   kasan: drop skip_kasan_poison variable in free_pages_prepare
>   mm: clarify __GFP_ZEROTAGS comment
>   kasan: only apply __GFP_ZEROTAGS when memory is zeroed
>   kasan, page_alloc: refactor init checks in post_alloc_hook
>   kasan, page_alloc: merge kasan_alloc_pages into post_alloc_hook
>   kasan, page_alloc: combine tag_clear_highpage calls in post_alloc_hook
>   kasan, page_alloc: move SetPageSkipKASanPoison in post_alloc_hook
>   kasan, page_alloc: move kernel_init_free_pages in post_alloc_hook
>   kasan, page_alloc: rework kasan_unpoison_pages call site
>   kasan: clean up metadata byte definitions
>   kasan: define KASAN_VMALLOC_INVALID for SW_TAGS
>   kasan, x86, arm64, s390: rename functions for modules shadow
>   kasan, vmalloc: drop outdated VM_KASAN comment
>   kasan: reorder vmalloc hooks
>   kasan: add wrappers for vmalloc hooks
>   kasan, vmalloc: reset tags in vmalloc functions
>   kasan, fork: reset pointer tags of vmapped stacks
>   kasan, arm64: reset pointer tags of vmapped stacks
>   kasan, vmalloc: add vmalloc tagging for SW_TAGS
>   kasan, vmalloc, arm64: mark vmalloc mappings as pgprot_tagged
>   kasan, vmalloc: unpoison VM_ALLOC pages after mapping
>   kasan, mm: only define ___GFP_SKIP_KASAN_POISON with HW_TAGS
>   kasan, page_alloc: allow skipping unpoisoning for HW_TAGS
>   kasan, page_alloc: allow skipping memory init for HW_TAGS
>   kasan, vmalloc: add vmalloc tagging for HW_TAGS
>   kasan, vmalloc: only tag normal vmalloc allocations
>   kasan, arm64: don't tag executable vmalloc allocations
>   kasan: mark kasan_arg_stacktrace as __initdata
>   kasan: clean up feature flags for HW_TAGS mode
>   kasan: add kasan.vmalloc command line flag
>   kasan: allow enabling KASAN_VMALLOC and SW/HW_TAGS
>   arm64: select KASAN_VMALLOC for SW/HW_TAGS modes
>   kasan: documentation updates
>   kasan: improve vmalloc tests
>
>  Documentation/dev-tools/kasan.rst   |  17 ++-
>  arch/arm64/Kconfig                  |   2 +-
>  arch/arm64/include/asm/vmalloc.h    |   6 +
>  arch/arm64/include/asm/vmap_stack.h |   5 +-
>  arch/arm64/kernel/module.c          |   5 +-
>  arch/arm64/mm/pageattr.c            |   2 +-
>  arch/arm64/net/bpf_jit_comp.c       |   3 +-
>  arch/s390/kernel/module.c           |   2 +-
>  arch/x86/kernel/module.c            |   2 +-
>  include/linux/gfp.h                 |  35 +++--
>  include/linux/kasan.h               |  97 +++++++++-----
>  include/linux/vmalloc.h             |  18 +--
>  include/trace/events/mmflags.h      |  14 +-
>  kernel/fork.c                       |   1 +
>  kernel/scs.c                        |   4 +-
>  lib/Kconfig.kasan                   |  20 +--
>  lib/test_kasan.c                    | 189 ++++++++++++++++++++++++++-
>  mm/kasan/common.c                   |   4 +-
>  mm/kasan/hw_tags.c                  | 193 ++++++++++++++++++++++------
>  mm/kasan/kasan.h                    |  18 ++-
>  mm/kasan/shadow.c                   |  63 +++++----
>  mm/page_alloc.c                     | 152 +++++++++++++++-------
>  mm/vmalloc.c                        |  99 +++++++++++---
>  23 files changed, 731 insertions(+), 220 deletions(-)
>
> --
> 2.25.1
>
