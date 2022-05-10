Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749485225F7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 22:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbiEJU7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 16:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiEJU7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 16:59:38 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F34266F3F
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 13:59:38 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2f7d621d1caso193554637b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 13:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G/q1rnQgMaznZ39ohQawlR0ZCKw+W7Y1nNqJrW+4o7o=;
        b=CALL3wkEY3b86p74iYDdbhQTNr+tfRN+V98GpzavNOy6JN9bP1wPMlvHcih2J5MHMc
         8UGV/cPauPf41smjoWpJxvopoB6PaFtAoOLgCpClh6zk3izJT46mVl3grrPpDC8EDDeY
         Bx6n/EGn3sDgVj9MIcL7s0E82t1JbVt9MggqOzhw3XYkYzw75HFiblNjqMFBj0RJTfrg
         plh1lz39Zr+P/736TPlKm6vNE2zQTSW7iRYz1ysagi0v5o4Sm/wzrCY+zuc2Tm8rVz7/
         QXM70R2/dAzJJoJ2DxyfEpQes++QZ+l2WknycT53cdHFtC2V7dTCZwQCGb6DLFccDyHL
         r2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G/q1rnQgMaznZ39ohQawlR0ZCKw+W7Y1nNqJrW+4o7o=;
        b=RmvKcL+hQF3pnzF8+9/c/8sxHfIkGn0B6F6Y7t2NrVc87RH6yypCpTtdoZQWPhaS14
         MgbQQdYjKFcJfFbqsJEx2JMQaupwES/NhcYZmN+D9ZWUHQFVBE0B0PszuBwZ7Ivca9da
         F0Nv/KNru+UZUpiS5bhocQj6pgQY6I/RlBZi/6y4C7dqQkJ0cnwYwVq0cI/DbAcHFhZD
         KXrSGIEFrAnLHznZpcpcEwRi8ku2RE1Xh2k6EZlr3Ur8RCIvj0KA8WSB3QnROPWw6/bS
         lgDD3U1yaOqD9uHAum2UtEoaSUITjyKwaaE3JOM6LVBOHERp9h6eLNGHISCuGZfww73p
         TO6Q==
X-Gm-Message-State: AOAM531VsIWFHzvZ1IF3kgHxVK3pTOrKU0CoKKSHqm1xiajnwZE3ecdx
        pXXKrYFWidIom+sFHrAGuO7wIofBFnQB3MY51APKuw==
X-Google-Smtp-Source: ABdhPJwBQdouaCTQjdwS7J9yFY1kM4uCTbuDjL2AFdvllvzNydU7sRdMGZkZEeIDKL8Y59rkE1t1nwb9SMkkRXYb+5c=
X-Received: by 2002:a81:6cc3:0:b0:2f7:cc1f:b52d with SMTP id
 h186-20020a816cc3000000b002f7cc1fb52dmr21862524ywc.293.1652216377129; Tue, 10
 May 2022 13:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220510030014.3842475-1-surenb@google.com> <20220510030014.3842475-2-surenb@google.com>
 <YnpjNyrdqT/QxBPI@dhcp22.suse.cz> <CAJuCfpEt9SSrELZzfmcqJ7JL_nEzWGz-YE9GRUZTjU5unqQjQg@mail.gmail.com>
 <YnrQ11iou9bwN9tY@dhcp22.suse.cz>
In-Reply-To: <YnrQ11iou9bwN9tY@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 10 May 2022 13:59:26 -0700
Message-ID: <CAJuCfpGw0nfxwY0pLMW9P4fhV7qKf3DejDgH+19Bj+v30-r4pQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: drop oom code from exit_mmap
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, shuah@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        kernel-team <kernel-team@android.com>
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

On Tue, May 10, 2022 at 1:53 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 10-05-22 09:31:50, Suren Baghdasaryan wrote:
> > On Tue, May 10, 2022 at 6:06 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 09-05-22 20:00:13, Suren Baghdasaryan wrote:
> > > > With the oom-killer being able to operate on locked pages, exit_mmap
> > > > does not need to ensure that oom_reap_task_mm is done before it can
> > > > proceed. Instead it can rely on mmap_lock write lock to prevent
> > > > oom-killer from operating on the vma tree while it's freeing page
> > > > tables. exit_mmap can hold mmap_lock read lock when unmapping vmas
> > > > and then take mmap_lock write lock before freeing page tables.
> > >
> > > The changelog is rather light on nasty details which might be good but
> > > for the sake of our future us let's be more verbose so that we do not
> > > have to reinvent the prior history each time we are looking into this
> > > code. I would go with something like this instead:
> > > "
> > > The primary reason to invoke the oom reaper from the exit_mmap path used
> > > to be a prevention of an excessive oom killing if the oom victim exit
> > > races with the oom reaper (see 212925802454 ("mm: oom: let oom_reap_task
> > > and exit_mmap run concurrently") for more details. The invocation has
> > > moved around since then because of the interaction with the munlock
> > > logic but the underlying reason has remained the same (see 27ae357fa82b
> > > ("mm, oom: fix concurrent munlock and oom reaper unmap, v3").
> > >
> > > Munlock code is no longer a problem since a213e5cf71cb ("mm/munlock:
> > > delete munlock_vma_pages_all(), allow oomreap") and there shouldn't be
> > > any blocking operation before the memory is unmapped by exit_mmap so
> > > the oom reaper invocation can be dropped. The unmapping part can be done
> > > with the non-exclusive mmap_sem and the exclusive one is only required
> > > when page tables are freed.
> > >
> > > Remove the oom_reaper from exit_mmap which will make the code easier to
> > > read. This is really unlikely to make any observable difference although
> > > some microbenchmarks could benefit from one less branch that needs to be
> > > evaluated even though it almost never is true.
> > > "
> >
> > Looks great! Thanks for collecting all the history. Will update the description.
>
> Please make sure you double check the story. This is mostly my
> recollection and brief reading through the said commits. I might
> misremember here and there.

Will do. Thanks!

> --
> Michal Hocko
> SUSE Labs
