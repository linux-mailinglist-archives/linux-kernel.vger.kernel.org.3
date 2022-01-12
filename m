Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10F448C831
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355176AbiALQXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343583AbiALQXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:23:01 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5385C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 08:23:00 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id w7so4676703plp.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 08:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I0AqeS6BA3pCC8i1HAk3s92KqvM91Rqh0lsE3L78uKo=;
        b=gm4xXWIbL+cDI5UJ0hlkwBYXUPbZsc1AghUEf7KbVXdePqYx7BBeYZPLqgFfeBIFf0
         658REpLSjaUQM/SuyQKnR70LAW8sYVPOxHRWA6HL92HjN5zk+dnA7PUChYqAfdj6s8sp
         xl/kiCnaxxCdIa3dZ9uJC9UsUBkbqRxv1kXI5zo3AUak/VshzZlazU8f85zfOho759mV
         sUZ0C0Rdbc2wP5Umg90jnd2984TMQVbw3wr1nXO8iqF1QayP0/ojH6MesrPV8rQXq0Qr
         +ICTRKKXmCwqx5NRMNe1WwEPhqfcXImm7B1UEN/oaUbMNJBvIVNQr61pZgd6MgiRUPU1
         Fb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=I0AqeS6BA3pCC8i1HAk3s92KqvM91Rqh0lsE3L78uKo=;
        b=tNZF7HWkwj3W7IEL+jqfivRAKYCTD6+0sXnq7fCnXFYr3DfN0dSHp0dASYr4BsD9r7
         eyGOwvEmIhifWagCQTvyrkhYCpVarMxZbbbbf75F9sm+E9ZcgA1evMJRST9+yhwa4LK7
         uK6V3AfcCMX+SY8ILc5BTmuVgC4UaaxECo+LfWTXEcfymGq7G/H39oKrY2lBAfZ105Zw
         j6Qo4+fjRMRHbf741LUGdVXPusLirsaXLlDi/HqXj93T+5CUT1Qt7MpMVI9YovylyKG6
         3aGEWB0JtEzLx8FPxeddgRQ/8JuhWXx/y00Ps7AI5AW36sbO2tl36YbOjvvgG/4hRV34
         4m+w==
X-Gm-Message-State: AOAM533ms0vNmghzxF2w8zf9vPadu0dpXOlmWjzlBOdsj+OjiwFXUCRp
        hEcM5zFOyXyjdT7ld2CY0Qw=
X-Google-Smtp-Source: ABdhPJxspsQsUfyfHSgHp0ltYeX16vTV8UqzZ+Xs+PYxC+gbBp6mW9CgWOZInRdKjGKZhezt/PgVmQ==
X-Received: by 2002:a17:902:8201:b0:149:8dd5:f0ed with SMTP id x1-20020a170902820100b001498dd5f0edmr384279pln.31.1642004580258;
        Wed, 12 Jan 2022 08:23:00 -0800 (PST)
Received: from google.com ([2620:15c:211:201:b6c7:c163:623d:56bc])
        by smtp.gmail.com with ESMTPSA id z16sm172592pgi.89.2022.01.12.08.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 08:22:59 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 12 Jan 2022 08:22:57 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>, huww98@outlook.com,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC v2] mm: introduce page pin owner
Message-ID: <Yd8AYViR6vuBVU2L@google.com>
References: <20211228175904.3739751-1-minchan@kernel.org>
 <cf596fdc-6599-7c53-26e8-1524c5f214f7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf596fdc-6599-7c53-26e8-1524c5f214f7@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 01:25:04PM +0100, David Hildenbrand wrote:
> On 28.12.21 18:59, Minchan Kim wrote:
> > A Contiguous Memory Allocator(CMA) allocation can fail if any page
> > within the requested range has an elevated refcount(a pinned page).
> > 
> > Debugging such failures is difficult, because the struct pages only
> > show a combined refcount, and do not show the callstacks or
> > backtraces of the code that acquired each refcount. So the source
> > of the page pins remains a mystery, at the time of CMA failure.
> > 
> > In order to solve this without adding too much overhead, just do
> > nothing most of the time, which is pretty low overhead. However,
> > once a CMA failure occurs, then mark the page (this requires a
> > pointer's worth of space in struct page, but it uses page extensions
> > to get that), and start tracing the subsequent put_page() calls.
> > As the program finishes up, each page pin will be undone, and
> > traced with a backtrace. The programmer reads the trace output and
> > sees the list of all page pinning code paths.
> > 
> 
> It's worth noting that this is a pure debug feature, right?

Sure.

> 
> 
> I like the general approach, however, IMHO the current naming is a bit
> sub-optimal and misleading. All you're doing is flagging pages that
> should result in a tracepoint when unref'ed.
> 
> "page pinners" makes it somewhat sound like you're targeting FOLL_PIN,
> not simply any references.
> 
> "owner" is misleading IMHO as well.
> 
> 
> What about something like:
> 
> "mm: selective tracing of page reference holders on unref"
> 
> PAGE_EXT_PIN_OWNER -> PAGE_EXT_TRACE_UNREF
> 
> $whatever feature/user can then set the bit, for example, when migration
> fails.

I couldn't imagine put_page tracking is generally useful except
migration failure. Do you have reasonable usecase in your mind
to make the feature general to be used?
Otherwise, I'd like to have feature naming more higher level
to represent page migration failure and then tracking unref of
the page. In the sense, PagePinOwner John suggested was good
candidate(Even, my original naming PagePinner was worse) since
I was trouble to abstract the feature with short word.
If we approach "what feature is doing" rather than "what's
the feature's goal"(I feel the your suggestion would be close
to what feature is doing), I'd like to express "unreference on
migraiton failed page" so PAGE_EXT_UNMIGRATED_UNREF
(However, I prefer the feature naming more "what we want to achieve")

> 
> I somewhat dislike that it's implicitly activated by failed page
> migration. At least the current naming doesn't reflect that.
> 
> 
> > This will consume an additional 8 bytes per 4KB page, or an
> > additional 0.2% of RAM. In addition to the storage space, it will
> > have some performance cost, due to increasing the size of struct
> > page so that it is greater than the cacheline size (or multiples
> > thereof) of popular (x86, ...) CPUs.
> 
> I think I might be missing something. Aren't you simply reusing
> &page_ext->flags ? I mean, the "overhead" is just ordinary page_ext
> overhead ... and whee exactly are you changing "struct page" layout? Is
> this description outdated?

The feature enables page_ext which adds up 8 bytes per 4KB and on every
put operation, it need to access the additional flag on page_ext which
affects performance since page_put is the common operation.
Yeah, the struct size stuff in the wording is rather misleading.
Let me change the workding something like this:

 This will consume an additional 8 bytes per 4KB page, or an
 additional 0.2% of RAM. In addition to the storage space, it will
 have some performance cost, due to checking additional flag on
 every put_page opeartion.

> 
> > 
> > The idea can apply every user of migrate_pages as well as CMA to
> > know the reason why the page migration failed. To support it,
> > the implementation takes "enum migrate_reason" string as filter
> > of the tracepoint(see below).
> > 
> 
> I wonder if we could achieve the same thing for debugging by
> 
> a) Tracing the PFN when migration fails
> b) Tracing any unref of any PFN
> 
> User space can then combine both information to achieve the same result.
> I assume one would need a big trace buffer, but maybe for a debug
> feature good enough?

I definitely tried it for cma allocation failure but it generated
enormous output(Please keep it in mind that we also need stacktrace)
due to too frequent put_page and compaction operation(Even, I filter
them out to track only cma pages but it was still huge since the CMA
size is 1/8 of the system). Even though I increased the buffer size
a lot, the buffer was easily overwritten. Moreover, even though it's
debug feature, we need to release the feature into dogfooder to catch
the real problem in the field so consuming too much memory as well as
backtrace operhead on every put page are tough to be used in field.
