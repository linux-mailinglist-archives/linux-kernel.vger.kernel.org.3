Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2129519235
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 01:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244134AbiECXTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 19:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237266AbiECXTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 19:19:32 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D941D0F2
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 16:15:58 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2ebf4b91212so196364527b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 16:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zjRlZgTi/esjtP1R8TFUE8oyCrPmBm15ZczzsoLj5I4=;
        b=oAcsDfB7750w+owbU2bBj3pjY9gOdXmTF28gsX1v1Yza93xIOGG6N38asX32PatnUO
         C87KvFLrvpMKD9MjPDw4YeapxfDZAycE3wd9jvI0DUGAZlUS1VYpcFQOmxNqTqIhB5+5
         ZArzQbn/CJ34UCu0ceTUd8g3PwiI82Jb/UZFOPqSMiNb03TZJuerKaA+dmxMabcmxG3v
         zGTMe22cBu5dgoqmtOhejzScmxPiOEfL7zlrEuCFHIlpCoGT+a/rbN+AtIhJqjR3F3eP
         AtVS6T7ybvD2ZPvO64Pglu3U7M5u75Ol+fU3/p3w8KEKlfrIdRRwjhV/t0nrRc/o4TvJ
         U/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zjRlZgTi/esjtP1R8TFUE8oyCrPmBm15ZczzsoLj5I4=;
        b=5dRuZmDxvST2JjORlINGaU91I+Rj9l/crA3Sm/enMQbEPrmxgHnwq8h87GLDo2VC22
         HyQc78HfTcuA/uc+zGlEAv3C+hLIq1bTsgEx5zmGmGIY0j23qFp7YYsWAoaKBite4cQj
         nUPT9hGX2BnlC47Ak94z6D1slNg9z1Jv9p/HogxXvbW4Cj4TV914e8xw0QZQCsXB8YTx
         gX1tmC01qZ9a2eogvQvJ051Ye1wJ2JyOYr1C+3bSO+xDM3EmL5U7FoopwP5v8I4kpe5S
         KXe6lAw7sqSvOusF652WshlTbhQA6FqT6HcYyAjRVAq4VstK3krtx3KVgecN7yBF15Wn
         GqKw==
X-Gm-Message-State: AOAM530qKfVx7WelPsevtmomh7tmRfoBALUwpr47nWb4UYsuGMvisVvG
        Imw2B2SGSsSBcFP8+Fae3nCyP0Lfc5ayNNx3lLnMLg==
X-Google-Smtp-Source: ABdhPJwc+Ijxgn6zG0q/Eoq1RZHnAzGoB1cVJxys4MzkG8MfrvYSVVV6M1qDaZTMFfRWY55KfQtE+DkjsPqcs05UPhs=
X-Received: by 2002:a0d:d543:0:b0:2f7:e554:68c with SMTP id
 x64-20020a0dd543000000b002f7e554068cmr18077821ywd.380.1651619757761; Tue, 03
 May 2022 16:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220503155913.GA1187610@paulmck-ThinkPad-P17-Gen-1>
 <YnFSfc8BR8CadOtw@dhcp22.suse.cz> <20220503163905.GM1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnF0RyBaBSC1mdKo@casper.infradead.org>
In-Reply-To: <YnF0RyBaBSC1mdKo@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 3 May 2022 16:15:46 -0700
Message-ID: <CAJuCfpG8mBCV8O=FWwTJj8zfoh68fH9kBraMEjxKUvCyEw2MFw@mail.gmail.com>
Subject: Re: Memory allocation on speculative fastpaths
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>
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

On Tue, May 3, 2022 at 11:28 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, May 03, 2022 at 09:39:05AM -0700, Paul E. McKenney wrote:
> > On Tue, May 03, 2022 at 06:04:13PM +0200, Michal Hocko wrote:
> > > On Tue 03-05-22 08:59:13, Paul E. McKenney wrote:
> > > > Hello!
> > > >
> > > > Just following up from off-list discussions yesterday.
> > > >
> > > > The requirements to allocate on an RCU-protected speculative fastpath
> > > > seem to be as follows:
> > > >
> > > > 1.        Never sleep.
> > > > 2.        Never reclaim.
> > > > 3.        Leave emergency pools alone.
> > > >
> > > > Any others?
> > > >
> > > > If those rules suffice, and if my understanding of the GFP flags is
> > > > correct (ha!!!), then the following GFP flags should cover this:
> > > >
> > > >   __GFP_NOMEMALLOC | __GFP_NOWARN
> > >
> > > GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_NOWARN
> >
> > Ah, good point on GFP_NOWAIT, thank you!
>
> Johannes (I think it was?) made the point to me that if we have another
> task very slowly freeing memory, a task in this path can take advantage
> of that other task's hard work and never go into reclaim.  So the
> approach we should take is:
>
> p4d_alloc(GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_NOWARN);
> pud_alloc(GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_NOWARN);
> pmd_alloc(GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_NOWARN);
>
> if (failure) {
>   rcu_read_unlock();
>   do_reclaim();
>   return FAULT_FLAG_RETRY;
> }
>
> ... but all this is now moot since the approach we agreed to yesterday
> is:

I think the discussion was about the above approach and Johannes
suggested to fallback to the normal pagefault handling with mmap_lock
locked if PMD does not exist. Please correct me if I misunderstood
here.

>
> rcu_read_lock();
> vma = vma_lookup();
> if (down_read_trylock(&vma->sem)) {
>         rcu_read_unlock();
> } else {
>         rcu_read_unlock();
>         mmap_read_lock(mm);
>         vma = vma_lookup();
>         down_read(&vma->sem);
> }
>
> ... and we then execute the page table allocation under the protection of
> the vma->sem.
>
> At least, that's what I think we agreed to yesterday.

Honestly, I don't remember discussing vma->sem at all.
My understanding is that two approaches were differing by the section
covered by rcu_read_lock/rcu_read_unlock. The solution that you
suggested would handle pagefault completely under RCU as long as it's
possible and would fallback to the mmap_lock if it's impossible, while
Michel's implementation was taking rcu_read_lock/rcu_read_unlock for
smaller sections and would use vma->seq_number to detect any vma
changes between these sections. Your suggested approach sounds simpler
and the way I understood the comments is that we should give it a try.
Did I miss anything?
Thanks,
Suren.



>
