Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302BB5AA3AF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 01:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbiIAX0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 19:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbiIAX0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 19:26:32 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ED853D2B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 16:26:31 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-334dc616f86so2038957b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 16:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=MTexhQmqymGfgaxSOwwhDwyp4l4FCh8W15KC6mgK2Nc=;
        b=R2o6wZ8rHFTrHg65HWm+sx7byON9XQMo2S9w2qAr7v877njUCnx965lCh5TDybN3fG
         szmKzMNl71kGYs2aeFk6xjyeuwbcVXFkgv5zAw3bvGqos+UnSn816jqobAwL2+pCKfzT
         W/26u7xLOQdtA3Iw5anxeOSG5ErmbCcWCr5YsjjqabfauOlrQtzEGoFnvplqQCIdYxIL
         JHJRAAIhmj8btwRvGxQl9ZtbveVvnZGjC/uV9Rjf9ChCAajmCvS7vnrSasRk1z2iew0z
         pngvq428HmyvaCXLmHtMjuform5IaN6EQQhsiphDW/8GvGNJPFbKid2FCogV2++SPCK8
         Dr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=MTexhQmqymGfgaxSOwwhDwyp4l4FCh8W15KC6mgK2Nc=;
        b=qUG+2a4BAvLPdJbaaUlI5GHNl/mPaJ6KtTR3Gw8DknWcPeASOtp+vABCq8C+K4TYSd
         WY4uW2Lyuku33zU7yQ9UCB+j/zDz+euHPjdmySOfUHmhuTc41r6IwJJ9oRnMUIHb4DL6
         uXBnd252/HJhHaKMHOKqiniZgjNVJySueJA0cg8KkcMn2SoFnhAIQea0ls6oDdSzS4tV
         RibKUZkH52XxfwDrbyyQYv8uHdvjr5MMA/UXGqyVUYIHnqXrg494q2hBGWfW1MjSU0R0
         194n7x3JRvGNZK5csoQ4Ufmo+096KzoShYVuWr87Fs5D8X1JhULIkzcytjZbwvVR8v4/
         LtvQ==
X-Gm-Message-State: ACgBeo35lwO17eEtAF21CMg9ZfuL8p1Ox1hbqbhbTP0H+6xHKBpdJAuw
        haFiEeM9gBAh/uFFeVVWisndrkAlQK3JFyGBk+rZdA==
X-Google-Smtp-Source: AA6agR7ryflRVLt0ycp3Tc1PbYwVBnDj1avkVAWAyik3VlypjQVDlR3+/VVpBD5mYLXhgprc+mz5ihSb0hJesE8YyOE=
X-Received: by 2002:a0d:e7c3:0:b0:344:8cee:c384 with SMTP id
 q186-20020a0de7c3000000b003448ceec384mr4260095ywe.514.1662074790746; Thu, 01
 Sep 2022 16:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com> <20220901205819.emxnnschszqv4ahy@moria.home.lan>
In-Reply-To: <20220901205819.emxnnschszqv4ahy@moria.home.lan>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 1 Sep 2022 16:26:19 -0700
Message-ID: <CAJuCfpGNcZovncozo+Uxfhjwqh3BtGXsws+4QeT6Zy1mcQRJbQ@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND 00/28] per-VMA locks proposal
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <michel@lespinasse.org>,
        Jerome Glisse <jglisse@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Laurent Dufour <laurent.dufour@fr.ibm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Song Liu <songliubraving@fb.com>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>, dhowells@redhat.com,
        Hugh Dickins <hughd@google.com>, bigeasy@linutronix.de,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Minchan Kim <minchan@google.com>,
        kernel-team <kernel-team@android.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 1:58 PM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Thu, Sep 01, 2022 at 10:34:48AM -0700, Suren Baghdasaryan wrote:
> > Resending to fix the issue with the In-Reply-To tag in the original
> > submission at [4].
> >
> > This is a proof of concept for per-vma locks idea that was discussed
> > during SPF [1] discussion at LSF/MM this year [2], which concluded with
> > suggestion that =E2=80=9Ca reader/writer semaphore could be put into th=
e VMA
> > itself; that would have the effect of using the VMA as a sort of range
> > lock. There would still be contention at the VMA level, but it would be=
 an
> > improvement.=E2=80=9D This patchset implements this suggested approach.
> >
> > When handling page faults we lookup the VMA that contains the faulting
> > page under RCU protection and try to acquire its lock. If that fails we
> > fall back to using mmap_lock, similar to how SPF handled this situation=
.
> >
> > One notable way the implementation deviates from the proposal is the wa=
y
> > VMAs are marked as locked. Because during some of mm updates multiple
> > VMAs need to be locked until the end of the update (e.g. vma_merge,
> > split_vma, etc). Tracking all the locked VMAs, avoiding recursive locks
> > and other complications would make the code more complex. Therefore we
> > provide a way to "mark" VMAs as locked and then unmark all locked VMAs
> > all at once. This is done using two sequence numbers - one in the
> > vm_area_struct and one in the mm_struct. VMA is considered locked when
> > these sequence numbers are equal. To mark a VMA as locked we set the
> > sequence number in vm_area_struct to be equal to the sequence number
> > in mm_struct. To unlock all VMAs we increment mm_struct's seq number.
> > This allows for an efficient way to track locked VMAs and to drop the
> > locks on all VMAs at the end of the update.
>
> I like it - the sequence numbers are a stroke of genuius. For what it's d=
oing
> the patchset seems almost small.

Thanks for reviewing it!

>
> Two complaints so far:
>  - I don't like the vma_mark_locked() name. To me it says that the caller
>    already took or is taking the lock and this function is just marking t=
hat
>    we're holding the lock, but it's really taking a different type of loc=
k. But
>    this function can block, it really is taking a lock, so it should say =
that.
>
>    This is AFAIK a new concept, not sure I'm going to have anything good =
either,
>    but perhaps vma_lock_multiple()?

I'm open to name suggestions but vma_lock_multiple() is a bit
confusing to me. Will wait for more suggestions.

>
>  - I don't like the #ifdef and the separate fallback path in the fault ha=
ndlers.
>
>    Can we make find_and_lock_anon_vma() do the right thing, and not fail =
unless
>    e.g. there isn't a vma at that address? Just have it wait for vm_lock_=
seq to
>    change and then retry if needed.

I think it can be done but would come with additional complexity. I
was really trying to keep things as simple as possible after SPF got
shot down on the grounds of complexity. I hope to start simple and
improve only when necessary.
