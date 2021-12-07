Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7145B46C3F0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 20:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbhLGTuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 14:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbhLGTuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 14:50:05 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFC8C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 11:46:35 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id 15so116660ilq.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 11:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UOHRGFoWJlaN8tZPy553Y82VWtjgN1BlER86UYqi7dc=;
        b=kbeI/w+qD4yKPDBLOU9Vb8XSOkuHvE3MWoFQK7gF82IjYoJnN7SeYJIwRVeZb9tODX
         wA71cTAgvLDHvNDwE45gipdH7SvuxJkdZnYLALmDjeeXtx7K/4A9Yf2qJ+KUw17gZQui
         os6iVP3dMXnU9ptd5TPR+HS3ApligrIj97yro5p6mKnD+NQ72HXFRB5SH+LpZRdR58ak
         c7aI953UpGxgWvHAcvuBqNkcw7C42RWArYGhU5I6ffNyc7juzDJRfRhe+DLoV4IQRzWN
         HGot5OlvIrvje74IKDd+bfVHkXteXbtDcxjDxroXNZzzLx3LZjx7Z6kL8knfN4URx3Lr
         Uq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UOHRGFoWJlaN8tZPy553Y82VWtjgN1BlER86UYqi7dc=;
        b=YKyNwookvDelWW1mU9jwwh/LEpud584cU/bX3o2kwYf604NZ9laFiE0i6kmuJDVdpa
         LpqCUO+U07HS7opDyulWQ+nOrMf/D+NLaD1at1KAWOLdUY9bjPtpZ3QDN7GAlVA9RtBN
         ap6zRNtmVnZXDmXjGfpoIGek+NQPUK43jze01/jMOCOuiKh6hCbAVBYTSa14eRK377hS
         QdkhysSY5iNOR2csqM42xjXaDIiSOCX1UZGa91bNqVBZPb9e+Oi7Bzp19AWhJxRTtMN7
         XVTrzfqS/ffS7cehXJoJjaMSnI96jH7LSD6nwwbh8AyDBHbuqXo7hihrGLCfLdxKabhc
         XvMQ==
X-Gm-Message-State: AOAM5305bDJeqdbo/H1g6u1otm9nXdLfEynI6WXh147khlJBfqdoSC9A
        bU61O1iUHg+vOAgz2CUdvNTG1Y3lxAOlhG/RAuo=
X-Google-Smtp-Source: ABdhPJxJJ/EuqkW4k0dLfegGojobOFNuQzz7lDAXMVGAZuN0AYbIsAoyzIAuef6gWMajyQlp1Dj1+WZjraixA7hWvbg=
X-Received: by 2002:a05:6e02:1605:: with SMTP id t5mr1720750ilu.233.1638906394679;
 Tue, 07 Dec 2021 11:46:34 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638825394.git.andreyknvl@google.com>
In-Reply-To: <cover.1638825394.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 7 Dec 2021 20:46:24 +0100
Message-ID: <CA+fCnZeHDB4=qJOqoQV3xOJCfiJ4Stnja3y+37x3P-ws2Dtw0Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/34] kasan, vmalloc, arm64: add vmalloc tagging
 support for SW/HW_TAGS
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 10:22 PM <andrey.konovalov@linux.dev> wrote:
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
> https://github.com/xairy/linux/tree/up-kasan-vmalloc-tags-v2
>
> About half of patches are cleanups I went for along the way. None of
> them seem to be important enough to go through stable, so I decided
> not to split them out into separate patches/series.
>
> I'll keep the patchset based on the mainline for now. Once the
> high-level issues are resolved, I'll rebase onto mm - there might be
> a few conflicts right now.
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
> Changes in v1->v2:
> - Move memory init for vmalloc() into vmalloc code for HW_TAGS KASAN.
> - Minor fixes and code reshuffling, see patches for lists of changes.
>
> Thanks!

FTR, I found a few issues with a tag propagating to PC (in BPF JIT and
a few other places). Will address them in v3.
