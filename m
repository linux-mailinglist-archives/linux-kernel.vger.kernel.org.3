Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9A454EC21
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 23:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378947AbiFPVIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 17:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiFPVID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 17:08:03 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82745119
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 14:08:02 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id i186so2336438vsc.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 14:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QYZC9iLsYDsaByy8JmaeJ2G98wNd/D+AjNOCL1AQkNs=;
        b=F6ti4Z21S49N0+AFdXj43ViP0q+ENG4foOKMonRNclvKZBW2Lz71cWLsGLb3e0pxmh
         c7zxQp9KWZHNh2Z1LHpAYqy64o69U1exvhyBf179TaHvNv6tq6qJ025FmKxQFzD4jcJx
         QhTSdSd4ThqXTzQZW8iLRFyIiSvv05+u2ihxE9uerdH8SaVYCuqk3DwSfA9RNFJl8Cn5
         DLEKdPcR1QoIPoldZX9tsbV2NDOJlMnXHMAfLXR0/9AVab9W2U4acuCBFVLwGR4zVuqN
         2ZOBN5vi/s88FNqX9UHmMxL3XBdFHS3CRJZ8kAE1bEaFZQbfwIyj3biE0daSpRINUZaq
         KTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QYZC9iLsYDsaByy8JmaeJ2G98wNd/D+AjNOCL1AQkNs=;
        b=XExp//RRX5DavusxKdC4T+HVkm8XDuBMZ0a9shpn4vREY2CJvX8lT88gRUb9xNk4mW
         ivhbkQ5PoVkZxYJd9qPpY4lE+EeWuUnQGefhcv8Z6iEHBOpPg5MJVMsvI+uYhrJ9LV6V
         D9FnmaEzCKf0GAAa9Ju3xLCJVVcr6qG2u8qxQJBAu6RQvbv9DyuvQA2P6h8MSvmlX1L7
         v/TfVRq0T0r9X0GYzG0mvj+VEyFYByDkKB/EPXl0PuCEPTw+QH64UI/OGN4aHEW377t6
         7o1yfe+at9ao2kiE+ZW6075GJ6q/OdAsg1Jb/affUy4rzTB/VflZpAbW7xgGMHhm4ZfM
         H1+w==
X-Gm-Message-State: AJIora8BoRQ6WFnfuwIQi8JOvxjpqZ7U6txOYADnYbY0z/TNrxsMD2ef
        owPeLm6GeJowQXZWyINns/zxoEv7WBY8ShxxK+I5Zg==
X-Google-Smtp-Source: AGRyM1uFolbScaQC6FfwKtMgJbBm1M0CZmgiZxWFQphbt2Z6rX7ZCeXMZ+tOLGbXinOqLYqUo+b1hhp8iEXBMc37I8s=
X-Received: by 2002:a05:6102:3e23:b0:34b:b6b0:2ae7 with SMTP id
 j35-20020a0561023e2300b0034bb6b02ae7mr3534210vsv.81.1655413681460; Thu, 16
 Jun 2022 14:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220613125622.18628-1-mgorman@techsingularity.net>
 <20220613125622.18628-8-mgorman@techsingularity.net> <43033655-2e78-621b-cc76-c3dc53024d00@suse.cz>
In-Reply-To: <43033655-2e78-621b-cc76-c3dc53024d00@suse.cz>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 16 Jun 2022 15:07:25 -0600
Message-ID: <CAOUHufaHV9Aua3sneOnQvPhrtuxxDuJ5+c+A-zy8RufoDkmeMQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] mm/page_alloc: Replace local_lock with normal spinlock
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
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

On Thu, Jun 16, 2022 at 11:02 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 6/13/22 14:56, Mel Gorman wrote:
> > struct per_cpu_pages is no longer strictly local as PCP lists can be
> > drained remotely using a lock for protection. While the use of local_lock
> > works, it goes against the intent of local_lock which is for "pure
> > CPU local concurrency control mechanisms and not suited for inter-CPU
> > concurrency control" (Documentation/locking/locktypes.rst)
> >
> > local_lock protects against migration between when the percpu pointer is
> > accessed and the pcp->lock acquired. The lock acquisition is a preemption
> > point so in the worst case, a task could migrate to another NUMA node
> > and accidentally allocate remote memory. The main requirement is to pin
> > the task to a CPU that is suitable for PREEMPT_RT and !PREEMPT_RT.
> >
> > Replace local_lock with helpers that pin a task to a CPU, lookup the
> > per-cpu structure and acquire the embedded lock. It's similar to local_lock
> > without breaking the intent behind the API. It is not a complete API
> > as only the parts needed for PCP-alloc are implemented but in theory,
> > the generic helpers could be promoted to a general API if there was
> > demand for an embedded lock within a per-cpu struct with a guarantee
> > that the per-cpu structure locked matches the running CPU and cannot use
> > get_cpu_var due to RT concerns. PCP requires these semantics to avoid
> > accidentally allocating remote memory.
> >
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
>
> ...
>
> > @@ -3367,30 +3429,17 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
> >       return min(READ_ONCE(pcp->batch) << 2, high);
> >  }
> >
> > -/* Returns true if the page was committed to the per-cpu list. */
> > -static bool free_unref_page_commit(struct page *page, int migratetype,
> > -                                unsigned int order, bool locked)
> > +static void free_unref_page_commit(struct per_cpu_pages *pcp, struct zone *zone,
> > +                                struct page *page, int migratetype,
> > +                                unsigned int order)
>
> Hmm given this drops the "bool locked" and bool return value again, my
> suggestion for patch 5/7 would result in less churn as those woudn't need to
> be introduced?
>
> ...
>
> > @@ -3794,19 +3805,29 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
> >       struct list_head *list;
> >       struct page *page;
> >       unsigned long flags;
> > +     unsigned long __maybe_unused UP_flags;
> >
> > -     local_lock_irqsave(&pagesets.lock, flags);
> > +     /*
> > +      * spin_trylock_irqsave is not necessary right now as it'll only be
> > +      * true when contending with a remote drain. It's in place as a
> > +      * preparation step before converting pcp locking to spin_trylock
> > +      * to protect against IRQ reentry.
> > +      */
> > +     pcp_trylock_prepare(UP_flags);
> > +     pcp = pcp_spin_trylock_irqsave(zone->per_cpu_pageset, flags);
> > +     if (!pcp)
>
> Besides the missing unpin Andrew fixed, I think also this is missing
> pcp_trylock_finish(UP_flags); ?

spin_trylock only fails when trylock_finish is a NOP.
