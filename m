Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF78481F75
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 20:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241806AbhL3TL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 14:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241798AbhL3TL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 14:11:57 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD72C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 11:11:57 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id 9so2804912ill.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 11:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0B1QA/OwI2lHBTPwaGSFFWLygKR3T0IMOccEPyW54+I=;
        b=I5w21MLCIyny4rxcZut+liGLCPTNYQ3E7IG+KbxdKWqko1onajZ1v+6QjhXgAjJ6DN
         J1LyqJWEhbdmT+jXI+0k5FVBH7gYx3H4cJ+/pGb6UVRAvPdCAq2eDMA0Hl/Bv2uuP0sw
         kFPjlJHydUm0kmW+9URr6GngKreflsf6DfFWYFd5EcW5A5Cm/8t1lxWJuyDQC9slIUq/
         VIbh5xFn62bWRBv008rBi1BMKm7EYU9rpi/b7XEx6C7aXQiQmHJfMabAfYqtxY9GunjR
         t9VOhfG5CFBQDzmNZhKkWAk0YUzBnHhTQczqCNFzU/OrQO/WLo+lhTASuc0GeIMDeHKt
         yFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0B1QA/OwI2lHBTPwaGSFFWLygKR3T0IMOccEPyW54+I=;
        b=4vUkziAve2YXMdqP14gIQ2guSKrMxUTrXbPSdzlMZCz3jng4ZdF1TTsa4MefDsrmjR
         qiVG3TqAj4eUPimqkihdz5CEwFGD+M/VpJMPi0e/BW0RNyr8HLYCFVYgshj6VIiBukhl
         nk/D4BthPik67LLdTZwXoPlbcibnvqDzN0MHuVP+ZshVzwCLmxXdsOB/IRH66vs0sTUr
         cHnMMXPuZqgud3W+N0nTC/pH3SPhsA5ds2N//zdu+oMPRmmSSewjxukK8wwKbxIZCv+P
         +RYeKUc6cIwtk300gLKoauzMXt0RVjKk962FHjrQ2KEstPF2HbnigxSJ7s38fHCb4miR
         Vh1w==
X-Gm-Message-State: AOAM530GCQaLShn4im9joEh+oXbIFZHhXmCq/MzV+iHZLWUWrnD9LZrq
        vpgZxxcOYlBTFnuP6gnQUxxSFZCZbLEtCYNQfWk=
X-Google-Smtp-Source: ABdhPJw5ADLAvrXVZK304cmwxaKzbBJMO24wmv+StTFc9NwPKDYEdjzTMJrXE4uqSlCxk7s/fyOfUxnWlycBbR0ytss=
X-Received: by 2002:a05:6e02:178f:: with SMTP id y15mr14604983ilu.235.1640891516954;
 Thu, 30 Dec 2021 11:11:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1640036051.git.andreyknvl@google.com> <CANpmjNOj-jYo=yaffBi5w=esyHYo=CEqDJce7cb-KmQ1P6BEMQ@mail.gmail.com>
In-Reply-To: <CANpmjNOj-jYo=yaffBi5w=esyHYo=CEqDJce7cb-KmQ1P6BEMQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 30 Dec 2021 20:11:46 +0100
Message-ID: <CA+fCnZeDdgiCZbmJZY7Ep-W8XpEmCzs+1B2QcaEMQhJMrFyPEw@mail.gmail.com>
Subject: Re: [PATCH mm v4 00/39] kasan, vmalloc, arm64: add vmalloc tagging
 support for SW/HW_TAGS
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 8:01 AM Marco Elver <elver@google.com> wrote:
>
> On Mon, 20 Dec 2021 at 22:58, <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Hi,
> >
> > This patchset adds vmalloc tagging support for SW_TAGS and HW_TAGS
> > KASAN modes.
> >
> > The tree with patches is available here:
> >
> > https://github.com/xairy/linux/tree/up-kasan-vmalloc-tags-v4-akpm
> >
> > About half of patches are cleanups I went for along the way. None of
> > them seem to be important enough to go through stable, so I decided
> > not to split them out into separate patches/series.
> >
> > The patchset is partially based on an early version of the HW_TAGS
> > patchset by Vincenzo that had vmalloc support. Thus, I added a
> > Co-developed-by tag into a few patches.
> >
> > SW_TAGS vmalloc tagging support is straightforward. It reuses all of
> > the generic KASAN machinery, but uses shadow memory to store tags
> > instead of magic values. Naturally, vmalloc tagging requires adding
> > a few kasan_reset_tag() annotations to the vmalloc code.
> >
> > HW_TAGS vmalloc tagging support stands out. HW_TAGS KASAN is based on
> > Arm MTE, which can only assigns tags to physical memory. As a result,
> > HW_TAGS KASAN only tags vmalloc() allocations, which are backed by
> > page_alloc memory. It ignores vmap() and others.
> >
> > Changes in v3->v4:
> [...]
> > Andrey Konovalov (39):
> >   kasan, page_alloc: deduplicate should_skip_kasan_poison
> >   kasan, page_alloc: move tag_clear_highpage out of
> >     kernel_init_free_pages
> >   kasan, page_alloc: merge kasan_free_pages into free_pages_prepare
> >   kasan, page_alloc: simplify kasan_poison_pages call site
> >   kasan, page_alloc: init memory of skipped pages on free
> >   kasan: drop skip_kasan_poison variable in free_pages_prepare
> >   mm: clarify __GFP_ZEROTAGS comment
> >   kasan: only apply __GFP_ZEROTAGS when memory is zeroed
> >   kasan, page_alloc: refactor init checks in post_alloc_hook
> >   kasan, page_alloc: merge kasan_alloc_pages into post_alloc_hook
> >   kasan, page_alloc: combine tag_clear_highpage calls in post_alloc_hook
> >   kasan, page_alloc: move SetPageSkipKASanPoison in post_alloc_hook
> >   kasan, page_alloc: move kernel_init_free_pages in post_alloc_hook
> >   kasan, page_alloc: rework kasan_unpoison_pages call site
> >   kasan: clean up metadata byte definitions
> >   kasan: define KASAN_VMALLOC_INVALID for SW_TAGS
> >   kasan, x86, arm64, s390: rename functions for modules shadow
> >   kasan, vmalloc: drop outdated VM_KASAN comment
> >   kasan: reorder vmalloc hooks
> >   kasan: add wrappers for vmalloc hooks
> >   kasan, vmalloc: reset tags in vmalloc functions
> >   kasan, fork: reset pointer tags of vmapped stacks
> >   kasan, arm64: reset pointer tags of vmapped stacks
> >   kasan, vmalloc: add vmalloc tagging for SW_TAGS
> >   kasan, vmalloc, arm64: mark vmalloc mappings as pgprot_tagged
> >   kasan, vmalloc: unpoison VM_ALLOC pages after mapping
> >   kasan, mm: only define ___GFP_SKIP_KASAN_POISON with HW_TAGS
> >   kasan, page_alloc: allow skipping unpoisoning for HW_TAGS
> >   kasan, page_alloc: allow skipping memory init for HW_TAGS
> >   kasan, vmalloc: add vmalloc tagging for HW_TAGS
> >   kasan, vmalloc: only tag normal vmalloc allocations
> >   kasan, arm64: don't tag executable vmalloc allocations
> >   kasan: mark kasan_arg_stacktrace as __initdata
> >   kasan: simplify kasan_init_hw_tags
> >   kasan: add kasan.vmalloc command line flag
> >   kasan: allow enabling KASAN_VMALLOC and SW/HW_TAGS
> >   arm64: select KASAN_VMALLOC for SW/HW_TAGS modes
> >   kasan: documentation updates
> >   kasan: improve vmalloc tests
>
> Functionally it all looks good. So rather than acking every patch, for
> the whole series:
>
> Acked-by: Marco Elver <elver@google.com>
>
> ... and in case you do a v5, I've left some minor comments.

I will, thanks!

> Happy holidays!

Happy holidays to you too!
