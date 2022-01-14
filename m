Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA8E48EE5F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 17:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243483AbiANQjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 11:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239343AbiANQjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 11:39:39 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDEFC06161C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 08:39:39 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id s1so3179007pga.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 08:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RzwZ9r7D0xuY96wzPVNuGxDwRqinQNPHQv0I4wZgmns=;
        b=giRVu3dmn7ssaVRYKP4nfYlcAMywgq88Sam+cBL9ONnnsKs7WsuMBbwCcIdsvgQZTv
         cDbk94dvHbR9ubuesRVBhgCQyoE6ERq2UzHzu1adv/rTGlvQQYByx7Md6FtQGcJU3ed1
         0tLky8vPYXR+6KPJWytP4WTAkBOLJv1HCyC2Y2FmXMGKexl+yCXBLOjqlh/VyitoQOlV
         rOkrpzAK0ZfT5JHbWkPfEmiRS45gS+fOK3RfgkCEhRZWIIXMSSXYDqM5TFnRUva1lowK
         zklR5dXWUzTOel7A7JQhLUionw/W6gs+e75Vgu7wRoCUCS/v5KIO7hvN2io1AlLK+0kC
         a7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=RzwZ9r7D0xuY96wzPVNuGxDwRqinQNPHQv0I4wZgmns=;
        b=vAE29p/AyylZMs5hF6zJHZgCqEC3qh6vkYU+RZ1CukdBaiAHetvN8bgxfXyuoiBJuK
         cQcaHJAPNtyDaU/I9roTbFNLvMZSEBjgBdJR9fYhmhql0CNtqYO0lYCnVi21ZMRML0am
         D48BiK1NXnDRTkxg5jl2LAO4VocRBfqrH6tuaQOlSBc0OGxlxTD+EjBoyBrH08/fKzm1
         DBETQjbGziggJShGlYgzuMN8WPGKbvfvFGQVEaoRjF2tjeIddPzPudLG4/hG9I7bxgiu
         wnetHF1It20GbU5jFQc9oxL7gZQdKPikwIxv9UXtB+oX85rrd2gQN2QfZsqdWHS+3qbp
         GGIg==
X-Gm-Message-State: AOAM530ZG9axm25kynKcjpyb1UZjPUZKtJllDTfNyxM2c3Tns8XIyX6l
        IJbUfXAszu4+pshstOTVij8=
X-Google-Smtp-Source: ABdhPJxlMJIT7txTEkWruImSEZL2QmOl+Iu9e3wX0LCA1Lf172CxK92MpYarHHz3TRPRuURJzT55cQ==
X-Received: by 2002:a63:ae48:: with SMTP id e8mr8698938pgp.347.1642178378678;
        Fri, 14 Jan 2022 08:39:38 -0800 (PST)
Received: from google.com ([2620:15c:211:201:a5b:82ad:7990:3ae0])
        by smtp.gmail.com with ESMTPSA id y13sm5032328pgi.53.2022.01.14.08.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 08:39:38 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 14 Jan 2022 08:39:36 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>, huww98@outlook.com,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC v2] mm: introduce page pin owner
Message-ID: <YeGnSG3BS5np9mUa@google.com>
References: <20211228175904.3739751-1-minchan@kernel.org>
 <cf596fdc-6599-7c53-26e8-1524c5f214f7@redhat.com>
 <Yd8AYViR6vuBVU2L@google.com>
 <c9c97e6a-5bb6-475e-2d0e-d791f11d2cf9@redhat.com>
 <Yd884YERYI+UvXbj@google.com>
 <35d7f27c-44e3-3921-c8d3-b6dee3b01238@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35d7f27c-44e3-3921-c8d3-b6dee3b01238@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 02:31:43PM +0100, David Hildenbrand wrote:
> On 12.01.22 21:41, Minchan Kim wrote:
> > On Wed, Jan 12, 2022 at 06:42:21PM +0100, David Hildenbrand wrote:
> >>>>
> >>>> What about something like:
> >>>>
> >>>> "mm: selective tracing of page reference holders on unref"
> >>>>
> >>>> PAGE_EXT_PIN_OWNER -> PAGE_EXT_TRACE_UNREF
> >>>>
> >>>> $whatever feature/user can then set the bit, for example, when migration
> >>>> fails.
> >>>
> >>> I couldn't imagine put_page tracking is generally useful except
> >>> migration failure. Do you have reasonable usecase in your mind
> >>> to make the feature general to be used?
> >>
> >> HWpoison etc. purposes maybe? Trace who still held a reference a page
> >> that was poisoned and couldn't be removed?  Or in general, tracking
> > 
> > I am not familiar with hwpoison so here dumb question goes:
> > Is that different one with __soft_offline_page?
> > It uses migrate_pages so current interface supports it with filter.
> 
> __soft_offline_page() won't kill the target and try to migrate because
> the pages are about to be damaged and we can still access them.
> 
> ordinary memory errors mean we kill the target because we cannot access
> the page anymore without triggering MCEs (or worse IIUC) again.
> 
> So in my thinking, after memory_failure(), it could eventually be
> helpful to figure out who still has a (temporary) reference to such a
> broken page, even after killing the process. But that's just one idea I
> quickly came up with.


Thanks for the clarification. Is the trace best fit in the case?
Presumably you know the broken page, can't you find who owns the page
using /proc/pid/pagemap?
Furthermore, page_get/put operations commonly could happen in
different contexts regardless of page's owner so the trace from
different context is still helpful?

If it's helpful, could you tell what you want to make the interface to
set the bit of broken page? For example, as-is case for page migration,
report_page_pinners is called to mark failed page at unmap_and_move.
Do you want to add something similar(maybe, set_page_ref_track under
rename) in memory-failure.c?

It would be very helpful to design the feature's interface(surely,
naming as well) and write description to convince others "yeah,
sounds like so useful for the case and that's best fit than other way".

> 
> > 
> > echo "memory_failure" > $trace_dir/events/page_pin_owner/report_page_pinners/filter
> > 
> >> references to something that should have a refcount of 0 because it
> >> should have been freed, but for some reason there are still references
> >> around?
> > 
> > Sounds like you are talking about memory leak? What's the purpose
> > with trace, not using other existing tool to find memory leak?
> > 
> 
> IIRC, kmemleak can find objects that are no longer referenced, and we
> cannot track buddy allocations, but only kmalloc and friends.

PageOwner is your good buddy.

> 
> >>
> >>> Otherwise, I'd like to have feature naming more higher level
> >>> to represent page migration failure and then tracking unref of
> >>> the page. In the sense, PagePinOwner John suggested was good
> >>> candidate(Even, my original naming PagePinner was worse) since
> >>
> >> Personally, I dislike both variants.
> >>
> >>> I was trouble to abstract the feature with short word.
> >>> If we approach "what feature is doing" rather than "what's
> >>> the feature's goal"(I feel the your suggestion would be close
> >>> to what feature is doing), I'd like to express "unreference on
> >>> migraiton failed page" so PAGE_EXT_UNMIGRATED_UNREF
> >>> (However, I prefer the feature naming more "what we want to achieve")
> >>>
> >> E.g., PAGE_EXT_TRACE_UNREF will trace unref to the page once the bit is
> >> set. The functionality itself is completely independent of migration
> >> failures. That's just the code that sets it to enable the underlying
> >> tracing for that specific page.
> > 
> > I agree that make something general is great but I also want to avoid
> > create something too big from the beginning with just imagination.
> > So, I'd like to hear more concrete and appealing usecases and then
> > we could think over this trace approach is really the best one to
> > achieve the goal. Once it's agreed, the naming you suggested would
> > make sense. 
> 
> At least for me it's a lot cleaner if a feature clearly expresses what
> it actually does. Staring at PAGE_EXT_PIN_OWNER I initially had no clue.
> I was assuming we would actually track (not trace!) all active FOLL_PIN
> (not unref callers!). Maybe that makes it clearer why I'd prefer a
> clearer name.

I totally agree PagePinOwner is not 100% straightforward. I'm open for
other better name. Currently we are discussing how we could generalize
and whether it's useful or not. Depending on the discussion, the design/
interface as well as naming could be changed. No problem.

> 
> >>
> >> Makes sense, I was expecting the output to be large, but possible it's
> >> going to be way too large.
> >>
> >> Would it also make sense to track for a flagged page new taken
> >> references, such that you can differentiate between new (e.g.,
> >> temporary) ones and previous ones? Feels like a reasonable addition.
> > 
> > I actually tried it and it showed 2x times bigger output.
> 
> Is 2x that bad? Or would it be worth making it configurable?

For my goal, 2x was bad because I need to minimize the trace buffer.
Furthermore, the new get operation was not helpful but just noisy.
If some usecase is not enough with only put callsite, we add get
easily. Implementation is not hard. The matter is how it's useful
in real practice since we would expose the interface to the user,
I guess.

> 
> > For me to debug CMA alloation failure, the new get_page callstack
> > after migration failure were waste since they repeated from lru
> > adding, isolate from the LRU something. Rather than get callsite,
> > I needed only put call sites since I could deduce where the pair-get
> > came from.
> 
> Could maybe some filters help that exclude such LRU activity?

For my case, the filter wouldn't be helpful because I shouldn't
miss the LRU activity since sometime they makes the allocation
failure. Thus, I could deduce the lru's get site from put callback.
get callsite is not helpful for my case but just wasted memory
and perf.
