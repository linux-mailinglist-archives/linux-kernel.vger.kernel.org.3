Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2094D533D66
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243968AbiEYNMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiEYNMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:12:09 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9911B6B
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:12:07 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id q20so7107490qtw.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DRlg5c8ylNh5PSHKrNNBpxR43/W9/VLsRV/iCMocZ0U=;
        b=Ux3JSCmqOoRojgkP0EYey8DO/n8s1DJL5kHW/U7IfULdVVqH2vJJ0mIqHlNtL3mBs/
         tkIdUp7KLMi8YuXqNZ+h/sL/ESRmtB668iX86lI9dKtr9hydQ4ovURIpNcAJw13pjMrD
         7iua/1Xlnr53dQwAHKj7yjC9SRe5AeHWJ5VS9/lAI5tNALHL5hloyJ68HC+ulVjvj5xz
         ra1bXZaxJzmGrxT+M9zmNS7YuGqo+6IV0JcuuirEulHL6Wm3gJpblkVucPbJ+r3opOjK
         e63qd2PK0MRfDoCruUgqDb8+b8SIPr70j1gGo/LzjYC9HeQouVaR0FpmqNGXE9x6Dgr6
         vEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DRlg5c8ylNh5PSHKrNNBpxR43/W9/VLsRV/iCMocZ0U=;
        b=10l5gFJWTXX/EQy+wq2f1RYPuURntbJBLPVSVe+7lfAZZuo2GxpVXZEdSajbSrg8zz
         zO0v1TfFRuxVUjToTq0EA134ZhFAEahbgoVHpmBtjhB9kn6Vgvu194Y+6O/pHYgRG+HQ
         tFRsdwZsboAiPG1+gBXgJX4TgwTeZllH7iWc3hdG5CNjdvLHIOBaZU8XjjcNPafiCXRa
         Q/H/SdVl6C+UOumtMSbEOMjqU05lyTecBcZAEglJiOk1JScjXGCLdCs4ocTMXOfDWBjI
         8KdIK6FeRO7NBxGgeh7ZNFb2AS95flNiveCZ0ftP9qzC7BPVB6cOAgmo4qkk7RZoYbGC
         P/aA==
X-Gm-Message-State: AOAM530atqrMQmdIzPITb0+z43a4H7z1fN39pMEtI3jDUe4BKHW7vEDl
        u5sA/WNC2WJ/1xYKks7WZxsh2y3GBTjAZQ==
X-Google-Smtp-Source: ABdhPJwHuJEO5WEgjEkEkOz/ET7ou1QmBPjdjVacMERfxgWwoIwkd2WANDeV4Hn3VSfBPl+0e+VfRQ==
X-Received: by 2002:a05:622a:1484:b0:2f3:c837:57a6 with SMTP id t4-20020a05622a148400b002f3c83757a6mr24561524qtx.460.1653484326780;
        Wed, 25 May 2022 06:12:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:741f])
        by smtp.gmail.com with ESMTPSA id s12-20020a05620a030c00b006a36dedb53bsm1197381qkm.45.2022.05.25.06.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:12:06 -0700 (PDT)
Date:   Wed, 25 May 2022 09:12:05 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        Michel Lespinasse <walken.cr@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: Memory allocation on speculative fastpaths
Message-ID: <Yo4rJetyMEWqzIho@cmpxchg.org>
References: <20220503155913.GA1187610@paulmck-ThinkPad-P17-Gen-1>
 <YnFSfc8BR8CadOtw@dhcp22.suse.cz>
 <20220503163905.GM1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnF0RyBaBSC1mdKo@casper.infradead.org>
 <CAJuCfpG8mBCV8O=FWwTJj8zfoh68fH9kBraMEjxKUvCyEw2MFw@mail.gmail.com>
 <YnKocgiWrupyFki3@cmpxchg.org>
 <1a0a859b-1f25-5136-bb86-9efe68aabbb8@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a0a859b-1f25-5136-bb86-9efe68aabbb8@suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 10:37:15PM +0200, Vlastimil Babka wrote:
> On 5/4/22 18:23, Johannes Weiner wrote:
> > On Tue, May 03, 2022 at 04:15:46PM -0700, Suren Baghdasaryan wrote:
> >> On Tue, May 3, 2022 at 11:28 AM Matthew Wilcox <willy@infradead.org> wrote:
> >>>
> >>> On Tue, May 03, 2022 at 09:39:05AM -0700, Paul E. McKenney wrote:
> >>>> On Tue, May 03, 2022 at 06:04:13PM +0200, Michal Hocko wrote:
> >>>>> On Tue 03-05-22 08:59:13, Paul E. McKenney wrote:
> >>>>>> Hello!
> >>>>>>
> >>>>>> Just following up from off-list discussions yesterday.
> >>>>>>
> >>>>>> The requirements to allocate on an RCU-protected speculative fastpath
> >>>>>> seem to be as follows:
> >>>>>>
> >>>>>> 1.        Never sleep.
> >>>>>> 2.        Never reclaim.
> >>>>>> 3.        Leave emergency pools alone.
> >>>>>>
> >>>>>> Any others?
> >>>>>>
> >>>>>> If those rules suffice, and if my understanding of the GFP flags is
> >>>>>> correct (ha!!!), then the following GFP flags should cover this:
> >>>>>>
> >>>>>>   __GFP_NOMEMALLOC | __GFP_NOWARN
> >>>>>
> >>>>> GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_NOWARN
> >>>>
> >>>> Ah, good point on GFP_NOWAIT, thank you!
> >>>
> >>> Johannes (I think it was?) made the point to me that if we have another
> >>> task very slowly freeing memory, a task in this path can take advantage
> >>> of that other task's hard work and never go into reclaim.  So the
> >>> approach we should take is:
> > 
> > Right, GFP_NOWAIT can starve out other allocations. It can clear out
> > the freelists without the burden of having to do reclaim like
> > everybody else wanting memory during a shortage. Including GFP_KERNEL.
> 
> FTR, I wonder if this is really true, given the suggested fallback.

                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

IIRC adding this fallback was the conclusion of the in-person
discussion. Above I just tried to summarize for the record the
original concern that led to it. I could have been more clear.

Your analysis is dead on, of course.
