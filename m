Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B4251A56C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353415AbiEDQ1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353447AbiEDQ1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:27:48 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A07D46B30
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 09:24:04 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-e5e433d66dso1676245fac.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 09:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zo3O6tVQd44QV+x14eWm1UztwGioRdt6e/ffaJNkFVk=;
        b=liDHjBfLPT03qcEt5udttgxkBTlhkRj9QEnRjXqeDsGrQRYS1FSPoazeSWJPZLAMyU
         a2MeQW559qQu9bBU+g4rBc/O0nKIqVUQN5/Ui9Hen7gD/IO8KpywTphZ5lsDcONdNwkI
         zYhhfKc+0TUPOH7cURTrnodrtzKw/QPWLStxtEsHd7oXucjnz1GF+sbU5Hwl4q3kqLAf
         xmtAu6IGgFQH2e+fVzpCcTSyT/ldQjVs2SQJ6CX0NhnyRoE46sKAw2GcQPPXz6AZl0mj
         vQbi3DLL+yebcIQV/Offd+ZatlVFtrMtzhDuonkUXXfcprfyRjjGJnYyL0Yf1glmjGZK
         NMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zo3O6tVQd44QV+x14eWm1UztwGioRdt6e/ffaJNkFVk=;
        b=dGu4AZy0ImFdyKVq1UUIxpz2YhhilTfDDeFQdDqq1o/ZtLzQBdgRmxrwlCMqfmMmtM
         a/1096qB6S0qlxE8j22Zv7kYwHfe+zRGJMa5iy4W6yrvuABKhVYDpGRdkA6LkE+bV+id
         /1mjsp8NTNeod1xoT0Er6q00IXzvlY1r+g3vR1zv6FBfs3XzA/KP52NExuN3AuC5hPDA
         z6WXGF0JajuS+9npGbOpGMYKDPMWHOQBDV6QncM0HYWi32zjQts4HmLvd0O6u/C+0ocA
         L97gjnVXzfL5oBtShJxo/Z1jjqR1bM8CYQZXotOEpGv4rq9qCmljLZl5EK+mKBMcFI5H
         /quA==
X-Gm-Message-State: AOAM5319n/Z/sCzI1rGMcgF+CTnPJTK+YDtV+l+cGPitzWlCXTZD3laz
        UUHKNKOSujKBDSuNMaTz+YYYRQ==
X-Google-Smtp-Source: ABdhPJxvTbJfQYVVkk06vmzUGhiMMpd6Af2yf8dg0IE6RS4vB2z6lPNUei0kcgWWXLi3e5slxqg8vg==
X-Received: by 2002:a05:6870:5708:b0:db:2ef8:f220 with SMTP id k8-20020a056870570800b000db2ef8f220mr131572oap.198.1651681443863;
        Wed, 04 May 2022 09:24:03 -0700 (PDT)
Received: from localhost ([8.34.116.185])
        by smtp.gmail.com with ESMTPSA id b21-20020a056870b25500b000eba4901e57sm5699113oam.17.2022.05.04.09.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 09:24:03 -0700 (PDT)
Date:   Wed, 4 May 2022 09:23:14 -0700
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        Michel Lespinasse <walken.cr@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: Memory allocation on speculative fastpaths
Message-ID: <YnKocgiWrupyFki3@cmpxchg.org>
References: <20220503155913.GA1187610@paulmck-ThinkPad-P17-Gen-1>
 <YnFSfc8BR8CadOtw@dhcp22.suse.cz>
 <20220503163905.GM1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnF0RyBaBSC1mdKo@casper.infradead.org>
 <CAJuCfpG8mBCV8O=FWwTJj8zfoh68fH9kBraMEjxKUvCyEw2MFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpG8mBCV8O=FWwTJj8zfoh68fH9kBraMEjxKUvCyEw2MFw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 04:15:46PM -0700, Suren Baghdasaryan wrote:
> On Tue, May 3, 2022 at 11:28 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, May 03, 2022 at 09:39:05AM -0700, Paul E. McKenney wrote:
> > > On Tue, May 03, 2022 at 06:04:13PM +0200, Michal Hocko wrote:
> > > > On Tue 03-05-22 08:59:13, Paul E. McKenney wrote:
> > > > > Hello!
> > > > >
> > > > > Just following up from off-list discussions yesterday.
> > > > >
> > > > > The requirements to allocate on an RCU-protected speculative fastpath
> > > > > seem to be as follows:
> > > > >
> > > > > 1.        Never sleep.
> > > > > 2.        Never reclaim.
> > > > > 3.        Leave emergency pools alone.
> > > > >
> > > > > Any others?
> > > > >
> > > > > If those rules suffice, and if my understanding of the GFP flags is
> > > > > correct (ha!!!), then the following GFP flags should cover this:
> > > > >
> > > > >   __GFP_NOMEMALLOC | __GFP_NOWARN
> > > >
> > > > GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_NOWARN
> > >
> > > Ah, good point on GFP_NOWAIT, thank you!
> >
> > Johannes (I think it was?) made the point to me that if we have another
> > task very slowly freeing memory, a task in this path can take advantage
> > of that other task's hard work and never go into reclaim.  So the
> > approach we should take is:

Right, GFP_NOWAIT can starve out other allocations. It can clear out
the freelists without the burden of having to do reclaim like
everybody else wanting memory during a shortage. Including GFP_KERNEL.

In smaller doses and/or for privileged purposes (e.g. single-argument
kfree_rcu ;)), those allocations are fine. But because the context is
page tables specifically, it would mean that userspace could trigger a
large number of those and DOS other applications and the kernel.

> > p4d_alloc(GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_NOWARN);
> > pud_alloc(GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_NOWARN);
> > pmd_alloc(GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_NOWARN);
> >
> > if (failure) {
> >   rcu_read_unlock();
> >   do_reclaim();
> >   return FAULT_FLAG_RETRY;
> > }
> >
> > ... but all this is now moot since the approach we agreed to yesterday
> > is:
> 
> I think the discussion was about the above approach and Johannes
> suggested to fallback to the normal pagefault handling with mmap_lock
> locked if PMD does not exist. Please correct me if I misunderstood
> here.

Yeah. Either way works, as long as the task is held accountable.
