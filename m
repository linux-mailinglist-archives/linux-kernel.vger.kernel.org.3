Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A32148CD2D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 21:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357696AbiALUlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 15:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357682AbiALUlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 15:41:09 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A87C061751
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 12:41:08 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id p14so5991015plf.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 12:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yw5pOG+8EF6dNFjVo0umaJQRgBhhV+jKo/RFqA+BDRQ=;
        b=ADTpEsXWEei+8iad7W7IC4k1Ri30WifPSOBeSIdU2MRdcvMgKVe91BluRfdWSZdAbN
         OGB+fwu3Hc8d4pRWiSVDaSqeuUzciUIodwVrDu50noVKq290lmlqAof6EsCfSXuJOFA0
         U8UsUjJi/e77brE7pzrx1Bt9xrW1EbvYB/NiH3cTqarFCSRJ/HNcuQdx3g8lOZZTEZvD
         t4U2rghSDx3U6U8+C8Samxw2BvUANRLGfQJ2XLMpsnjUTcUWBUJ5zDeogKnY0WrqGdYJ
         k1AcsH5J3S3prOry+WtC5TRzNDD0NGF4qrAA5WZGyZMCa3YS0slRlPlSEunJcUrgqbIL
         ph6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=yw5pOG+8EF6dNFjVo0umaJQRgBhhV+jKo/RFqA+BDRQ=;
        b=KtJn3LWRsyfEQ4M83MmSWdD7eY3zPW9GvN6h9MfQnSOUDv9OqHJtS7ftnZ8xjQktyB
         GB2ViL6cN6d/FWFMZPGGhm6U3uecHbucPTx+4G/TPub+z6wijWIQLBHgF5cqVWtElE1m
         8w16dQE8O4hFGONFtFRS2rGLMhKrR1CylG9Y1wOJTUzzuYviZCDiuQIOjKSsL1+wrjt5
         ajsbrS6K94OKMAB0q+2u8p1B1QYobGAd51v83jWVMOfih3tgon/zyBkDtkkLGzu8rzWH
         C4B/iDUT8TAtEfJgUWpoAjkOVcUHQc2VLs8XsAvw3DZgdRF90X7OYlRq/dk2CF9jv7+o
         Ma7g==
X-Gm-Message-State: AOAM533T+NUWi0rmJYHXvLnPf6kugRu4hDP3ZZQgsyzTR8R9r4Yuq3m5
        kjm94uvENwJt+udXYIzbTKM=
X-Google-Smtp-Source: ABdhPJyGjGP0AEPX6zhDmLCbOIauT7pTOFdHB4rayIkA3lGU1KREdgFdhMXsdQSoJxPThoAQGxkwBg==
X-Received: by 2002:a63:b57:: with SMTP id a23mr591594pgl.443.1642020068127;
        Wed, 12 Jan 2022 12:41:08 -0800 (PST)
Received: from google.com ([2620:15c:211:201:b6c7:c163:623d:56bc])
        by smtp.gmail.com with ESMTPSA id x25sm447462pfu.113.2022.01.12.12.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 12:41:07 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 12 Jan 2022 12:41:05 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>, huww98@outlook.com,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC v2] mm: introduce page pin owner
Message-ID: <Yd884YERYI+UvXbj@google.com>
References: <20211228175904.3739751-1-minchan@kernel.org>
 <cf596fdc-6599-7c53-26e8-1524c5f214f7@redhat.com>
 <Yd8AYViR6vuBVU2L@google.com>
 <c9c97e6a-5bb6-475e-2d0e-d791f11d2cf9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9c97e6a-5bb6-475e-2d0e-d791f11d2cf9@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 06:42:21PM +0100, David Hildenbrand wrote:
> >>
> >> What about something like:
> >>
> >> "mm: selective tracing of page reference holders on unref"
> >>
> >> PAGE_EXT_PIN_OWNER -> PAGE_EXT_TRACE_UNREF
> >>
> >> $whatever feature/user can then set the bit, for example, when migration
> >> fails.
> > 
> > I couldn't imagine put_page tracking is generally useful except
> > migration failure. Do you have reasonable usecase in your mind
> > to make the feature general to be used?
> 
> HWpoison etc. purposes maybe? Trace who still held a reference a page
> that was poisoned and couldn't be removed?  Or in general, tracking

I am not familiar with hwpoison so here dumb question goes:
Is that different one with __soft_offline_page?
It uses migrate_pages so current interface supports it with filter.

echo "memory_failure" > $trace_dir/events/page_pin_owner/report_page_pinners/filter

> references to something that should have a refcount of 0 because it
> should have been freed, but for some reason there are still references
> around?

Sounds like you are talking about memory leak? What's the purpose
with trace, not using other existing tool to find memory leak?

> 
> > Otherwise, I'd like to have feature naming more higher level
> > to represent page migration failure and then tracking unref of
> > the page. In the sense, PagePinOwner John suggested was good
> > candidate(Even, my original naming PagePinner was worse) since
> 
> Personally, I dislike both variants.
> 
> > I was trouble to abstract the feature with short word.
> > If we approach "what feature is doing" rather than "what's
> > the feature's goal"(I feel the your suggestion would be close
> > to what feature is doing), I'd like to express "unreference on
> > migraiton failed page" so PAGE_EXT_UNMIGRATED_UNREF
> > (However, I prefer the feature naming more "what we want to achieve")
> > 
> E.g., PAGE_EXT_TRACE_UNREF will trace unref to the page once the bit is
> set. The functionality itself is completely independent of migration
> failures. That's just the code that sets it to enable the underlying
> tracing for that specific page.

I agree that make something general is great but I also want to avoid
create something too big from the beginning with just imagination.
So, I'd like to hear more concrete and appealing usecases and then
we could think over this trace approach is really the best one to
achieve the goal. Once it's agreed, the naming you suggested would
make sense. 

> 
> >>
> >> I somewhat dislike that it's implicitly activated by failed page
> >> migration. At least the current naming doesn't reflect that.
> >>
> >>
> >>> This will consume an additional 8 bytes per 4KB page, or an
> >>> additional 0.2% of RAM. In addition to the storage space, it will
> >>> have some performance cost, due to increasing the size of struct
> >>> page so that it is greater than the cacheline size (or multiples
> >>> thereof) of popular (x86, ...) CPUs.
> >>
> >> I think I might be missing something. Aren't you simply reusing
> >> &page_ext->flags ? I mean, the "overhead" is just ordinary page_ext
> >> overhead ... and whee exactly are you changing "struct page" layout? Is
> >> this description outdated?
> > 
> > The feature enables page_ext which adds up 8 bytes per 4KB and on every
> > put operation, it need to access the additional flag on page_ext which
> > affects performance since page_put is the common operation.
> > Yeah, the struct size stuff in the wording is rather misleading.
> > Let me change the workding something like this:
> > 
> >  This will consume an additional 8 bytes per 4KB page, or an
> >  additional 0.2% of RAM. In addition to the storage space, it will
> >  have some performance cost, due to checking additional flag on
> >  every put_page opeartion.
> 
> I'd adjust to
> 
> As this feature depends on page_ext->flags, it will consume an
> additional 8 bytes per 4KB page to enable page_ext if not already
> enabled. ...

NP.

> 
> > 
> >>
> >>>
> >>> The idea can apply every user of migrate_pages as well as CMA to
> >>> know the reason why the page migration failed. To support it,
> >>> the implementation takes "enum migrate_reason" string as filter
> >>> of the tracepoint(see below).
> >>>
> >>
> >> I wonder if we could achieve the same thing for debugging by
> >>
> >> a) Tracing the PFN when migration fails
> >> b) Tracing any unref of any PFN
> >>
> >> User space can then combine both information to achieve the same result.
> >> I assume one would need a big trace buffer, but maybe for a debug
> >> feature good enough?
> > 
> > I definitely tried it for cma allocation failure but it generated
> > enormous output(Please keep it in mind that we also need stacktrace)
> > due to too frequent put_page and compaction operation(Even, I filter
> > them out to track only cma pages but it was still huge since the CMA
> > size is 1/8 of the system). Even though I increased the buffer size
> > a lot, the buffer was easily overwritten. Moreover, even though it's
> > debug feature, we need to release the feature into dogfooder to catch
> > the real problem in the field so consuming too much memory as well as
> > backtrace operhead on every put page are tough to be used in field.
> 
> Makes sense, I was expecting the output to be large, but possible it's
> going to be way too large.
> 
> Would it also make sense to track for a flagged page new taken
> references, such that you can differentiate between new (e.g.,
> temporary) ones and previous ones? Feels like a reasonable addition.

I actually tried it and it showed 2x times bigger output.
For me to debug CMA alloation failure, the new get_page callstack
after migration failure were waste since they repeated from lru
adding, isolate from the LRU something. Rather than get callsite,
I needed only put call sites since I could deduce where the pair-get
came from.
