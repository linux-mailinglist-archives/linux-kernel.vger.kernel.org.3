Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69DE47CD38
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 08:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242869AbhLVHBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 02:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbhLVHBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 02:01:19 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DE1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 23:01:19 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id p4so2586326oia.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 23:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K+fEElkxyh17SJxyQvhZhzCYL3bEc/oln0enLIlPr7s=;
        b=mtHkqAut5erRcuNLSctSEzeMyPCR80NGM65cq4+3JhKZzWgfS7gGI6pWVYJS7miIUb
         w+FkCIpunzbp9PEpXoYSDQ8ZXzcaiGkq+y6kc1yjNnRsJOidNN0Oi3Tda2q6Tgxm/iJU
         xvYhPeUo2fY+E9EKeH3giHSG6M64DY7SnKQKuNRN+GvUYv8xdfNTcnKySla6PI5DCijB
         mPq73XUllLQi3Wx6m7XV+R+/rYrtrdxUMyVu4vFP1zcV9zDRgVp1VT+6W5YZjnkmvnHa
         pEdBXHJhWiFYWkLOg64+IWFI1MqYZ74ePSROkIR1QcAYpvTQPnjpz9oCGLLZj1QagQFv
         iCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K+fEElkxyh17SJxyQvhZhzCYL3bEc/oln0enLIlPr7s=;
        b=dCv4MkKJ1WRsMKYEyZHuDZXkBjHjgW/yMAG6s7gHgvRrY4xvUii7zNb9Zfzj7GlBig
         vOguNEQqylEFnL/sSgxDgxGOOjr/ZgJmFZ4dFM0e7cTWz7OOAqwieQSYACkyqS0SfWjy
         hBI+Wqda4Y1nTs5yKYqNmJDbI27d8Pqu0MlWXrT6lxz7dNPT3+suhxiUpmu/y6An4OYY
         WkMOC8Mi+2J11KMLo7h5AtNEYyc5GyTw4nfIDX5u44T5Re2hWCV28B86rAZy84dIkGvz
         exV9L5L48tNits4xUex7T5dBH5Uy2qkD+IUKBLfWJocd8O8DWnzlf3XQQFZdEopZ+NsU
         /Z4Q==
X-Gm-Message-State: AOAM533wJ7xFW1ar2rIQ8s8N+G8Ss2FiiOrANVOAK+YnBLdx58EyVxq7
        LuWs8uHVXIiUFbkXLAzKmKVuJXgRCl65QdlOk0P0hA==
X-Google-Smtp-Source: ABdhPJwCHScp3p4RzyuDHrG94FWwwyqwm0Z/uarqZ5vYJ/UJ1gXSn+F2cW8znfrXyfTzfm5pCkKhMGSbefOwEHeq95U=
X-Received: by 2002:a05:6808:118c:: with SMTP id j12mr1181782oil.65.1640156478612;
 Tue, 21 Dec 2021 23:01:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1640036051.git.andreyknvl@google.com>
In-Reply-To: <cover.1640036051.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 22 Dec 2021 08:00:00 +0100
Message-ID: <CANpmjNOj-jYo=yaffBi5w=esyHYo=CEqDJce7cb-KmQ1P6BEMQ@mail.gmail.com>
Subject: Re: [PATCH mm v4 00/39] kasan, vmalloc, arm64: add vmalloc tagging
 support for SW/HW_TAGS
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
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

On Mon, 20 Dec 2021 at 22:58, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Hi,
>
> This patchset adds vmalloc tagging support for SW_TAGS and HW_TAGS
> KASAN modes.
>
> The tree with patches is available here:
>
> https://github.com/xairy/linux/tree/up-kasan-vmalloc-tags-v4-akpm
>
> About half of patches are cleanups I went for along the way. None of
> them seem to be important enough to go through stable, so I decided
> not to split them out into separate patches/series.
>
> The patchset is partially based on an early version of the HW_TAGS
> patchset by Vincenzo that had vmalloc support. Thus, I added a
> Co-developed-by tag into a few patches.
>
> SW_TAGS vmalloc tagging support is straightforward. It reuses all of
> the generic KASAN machinery, but uses shadow memory to store tags
> instead of magic values. Naturally, vmalloc tagging requires adding
> a few kasan_reset_tag() annotations to the vmalloc code.
>
> HW_TAGS vmalloc tagging support stands out. HW_TAGS KASAN is based on
> Arm MTE, which can only assigns tags to physical memory. As a result,
> HW_TAGS KASAN only tags vmalloc() allocations, which are backed by
> page_alloc memory. It ignores vmap() and others.
>
> Changes in v3->v4:
[...]
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
>   kasan: simplify kasan_init_hw_tags
>   kasan: add kasan.vmalloc command line flag
>   kasan: allow enabling KASAN_VMALLOC and SW/HW_TAGS
>   arm64: select KASAN_VMALLOC for SW/HW_TAGS modes
>   kasan: documentation updates
>   kasan: improve vmalloc tests

Functionally it all looks good. So rather than acking every patch, for
the whole series:

Acked-by: Marco Elver <elver@google.com>

... and in case you do a v5, I've left some minor comments.

Happy holidays!

Thanks,
-- Marco
