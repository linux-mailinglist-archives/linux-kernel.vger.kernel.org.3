Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB4046A93C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350270AbhLFVQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350258AbhLFVQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:16:02 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08295C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 13:12:33 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id z8so11631864ilu.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 13:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bvN4dyZ6ySRUU6I+5//n6rteuxKcOj9JtT0P4yYGfLg=;
        b=Jpv/phoH5Hdjr+tLNCKVnN8DIDBAOmr4or1p/skuZcLtwYXc4wMW/RadgxOnEG3UVA
         SM92rTQ2j2sV3DvHGgq9q0yjgDRnQ0XSTUZtWUVWIym8/M4221HNzNtdb+0jBi5OliqC
         IqnZ57jvNQLTejnVGw89M8vOPv3YBLJKcvyvl/vDGTuZwtE+eykAoCMnsLu6KynQ63Lq
         jmobxWqkNE1HxnVYrRWJS212lxVWBnVTkO8oJbQkKnQe3erfyPRFaZba4iq2SrkTu7Tq
         MNgDqw5Y9irzMTnfPdpIL6EYLavdyS5W2z/P57RwDp6jUpjZn7CjglXGfoebQGRA6wgS
         gavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bvN4dyZ6ySRUU6I+5//n6rteuxKcOj9JtT0P4yYGfLg=;
        b=vwmKDv/rvjcmnPdg9BphuwXrRVTDuYaN3er6sqf1pQ2wUnHelFvzkmGQPwbyAFZzFM
         wY5fS/EdncC/TE55He6Zy/EG2eScFKjt1rlbG1uIOlIOj/EjI9v34PaDZV0x6YAhzaGY
         dDS3pjZaFNqZj5iAPMaX9JPiyC4QVWUqh01J1dmb4r0IJpG0grkLbDs3lII0hBheSFSt
         +IuDlNNRNq/MvZbyafzTUTq0ziLAUAc+s15R6vvpj3zaPiJdgZ6z4NBXfIefDs06cbh4
         wC7KxUxqT/IQeYtxbR0vG8UGXZY4rHaD01RJZazYwGm2gsZIyzpVdBFYEMgHchGDUlHF
         BkUg==
X-Gm-Message-State: AOAM533xxb6MbZHzN8M94Xv2aMLLxqyA0bSM19BBgeb0fafWOnCqJsNH
        J4Ybjh5Etgp9uMfZqo6ERmCI4MovbR1mf8pzZropkn1ogHk=
X-Google-Smtp-Source: ABdhPJxGY+MbJ3JeKHuLeQpeIc+xVzMr6o8nqUAwkzsAkOu1dMKRMrs38r9nWPxq9NOg7D8njm/XkpgW/0CdJ+Ql9Xw=
X-Received: by 2002:a92:ca4f:: with SMTP id q15mr35096921ilo.235.1638825152535;
 Mon, 06 Dec 2021 13:12:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638308023.git.andreyknvl@google.com> <aa90926d11b5977402af4ce6dccea89932006d36.1638308023.git.andreyknvl@google.com>
 <YaoQbt/7FoEnBx4K@elver.google.com>
In-Reply-To: <YaoQbt/7FoEnBx4K@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 6 Dec 2021 22:12:21 +0100
Message-ID: <CA+fCnZcDjTn0A4a3zdxVQ7+a90yt3zUHthMxFHa1XdHm+n+G3g@mail.gmail.com>
Subject: Re: [PATCH 27/31] kasan, vmalloc: add vmalloc support to HW_TAGS
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 3, 2021 at 1:41 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, Nov 30, 2021 at 11:08PM +0100, andrey.konovalov@linux.dev wrote:
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > This patch adds vmalloc tagging support to HW_TAGS KASAN.
> >
> > The key difference between HW_TAGS and the other two KASAN modes
> > when it comes to vmalloc: HW_TAGS KASAN can only assign tags to
> > physical memory. The other two modes have shadow memory covering
> > every mapped virtual memory region.
> >
> > This patch makes __kasan_unpoison_vmalloc() for HW_TAGS KASAN:
> >
> > - Skip non-VM_ALLOC mappings as HW_TAGS KASAN can only tag a single
> >   mapping of normal physical memory; see the comment in the function.
> > - Generate a random tag, tag the returned pointer and the allocation.
> > - Propagate the tag into the page stucts to allow accesses through
> >   page_address(vmalloc_to_page()).
> >
> > The rest of vmalloc-related KASAN hooks are not needed:
> >
> > - The shadow-related ones are fully skipped.
> > - __kasan_poison_vmalloc() is kept as a no-op with a comment.
> >
> > Poisoning of physical pages that are backing vmalloc() allocations
> > is skipped via __GFP_SKIP_KASAN_UNPOISON: __kasan_unpoison_vmalloc()
> > poisons them instead.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Co-developed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>
> This is missing a Signed-off-by from Vincenzo.

I didn't add it myself as the patch is significantly modified from its
original version.

I'll ask Vincenzo to review when I send v2.

Thanks!
