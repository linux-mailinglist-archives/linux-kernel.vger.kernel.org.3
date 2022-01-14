Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEFF48F02E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 19:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243457AbiANSzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 13:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbiANSzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 13:55:05 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DB4C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 10:55:05 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id e19so13807838plc.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 10:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WFVL7xC5RocH32mh42Se7hdaSVxjx0swhsBWYk7XV60=;
        b=juogtjmjMLFeUAGQeHvWRi96xw5NLvISVFtuTg21cnCxa/IZkg7N0IY3uADcHCjNPo
         GLAL4UuZSC4Be5vvxfucF9SvKKfxYzomeH+bhCekZ+t6Sl704zBQct0CIQJYqeGF/Z30
         t3X8i+/jcyumCSES6+rvARUtIg/nvLurUQEuaiq5SYLYkMOSkfgATxGfNt6fyy81DasO
         Eouj3isxjpomVHR0J8lTvN8pVSux9/xTXkFpcF074Q1yQXBqyFLPpHkKZCDm1LzHgqlL
         A51gBT0e1ikX564GypaYlqbHcUg3r8RPZkKMZ2Iqp00g2/4gMlWHFb5rdnDo6ZHWMuYt
         XOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=WFVL7xC5RocH32mh42Se7hdaSVxjx0swhsBWYk7XV60=;
        b=65rW10rPMZlJBsuGbo3cIygNdbEduF+ThilVuFWQKGN8RVaGMsPOszT+c6ynQsV+OG
         bI8cQQwauJO+bkwLjIj9b0Xe0k3HFtVYvW0BNwkCC1/ey5LYVFZWZC9sF25XCFE4Fixz
         IT42KSKu5nJ0Sne2CcpmuXSJkBENFnW1qkJ32/VtKQO/N8gexZ3xRpiSj+f1i8EQtJNt
         cnXY0kO7SpefSaekVuUkJoSy/CCvJ7Q5oZET/aZlZMlOkVxsATWCAhXYmnqcqIuH139Y
         BaaokSG5EbY9K4P7UfGj+dl3HUkZXWUV+hj/KsZGPGA3k0V1tAV3ZpZT43iaIgsEl3o+
         ckgA==
X-Gm-Message-State: AOAM531Yek7dsSUjl9cDVhjjuepW3QAC3QzMW9FuV4E21kZOvy/gn6uK
        bpMTcn8/3tpGgpzKtJR4A+s=
X-Google-Smtp-Source: ABdhPJwhMLpvDa8KE+HVlPuofd3Lgp7ZDNhDXZCIfrCa4ncnstxu63kPbKOqIDwbiZ9BmOJFexKldA==
X-Received: by 2002:a17:902:e790:b0:149:7a3f:826a with SMTP id cp16-20020a170902e79000b001497a3f826amr11029270plb.76.1642186504549;
        Fri, 14 Jan 2022 10:55:04 -0800 (PST)
Received: from google.com ([2620:15c:211:201:a5b:82ad:7990:3ae0])
        by smtp.gmail.com with ESMTPSA id z3sm5683220pjq.32.2022.01.14.10.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 10:55:04 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 14 Jan 2022 10:55:02 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>, huww98@outlook.com,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC v2] mm: introduce page pin owner
Message-ID: <YeHHBhhaCf3g9QVe@google.com>
References: <20211228175904.3739751-1-minchan@kernel.org>
 <cf596fdc-6599-7c53-26e8-1524c5f214f7@redhat.com>
 <Yd8AYViR6vuBVU2L@google.com>
 <c9c97e6a-5bb6-475e-2d0e-d791f11d2cf9@redhat.com>
 <Yd884YERYI+UvXbj@google.com>
 <35d7f27c-44e3-3921-c8d3-b6dee3b01238@redhat.com>
 <YeGnSG3BS5np9mUa@google.com>
 <8f02e71b-5de7-4342-7371-a7fe19b114b5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f02e71b-5de7-4342-7371-a7fe19b114b5@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 05:51:24PM +0100, David Hildenbrand wrote:
> On 14.01.22 17:39, Minchan Kim wrote:
> > On Fri, Jan 14, 2022 at 02:31:43PM +0100, David Hildenbrand wrote:
> >> On 12.01.22 21:41, Minchan Kim wrote:
> >>> On Wed, Jan 12, 2022 at 06:42:21PM +0100, David Hildenbrand wrote:
> >>>>>>
> >>>>>> What about something like:
> >>>>>>
> >>>>>> "mm: selective tracing of page reference holders on unref"
> >>>>>>
> >>>>>> PAGE_EXT_PIN_OWNER -> PAGE_EXT_TRACE_UNREF
> >>>>>>
> >>>>>> $whatever feature/user can then set the bit, for example, when migration
> >>>>>> fails.
> >>>>>
> >>>>> I couldn't imagine put_page tracking is generally useful except
> >>>>> migration failure. Do you have reasonable usecase in your mind
> >>>>> to make the feature general to be used?
> >>>>
> >>>> HWpoison etc. purposes maybe? Trace who still held a reference a page
> >>>> that was poisoned and couldn't be removed?  Or in general, tracking
> >>>
> >>> I am not familiar with hwpoison so here dumb question goes:
> >>> Is that different one with __soft_offline_page?
> >>> It uses migrate_pages so current interface supports it with filter.
> >>
> >> __soft_offline_page() won't kill the target and try to migrate because
> >> the pages are about to be damaged and we can still access them.
> >>
> >> ordinary memory errors mean we kill the target because we cannot access
> >> the page anymore without triggering MCEs (or worse IIUC) again.
> >>
> >> So in my thinking, after memory_failure(), it could eventually be
> >> helpful to figure out who still has a (temporary) reference to such a
> >> broken page, even after killing the process. But that's just one idea I
> >> quickly came up with.
> > 
> > 
> > Thanks for the clarification. Is the trace best fit in the case?
> > Presumably you know the broken page, can't you find who owns the page
> > using /proc/pid/pagemap?
> > Furthermore, page_get/put operations commonly could happen in
> > different contexts regardless of page's owner so the trace from
> > different context is still helpful?
> > 
> > If it's helpful, could you tell what you want to make the interface to
> > set the bit of broken page? For example, as-is case for page migration,
> > report_page_pinners is called to mark failed page at unmap_and_move.
> > Do you want to add something similar(maybe, set_page_ref_track under
> > rename) in memory-failure.c?
> > 
> > It would be very helpful to design the feature's interface(surely,
> > naming as well) and write description to convince others "yeah,
> > sounds like so useful for the case and that's best fit than other way".
> 
> I currently don't have time to explore this further, it was just a
> random thought how else this might be useful.

Thanks for the input. The concrete usecase/idea are really important
to define what information the trace will dump as well as defining
interface.

Please consider the current dump content are also good to cover
what you are thinking for potential cases. And potentially, someone
want to see different data for their failure and put event for
their taste. It means we need to tell why the page was marked to
be tracked originally in the put_page, such as, cma, or hwpoison
or something else so we need per-page metadata to distinguish
them. It makes me think over strong justfication even though
page_ext would be a little more tolerable than struct page.

> 
> 
> >>
> >>>
> >>> echo "memory_failure" > $trace_dir/events/page_pin_owner/report_page_pinners/filter
> >>>
> >>>> references to something that should have a refcount of 0 because it
> >>>> should have been freed, but for some reason there are still references
> >>>> around?
> >>>
> >>> Sounds like you are talking about memory leak? What's the purpose
> >>> with trace, not using other existing tool to find memory leak?
> >>>
> >>
> >> IIRC, kmemleak can find objects that are no longer referenced, and we
> >> cannot track buddy allocations, but only kmalloc and friends.
> > 
> > PageOwner is your good buddy.
> 
> Page owner tracks who owns a page but not who else holds a reference
> (some buffer, gup, whatsoever), right?

I thought you wanted to use the feature for memory leak since you
mentioned kmemleak. I don't understand fully what you want but
how could you get the trace if the reference holder never release?
Only way to get to the goal is you need to trace all the get trace
before the event happen and then correlate them with put. However,
the get happened long time ago, you need to assign huge amount of
RAM to keep the record. Without compelling usecase, I am not convinced.

> 
> > 
> >>
> >>>>
> >>>>> Otherwise, I'd like to have feature naming more higher level
> >>>>> to represent page migration failure and then tracking unref of
> >>>>> the page. In the sense, PagePinOwner John suggested was good
> >>>>> candidate(Even, my original naming PagePinner was worse) since
> >>>>
> >>>> Personally, I dislike both variants.
> >>>>
> >>>>> I was trouble to abstract the feature with short word.
> >>>>> If we approach "what feature is doing" rather than "what's
> >>>>> the feature's goal"(I feel the your suggestion would be close
> >>>>> to what feature is doing), I'd like to express "unreference on
> >>>>> migraiton failed page" so PAGE_EXT_UNMIGRATED_UNREF
> >>>>> (However, I prefer the feature naming more "what we want to achieve")
> >>>>>
> >>>> E.g., PAGE_EXT_TRACE_UNREF will trace unref to the page once the bit is
> >>>> set. The functionality itself is completely independent of migration
> >>>> failures. That's just the code that sets it to enable the underlying
> >>>> tracing for that specific page.
> >>>
> >>> I agree that make something general is great but I also want to avoid
> >>> create something too big from the beginning with just imagination.
> >>> So, I'd like to hear more concrete and appealing usecases and then
> >>> we could think over this trace approach is really the best one to
> >>> achieve the goal. Once it's agreed, the naming you suggested would
> >>> make sense. 
> >>
> >> At least for me it's a lot cleaner if a feature clearly expresses what
> >> it actually does. Staring at PAGE_EXT_PIN_OWNER I initially had no clue.
> >> I was assuming we would actually track (not trace!) all active FOLL_PIN
> >> (not unref callers!). Maybe that makes it clearer why I'd prefer a
> >> clearer name.
> > 
> > I totally agree PagePinOwner is not 100% straightforward. I'm open for
> > other better name. Currently we are discussing how we could generalize
> > and whether it's useful or not. Depending on the discussion, the design/
> > interface as well as naming could be changed. No problem.
> 
> PagePinOwner is just highly misleading. Because that's not what the
> feature does. Having that said, i hope we'll get other opinions as well.

Yeah, I'm open for the better name. Still thinking but I was not good.
