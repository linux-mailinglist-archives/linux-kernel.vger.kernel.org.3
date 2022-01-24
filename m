Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210F4497C80
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbiAXJ5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:57:44 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:56528 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiAXJ5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:57:41 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3E93621122;
        Mon, 24 Jan 2022 09:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643018260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3I0W7aX99uBZEBl2pnVuMlRFfqNgaPY9e+6cid2Tofc=;
        b=tgNCB7GIulaUwtUgc9fYEchKX7Ic867VG4GAt7BeHL4Dwc2Kw8K2qludbTyCBTK36M0aNF
        SbgD4jCJ4Fj+eVPnJ4Y36u/gcyE5h5O5BDgBg6eGP7EkutURg2uGdLXZDsEobDOpzwIw9x
        bR0jKAJs0pGSKOVX4pQZElQ4k27QQOo=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 08F33A3B81;
        Mon, 24 Jan 2022 09:57:39 +0000 (UTC)
Date:   Mon, 24 Jan 2022 10:57:36 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>
Subject: Re: [RESEND][PATCH v2] mm: don't call lru draining in the nested
 lru_cache_disable
Message-ID: <Ye54ELlNBpeHoXsj@dhcp22.suse.cz>
References: <20211230193627.495145-1-minchan@kernel.org>
 <YeVzWlrojI1+buQx@dhcp22.suse.cz>
 <YedXhpwURNTkW1Z3@google.com>
 <YefX1t4owjlx/m5I@dhcp22.suse.cz>
 <YejkUlnnYeED1pC5@google.com>
 <YekcNmBqcpO9BYWv@dhcp22.suse.cz>
 <YenPK/JVNOhbxjtr@google.com>
 <YeqEBAKJ6NUjLQhr@dhcp22.suse.cz>
 <YessDywpsnCyrfIy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YessDywpsnCyrfIy@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 21-01-22 13:56:31, Minchan Kim wrote:
> On Fri, Jan 21, 2022 at 10:59:32AM +0100, Michal Hocko wrote:
> > On Thu 20-01-22 13:07:55, Minchan Kim wrote:
> > > On Thu, Jan 20, 2022 at 09:24:22AM +0100, Michal Hocko wrote:
> > > > On Wed 19-01-22 20:25:54, Minchan Kim wrote:
> > > > > On Wed, Jan 19, 2022 at 10:20:22AM +0100, Michal Hocko wrote:
> > > > [...]
> > > > > > What does prevent you from calling lru_cache_{disable,enable} this way
> > > > > > with the existing implementation? AFAICS calls can be nested just fine.
> > > > > > Or am I missing something?
> > > > > 
> > > > > It just increases more IPI calls since we drain the lru cache
> > > > > both upper layer and lower layer. That's I'd like to avoid
> > > > > in this patch. Just disable lru cache one time for entire
> > > > > allocation path.
> > > > 
> > > > I do not follow. Once you call lru_cache_disable at the higher level
> > > > then no new pages are going to be added to the pcp caches. At the same
> > > > time existing caches are flushed so the inner lru_cache_disable will not
> > > > trigger any new IPIs.
> > > 
> > > lru_cache_disable calls __lru_add_drain_all with force_all_cpus
> > > unconditionally so keep calling the IPI.
> > 
> > OK, this is something I have missed. Why cannot we remove the force_all
> > mode for lru_disable_count>0 when there are no pcp caches populated?
> 
> Couldn't gaurantee whether the IPI is finished with only atomic counter.
> 
> CPU 0                               CPU 1
> lru_cache_disable                   lru_cache_disable
>   ret = atomic_inc_return
>                                     
>                                    ret = atomic_inc_return
>   lru_add_drain_all(ret == 1);     lru_add_drain_all(ret == 1)
>     IPI ongoing                    skip IPI
>                                    alloc_contig_range
>                                    fail
>     ..
>     ..
> 
>    IPI done

But __lru_add_drain_all uses a local mutex while the IPI flushing is
done so the racing lru_cache_disable would block until
flush_work(&per_cpu(lru_add_drain_work, cpu)) completes so all IPIs are
handled. Or am I missing something?

-- 
Michal Hocko
SUSE Labs
