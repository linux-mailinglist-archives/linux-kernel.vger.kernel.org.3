Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEC2552E3F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348386AbiFUJ1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347480AbiFUJ1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:27:33 -0400
Received: from outbound-smtp55.blacknight.com (outbound-smtp55.blacknight.com [46.22.136.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32171248DA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:27:32 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp55.blacknight.com (Postfix) with ESMTPS id B4102FAFE7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 10:27:30 +0100 (IST)
Received: (qmail 7506 invoked from network); 21 Jun 2022 09:27:30 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Jun 2022 09:27:30 -0000
Date:   Tue, 21 Jun 2022 10:27:28 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 7/7] mm/page_alloc: Replace local_lock with normal
 spinlock
Message-ID: <20220621092728.GE15453@techsingularity.net>
References: <20220613125622.18628-1-mgorman@techsingularity.net>
 <20220613125622.18628-8-mgorman@techsingularity.net>
 <43033655-2e78-621b-cc76-c3dc53024d00@suse.cz>
 <CAOUHufaHV9Aua3sneOnQvPhrtuxxDuJ5+c+A-zy8RufoDkmeMQ@mail.gmail.com>
 <8354ba5b-d1ce-90c7-be76-328ab9321550@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <8354ba5b-d1ce-90c7-be76-328ab9321550@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 09:57:06AM +0200, Vlastimil Babka wrote:
> On 6/16/22 23:07, Yu Zhao wrote:
> > On Thu, Jun 16, 2022 at 11:02 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> >>
> >>
> >> > @@ -3794,19 +3805,29 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
> >> >       struct list_head *list;
> >> >       struct page *page;
> >> >       unsigned long flags;
> >> > +     unsigned long __maybe_unused UP_flags;
> >> >
> >> > -     local_lock_irqsave(&pagesets.lock, flags);
> >> > +     /*
> >> > +      * spin_trylock_irqsave is not necessary right now as it'll only be
> >> > +      * true when contending with a remote drain. It's in place as a
> >> > +      * preparation step before converting pcp locking to spin_trylock
> >> > +      * to protect against IRQ reentry.
> >> > +      */
> >> > +     pcp_trylock_prepare(UP_flags);
> >> > +     pcp = pcp_spin_trylock_irqsave(zone->per_cpu_pageset, flags);
> >> > +     if (!pcp)
> >>
> >> Besides the missing unpin Andrew fixed, I think also this is missing
> >> pcp_trylock_finish(UP_flags); ?
> > 
> > spin_trylock only fails when trylock_finish is a NOP.
> 
> True, so it's not an active bug, but I would still add it, so it's not
> confusing and depending on non-obvious details that might later change and
> break the code.

Yes. Even though it may work, it's still wrong.

-- 
Mel Gorman
SUSE Labs
