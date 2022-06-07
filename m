Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD174541246
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 21:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357496AbiFGTph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 15:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346605AbiFGSrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 14:47:35 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06EE5F8E0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:02:48 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id c2so10103291lfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 11:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g/56BYII9OBXonF0imNSJohcsbyEfufCZ0LUG6wSdzE=;
        b=J0d79tx+dbGDuOg3o0/fm3w4ssEEObOTPga7N1MneChy6ZXVxQPYxz43YXJqrCJRyO
         5p2zG8hA43nQPcQR/zOZutQsam8sXGsNEq69ySWQX8ego3rJ/MRfbhCo0eliUXmdZlBy
         PfXLG2aqwy7rMXvxmP3etCLcaVWyJFqjIwJr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/56BYII9OBXonF0imNSJohcsbyEfufCZ0LUG6wSdzE=;
        b=eCXVsr5pIscAObv8R/QIeDQoouldt19H0/TbddrT/saE9sa5W3TMR+kuRh1Me3cGqy
         c3fhPuZ0aqF9rLGrV91a9or+70B7KOhiCYW8cXVx2Xpf6OwVwmF2ybc8tbjIy222axRR
         L8UBowHhWNI1NGCtCxOpIFg2j2oHbMiH+rpDWNZnOeNI1GYxJavM8yLl6jgt6ATGiV2X
         M0mkKQmCQlRxUE1r4CE92U0FODGv9sxnUWiPX7+gmqcJEHywoYBoY1EZogdoTuHSINCK
         gr2K54t04wvkPW1I0WRMk5iweR3IS6xiCAq/8zdYBtB3E6OK9L8Zyx0BfrtElyZqXCWm
         D7Ww==
X-Gm-Message-State: AOAM532C3WQkRw2ebVrhMmXOuRGchii3qyheK12BK0MppqAob9xgdlHJ
        Eu4l2oxSwV7wpgOfRKPUgdtTiS+KYUwfeEgBGik=
X-Google-Smtp-Source: ABdhPJwhEyG1ML7ZIBqHX80f1CVhbpfW2MuhN0qW35pd62XzMwcKvPlI4j8jbFQjVZ1W9eg58fgdRg==
X-Received: by 2002:a05:6512:25a6:b0:479:1238:22b6 with SMTP id bf38-20020a05651225a600b00479123822b6mr18053925lfb.439.1654624966689;
        Tue, 07 Jun 2022 11:02:46 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id g23-20020ac24d97000000b0047255d21153sm3352347lfe.130.2022.06.07.11.02.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 11:02:46 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id e4so4171895ljl.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 11:02:46 -0700 (PDT)
X-Received: by 2002:a5d:6da6:0:b0:20f:bc8a:9400 with SMTP id
 u6-20020a5d6da6000000b0020fbc8a9400mr28604127wrs.274.1654624577769; Tue, 07
 Jun 2022 10:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
 <CAHk-=wh89D_69JZtB0MNKbrTM4dPJisK6E0yFKH-hA++F13mzw@mail.gmail.com> <87k09s1pgo.fsf@oracle.com>
In-Reply-To: <87k09s1pgo.fsf@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Jun 2022 10:56:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj9En-BC4t7J9xFZOws5ShwaR9yor7FxHZr8CTVyEP_+Q@mail.gmail.com>
Message-ID: <CAHk-=wj9En-BC4t7J9xFZOws5ShwaR9yor7FxHZr8CTVyEP_+Q@mail.gmail.com>
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
        Joao Martins <joao.m.martins@oracle.com>
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

On Tue, Jun 7, 2022 at 8:10 AM Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
> For highmem and page-at-a-time archs we would need to keep some
> of the same optimizations (via the common clear/copy_user_highpages().)

Yeah, I guess that we could keep the code for legacy use, just make
the existing code be marked __weak so that it can be ignored for any
further work.

IOW, the first patch might be to just add that __weak to
'clear_huge_page()' and 'copy_user_huge_page()'.

At that point, any architecture can just say "I will implement my own
versions of these two".

In fact, you can start with just one or the other, which is probably
nicer to keep the patch series smaller (ie do the simpler
"clear_huge_page()" first).

I worry a bit about the insanity of the "gigantic" pages, and the
mem_map_next() games it plays, but that code is from 2008 and I really
doubt it makes any sense to keep around at least for x86. The source
of that abomination is powerpc, and I do not think that whole issue
with MAX_ORDER_NR_PAGES makes any difference on x86, at least.

It most definitely makes no sense when there is no highmem issues, and
all those 'struct page' games should just be deleted (or at least
relegated entirely to that "legacy __weak function" case so that sane
situations don't need to care).

For that same HIGHMEM reason it's probably a good idea to limit the
new case just to x86-64, and leave 32-bit x86 behind.

> Right. Or doing the whole contiguous area in one or a few chunks
> chunks, and then touching the faulting cachelines towards the end.

Yeah, just add a prefetch for the 'addr_hint' part at the end.

> > Maybe an architecture could do even more radical things like "let's
> > just 'rep stos' for the whole area, but set a special thread flag that
> > causes the interrupt return to break it up on return to kernel space".
> > IOW, the "latency fix" might not even be about chunking it up, it
> > might look more like our exception handling thing.
>
> When I was thinking about this earlier, I had a vague inkling of
> setting a thread flag and defer writes to the last few cachelines
> for just before returning to user-space.
> Can you elaborate a little about what you are describing above?

So 'process_huge_page()' (and the gigantic page case) does three very
different things:

 (a) that page chunking for highmem accesses

 (b) the page access _ordering_ for the cache hinting reasons

 (c) the chunking for _latency_ reasons

and I think all of them are basically "bad legacy" reasons, in that

 (a) HIGHMEM doesn't exist on sane architectures that we care about these days

 (b) the cache hinting ordering makes no sense if you do non-temporal
accesses (and might then be replaced by a possible "prefetch" at the
end)

 (c) the latency reasons still *do* exist, but only with PREEMPT_NONE

So what I was alluding to with those "more radical approaches" was
that PREEMPT_NONE case: we would probably still want to chunk things
up for latency reasons and do that "cond_resched()" in  between
chunks.

Now, there are alternatives here:

 (a) only override that existing disgusting (but tested) function when
both CONFIG_HIGHMEM and CONFIG_PREEMPT_NONE are false

 (b) do something like this:

    void clear_huge_page(struct page *page,
        unsigned long addr_hint,
        unsigned int pages_per_huge_page)
    {
        void *addr = page_address(page);
    #ifdef CONFIG_PREEMPT_NONE
        for (int i = 0; i < pages_per_huge_page; i++)
            clear_page(addr, PAGE_SIZE);
            cond_preempt();
        }
    #else
        nontemporal_clear_big_area(addr, PAGE_SIZE*pages_per_huge_page);
        prefetch(addr_hint);
    #endif
    }

 or (c), do that "more radical approach", where you do something like this:

    void clear_huge_page(struct page *page,
        unsigned long addr_hint,
        unsigned int pages_per_huge_page)
    {
        set_thread_flag(TIF_PREEMPT_ME);
        nontemporal_clear_big_area(addr, PAGE_SIZE*pages_per_huge_page);
        clear_thread_flag(TIF_PREEMPT_ME);
        prefetch(addr_hint);
    }

and then you make the "return to kernel mode" check the TIF_PREEMPT_ME
case and actually force preemption even on a non-preempt kernel.

It's _probably_ the case that CONFIG_PREEMPT_NONE is so rare that it's
n ot even worth doing. I dunno.

And all of the above pseudo-code may _look_ like real code, but is
entirely untested and entirely handwavy "something like this".

Hmm?

               Linus
