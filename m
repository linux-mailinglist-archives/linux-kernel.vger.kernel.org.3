Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7F653F1ED
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 00:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbiFFWB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 18:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiFFWB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 18:01:26 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F6BDFD31
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 15:01:22 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id fu3so30057362ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 15:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eMj6o1dpOH0W9Y5HTwykUKgzdtPrlRWnrwX9rpljZKc=;
        b=b8/7tGHsUvQuYEuE6TdH0YhTdZGjEQ7/PD1G684q5IgDFtECbox6b5ndqcP97oaCbM
         Y0l6Oyia8uQVhys0BPY3yzBe0RhQPwP+5ngtzKQL1sR6XgRSPB5KL3p+JjGCWVhSIsj4
         I7WERSQh3C32HeCnKQiQXKWNocrpxH5DPorFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eMj6o1dpOH0W9Y5HTwykUKgzdtPrlRWnrwX9rpljZKc=;
        b=Wv4/kjv6z4S/Q+EAkrrTWVq8JccuEc1wmAKIa5nU+8LplJDEFZwGfIzQBDF41znz88
         lWvBdPWxj+xLJt70WlF7bDXkJ9vLErE8U+zMMF0UdJvwHqXqDsOwCR0elOJOJ4NCZEbq
         oCUvXcKlIn+dPwm+V5nyH9tv0XtdcVZLnfETbAphAjYyObmDcHOafEc9230XbpyXxwa5
         e1xoUMMGBt+PYu/tb/Ca9AL0bYbuR+TBcwBFHWEwWHh5izlnop7RAe3rQMfvwY9AFXXs
         Tq1Z4vsgh7e9VCCNatYBmncEBvPRVjHAnked/Qcu0A7iBql1yJUJwnbIaGXvc/WSIDTS
         gSrg==
X-Gm-Message-State: AOAM532SIFNZpDCDiTPZbcFD//ujUVPS+p4yD86+IK3CbDEKq50TJN99
        fWE4L5q3eaSNZoUJJLoWj/7p5iJ0KSl+FN1kiLw=
X-Google-Smtp-Source: ABdhPJxvQ6lKLu7qQ4NQlHVXcQ0XvCaDZwT/1Oq0bnWYXozVnxMg9WOKvn28NdF3igo50BrZ73QF1w==
X-Received: by 2002:a17:907:3f1f:b0:6fe:b40a:21f0 with SMTP id hq31-20020a1709073f1f00b006feb40a21f0mr23604926ejc.744.1654552880776;
        Mon, 06 Jun 2022 15:01:20 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id s3-20020a056402014300b0042617ba63a5sm9158098edu.47.2022.06.06.15.01.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 15:01:20 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id e5so1498940wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 15:01:19 -0700 (PDT)
X-Received: by 2002:a05:600c:4982:b0:39c:3c0d:437c with SMTP id
 h2-20020a05600c498200b0039c3c0d437cmr20758360wmp.38.1654552405818; Mon, 06
 Jun 2022 14:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
In-Reply-To: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Jun 2022 14:53:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh89D_69JZtB0MNKbrTM4dPJisK6E0yFKH-hA++F13mzw@mail.gmail.com>
Message-ID: <CAHk-=wh89D_69JZtB0MNKbrTM4dPJisK6E0yFKH-hA++F13mzw@mail.gmail.com>
Subject: Re: [PATCH v3 00/21] huge page clearing optimizations
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Jason Gunthorpe <jgg@nvidia.com>, jon.grimm@amd.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        joao.martins@oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 6, 2022 at 1:22 PM Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
> This series introduces two optimizations in the huge page clearing path:
>
>  1. extends the clear_page() machinery to also handle extents larger
>     than a single page.
>  2. support non-cached page clearing for huge and gigantic pages.
>
> The first optimization is useful for hugepage fault handling, the
> second for prefaulting, or for gigantic pages.

Please just split these two issues up into entirely different patch series.

That said, I have a few complaints about the individual patches even
in this form, to the point where I think the whole series is nasty:

 - get rid of 3/21 entirely. It's wrong in every possible way:

    (a) That shouldn't be an inline function in a header file at all.
If you're clearing several pages of data, that just shouldn't be an
inline function.

    (b) Get rid of __HAVE_ARCH_CLEAR_USER_PAGES. I hate how people
make up those idiotic pointless names.

         If you have to use a #ifdef, just use the name of the
function that the architecture overrides, not some other new name.

   But you don't need it at all, because

    (c) Just make a __weak function called clear_user_highpages() in
mm/highmem.c, and allow architectures to just create their own
non-weak ones.

 - patch 4/21 and 5/32: can  we instead just get rid of that silly
"process_huge_page()" thing entirely. It's disgusting, and it's a big
part of why 'rep movs/stos' cannot work efficiently. It also makes NO
SENSE if you then use non-temporal accesses.

   So instead of doubling down on the craziness of that function, just
get rid of it entirely.

   There are two users, and they want to clear a hugepage and copy it
respectively. Don't make it harder than it is.

    *Maybe* the code wants to do a "prefetch" afterwards. Who knows.
But I really think you sh ould do the crapectomy first, make the code
simpler and more straightforward, and just allow architectures to
override the *simple* "copy or clear a lage page" rather than keep
feeding this butt-ugly monstrosity.

 - 13/21: see 3/21.

 - 14-17/21: see 4/21 and 5/21. Once you do the crapectomy and get rid
of the crazy process_huge_page() abstraction, and just let
architectures do their own clear/copy huge pages, *all* this craziness
goes away. Those "when to use which type of clear/copy" becomes a
*local* question, no silly arch_clear_page_non_caching_threshold()
garbage.

So I really don't like this series. A *lot* of it comes from that
horrible process_huge_page() model, and the whole model is just wrong
and pointless. You're literally trying to fix the mess that that
function is, but you're keeping the fundamental problem around.

The whole *point* of your patch-set is to use non-temporal stores,
which makes all the process_huge_page() things entirely pointless, and
only complicates things.

And even if we don't use non-temporal stores, that process_huge_page()
thing makes for trouble for any "rep stos/movs" implementation that
might actualyl do a better job if it was just chunked up in bigger
chunks.

Yes, yes, you probably still want to chunk that up somewhat due to
latency reasons, but even then architectures might as well just make
their own decisions, rather than have the core mm code make one
clearly bad decision for them. Maybe chunking it up in bigger chunks
than one page.

Maybe an architecture could do even more radical things like "let's
just 'rep stos' for the whole area, but set a special thread flag that
causes the interrupt return to break it up on return to kernel space".
IOW, the "latency fix" might not even be about chunking it up, it
might look more like our exception handling thing.

So I really think that crapectomy should be the first thing you do,
and that should be that first part of "extends the clear_page()
machinery to also handle extents larger than a single page"

                Linus
