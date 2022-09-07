Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7665AF945
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 02:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiIGA6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 20:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiIGA6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 20:58:31 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB08979F1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 17:58:30 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id f131so3745568ybf.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 17:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=UjaiWINnbTXgT+URtVXx1fGemLW7KAjAuDjBEcKQcpw=;
        b=EAkdAoJF93b/9wVcZWS/8Z33Wh8Eq7xG8wCxKPHNm0Lldc4C5bChxoQDfIHIPRDYax
         E+7oO+L2O6scu7V+5fNLALkC2gSW3KtuP3tfNpYEXGlOWDD2sTiTX6OWgeeJAcpYfcqc
         A7KFsvQIqZJC3pSoupGeVX3b2h2lXfNqXDDwmhewWl9SZYpSIQb+K3ijuHEHBKnlI5iN
         5YTs4xJNgeAVeEvcjs3kD0qLdfQNKm1QP8zoW0R448XpFNwDG9J12DbqDl3vZ1zKXm72
         +HSPLoCsmPAhUhpPj99b2yJIbwOsGllYC7rvCmcvKG+KcIcU1HoAeaosy/7TBlwl5auu
         e43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=UjaiWINnbTXgT+URtVXx1fGemLW7KAjAuDjBEcKQcpw=;
        b=rDVieBXGkaeg8o5O0ZEBygCGaIuhqe4woJZtu4coVKcZQP5PlSMLWr4ojdxwmO7Q+h
         fk8lV0u7tyaESakWqBMnKCPxb4AEu/wHrGnbpbjlxGHkb5fgIMOHTT8bCm5dt9H7apV9
         yoI2Nk/QVreNsY6CwUyFau99cp/EqFbxt5pvsnKqvWDQtE/pMy1EqSEu7PaAs3gXsrtw
         E/EH21x1OVxzczNCZJNVS2SW7SGxCpV1E4z5T/NiYXN0WXeKc6c6BJwm6iDm3NPcVLYr
         Tlhe2AtUin7YDDY/fSygF6sh2j+5fcv7pn0Y6NniaBsbPgszIw8fwZ5MPXZbLI4BLDoO
         fTPg==
X-Gm-Message-State: ACgBeo3PT8JzeJeXcFdyJKM1S/Y87gQd8T6pflBbNf/PXZS4k5eZFp9c
        q8/smXQaUojTg4jQGpqjpEVvbD9WHDA2v7HgprGXBQ==
X-Google-Smtp-Source: AA6agR7/aESfD9/NDPsDFtQ7YKYMRNuKLSwT1FUjw+G1bf9VJ00olfdLIYvwBbmvvuSYroc7vvTiDT6ZBY0OsHmp1Qc=
X-Received: by 2002:a25:9781:0:b0:6a9:561a:c143 with SMTP id
 i1-20020a259781000000b006a9561ac143mr995480ybo.59.1662512309570; Tue, 06 Sep
 2022 17:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com> <20220901173516.702122-20-surenb@google.com>
 <YxeiB2la/9fZEzLO@xz-m1.local> <CAJuCfpHkjHAAmKAJH=cxhFmwMawUDQJccwKa8k=xXNZZ1knT7g@mail.gmail.com>
 <YxesBqZ+L+oeQv5e@xz-m1.local>
In-Reply-To: <YxesBqZ+L+oeQv5e@xz-m1.local>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 6 Sep 2022 17:58:18 -0700
Message-ID: <CAJuCfpFpOT3KOBCjcnTo9D3AWq_GT9bKNyQ4xcwLJh1UPF6FFA@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND 19/28] mm: disallow do_swap_page to handle page
 faults under VMA lock
To:     Peter Xu <peterx@redhat.com>
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
        Song Liu <songliubraving@fb.com>,
        David Hildenbrand <david@redhat.com>, dhowells@redhat.com,
        Hugh Dickins <hughd@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kent Overstreet <kent.overstreet@linux.dev>,
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

On Tue, Sep 6, 2022 at 1:22 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Sep 06, 2022 at 01:08:10PM -0700, Suren Baghdasaryan wrote:
> > On Tue, Sep 6, 2022 at 12:39 PM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Thu, Sep 01, 2022 at 10:35:07AM -0700, Suren Baghdasaryan wrote:
> > > > Due to the possibility of do_swap_page dropping mmap_lock, abort fault
> > > > handling under VMA lock and retry holding mmap_lock. This can be handled
> > > > more gracefully in the future.
> > > >
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > ---
> > > >  mm/memory.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > index 9ac9944e8c62..29d2f49f922a 100644
> > > > --- a/mm/memory.c
> > > > +++ b/mm/memory.c
> > > > @@ -3738,6 +3738,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > > >       vm_fault_t ret = 0;
> > > >       void *shadow = NULL;
> > > >
> > > > +     if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> > > > +             ret = VM_FAULT_RETRY;
> > > > +             goto out;
> > > > +     }
> > > > +
> > >
> > > May want to fail early similarly for handle_userfault() too for similar
> > > reason.  Thanks,
> >
> > I wasn't aware of a similar issue there. Will have a closer look. Thanks!
>
> Sure.
>
> Just in case this would be anything helpful - handle_userfault() will both
> assert at the entry (mmap_assert_locked) and will in most cases release
> read lock along the way when waiting for page fault resolutions.
>
> And userfaultfd should work on anonymous memory for either missing mode or
> write protect mode.

Got it. Thanks for the explanation. It definitely helps!

>
> Thanks,
>
> --
> Peter Xu
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
