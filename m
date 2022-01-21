Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA524495FB1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 14:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347903AbiAUNUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 08:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380585AbiAUNUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 08:20:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AC4C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 05:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CDfqQpaNyR1slLKbCMM+fTwMTmvDRMkpoYbrFNKkvZY=; b=oPL9RCoC3bmiGjc9zs/xXLLu6t
        RrU5fSaK51OMQoFsmDq/6gdkjgbIfp1JZ1TfjII7ODpxtj1dJDSqZ9IhMLBePZai0otqc2gSTt6rI
        PQwWuKHlFEA1dX7PDZEFb5Ao0vcuGrxWYyZE95DPbV3+QRI+oziOAgp35cj8K2n/W+Rydl7LLfVmE
        fHXc4xNUrpD0H9fGn9GlWe+/oPCE48FweJaVkdH4AJdPyQLKIJ1UztOBqs8nTlV7pOva3tmxcLxc6
        gT69vBqwtS66Qm+voYQzTJbhi+tHlPsvo6/8V/ckG+RJuM6xMkwhbLalRTDBwqm0rn+q8gtEK7hiW
        AECR4Zhg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAtpL-00Fcbj-Fu; Fri, 21 Jan 2022 13:19:39 +0000
Date:   Fri, 21 Jan 2022 13:19:39 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Alex Shi <seakeel@gmail.com>
Cc:     Alex Shi <alexs@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Yu Zhao <yuzhao@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/5] mm: remove page_is_file_lru function
Message-ID: <Yeqy69KK31PSmZdi@casper.infradead.org>
References: <20220120131024.502877-1-alexs@kernel.org>
 <20220120131024.502877-2-alexs@kernel.org>
 <YeljTuECoPfKn6VW@casper.infradead.org>
 <CAJy-AmnmRVZ2ezSt1bws4TVKEw-VKubUXbc4SP8wU0-SQprhcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJy-AmnmRVZ2ezSt1bws4TVKEw-VKubUXbc4SP8wU0-SQprhcA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 03:02:12PM +0800, Alex Shi wrote:
> On Thu, Jan 20, 2022 at 9:28 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Jan 20, 2022 at 09:10:20PM +0800, alexs@kernel.org wrote:
> > > From: Alex Shi <alexs@kernel.org>
> > >
> > > This function could be full replaced by folio_is_file_lru, so no reason
> > > to keep a duplicate function.
> >
> > This is not a helpful way to do this kind of replacement.
> >
> > Instead of choosing a function to remove and doing a blind replacement,
> > choose a call site and convert the whole calling function to use folios.
> > Once you've removed all callers, you can remove the wrapper function.
> >
> > Also, a number of changes here will conflict with patches I've already
> > posted.  Try doing change_pte_range() in mprotect.c to get a feel for
> > how to convert a function entirely to folios.
> 
> Hi Willy,
> 
> Thanks for your comments!
> 
> The patchset did the thing as you required "convert the whole calling
> function to use folios. then remove the wrapper function" on yesterday's
> Linus and next tree, that included your patchset "Page cache/iomap for 5.17".

That's not what I meant.  What I meant is you're currently doing:

 - Find folio wrapper function
 - Inline it into all callers
 - Delete wrapper function

That creates a lot of churn and not a lot of improvement.

What would be helpful is doing:

 - Find folio wrapper function
 - Find a caller, convert it from using pages to using folios

That's harder, but it actually accomplishes something (ie auditing
a function to make it work with folios).  These wrapper functions are
signals that the callers need to be converted to use folios.

> Is the conflicting patch "Enabling large folios for 5.17" or others? Sorry
> for can't check everyone, your patches are many. If just the former, I see
> you mentioned: "I'd be uncomfortable seeing it merged before 5.18".
> Would you point out which of your patches was interfered or blocked?

The GUP series was the specific series that this conflicted with.
And yes, I have a lot of patches outstanding in this area.  That's a
sign that small cleanup patches aren't going to be welcomed because
they're going to conflict with meaningful patches.

> And yes, replacing page functions in change_pte_range is a bit harder,
> but it seems it has no much relation with this trival patchset.

That is, indeed, the point.
