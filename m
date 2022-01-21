Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4904C495C71
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 09:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379624AbiAUI7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 03:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbiAUI7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:59:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D901C061574;
        Fri, 21 Jan 2022 00:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7wc2zUSfhyENFO6ymFjjrv1H+4Rj+PnhH77Hsl91gjc=; b=jrGOS1JRI2plfq4yl+kTVyT8QB
        lplUqiCN6OZhxp39ABXcb17U2+hx8Zi3Ii7dFt2lQV4Yi+H+jHOQjMkudyjhYmrnmhNmxV2EB8qIK
        Y7is+ME0ziH3XbydM6URLERYWx+utHOCGGx7fZm6czg8Ry+nqh5edj+D+gJTOaHi55kyzjU9AezKR
        y/elJtDK+t2+A6ZRbssaNwApsBzd9VDEWE8p2TB1MqNqiEy2TueB83hlPebuGPcpIFA11a4UcN84w
        WLbuYn0SFqOzDnWP9nAHyd261fwWH8WPAyNVBK27kmbzcAcPv5Fphr1F5PXpAdpJwakqPMD4CYclj
        53nSlfJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAplO-00FROw-8s; Fri, 21 Jan 2022 08:59:18 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0AB9A9853F1; Fri, 21 Jan 2022 09:59:17 +0100 (CET)
Date:   Fri, 21 Jan 2022 09:59:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca, mark.rutland@arm.com,
        posk@posk.io
Subject: Re: [RFC][PATCH v2 1/5] mm: Avoid unmapping pinned pages
Message-ID: <20220121085917.GA22849@worktop.programming.kicks-ass.net>
References: <20220120155517.066795336@infradead.org>
 <20220120160822.666778608@infradead.org>
 <ffb88819-a392-84f3-d40f-7406be8e3165@redhat.com>
 <20220121075157.GA20638@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121075157.GA20638@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 08:51:57AM +0100, Peter Zijlstra wrote:
> On Thu, Jan 20, 2022 at 07:25:08PM +0100, David Hildenbrand wrote:
> > On 20.01.22 16:55, Peter Zijlstra wrote:
> > > Add a guarantee for Anon pages that pin_user_page*() ensures the
> > > user-mapping of these pages stay preserved. In order to ensure this
> > > all rmap users have been audited:
> > > 
> > >  vmscan:	already fails eviction due to page_maybe_dma_pinned()
> > > 
> > >  migrate:	migration will fail on pinned pages due to
> > > 		expected_page_refs() not matching, however that is
> > > 		*after* try_to_migrate() has already destroyed the
> > > 		user mapping of these pages. Add an early exit for
> > > 		this case.
> > > 
> > >  numa-balance:	as per the above, pinned pages cannot be migrated,
> > > 		however numa balancing scanning will happily PROT_NONE
> > > 		them to get usage information on these pages. Avoid
> > > 		this for pinned pages.
> > 
> > page_maybe_dma_pinned() can race with GUP-fast without
> > mm->write_protect_seq. This is a real problem for vmscan() with
> > concurrent GUP-fast as it can result in R/O mappings of pinned pages and
> > GUP will lose synchronicity to the page table on write faults due to
> > wrong COW.
> 
> Urgh, so yeah, that might be a problem. Follow up code uses it like
> this:
> 
> +/*
> + * Pinning a page inhibits rmap based unmap for Anon pages. Doing a load
> + * through the user mapping ensures the user mapping exists.
> + */
> +#define umcg_pin_and_load(_self, _pagep, _member)                              \
> +({                                                                             \
> +       __label__ __out;                                                        \
> +       int __ret = -EFAULT;                                                    \
> +                                                                               \
> +       if (pin_user_pages_fast((unsigned long)(_self), 1, 0, &(_pagep)) != 1)  \
> +               goto __out;                                                     \
> +                                                                               \
> +       if (!PageAnon(_pagep) ||                                                \
> +           get_user(_member, &(_self)->_member)) {                             \
> +               unpin_user_page(_pagep);                                        \
> +               goto __out;                                                     \
> +       }                                                                       \
> +       __ret = 0;                                                              \
> +__out: __ret;                                                                  \
> +})
> 
> And after that hard assumes (on the penalty of SIGKILL) that direct user
> access works. Specifically it does RmW ops on it. So I suppose I'd
> better upgrade that load to a RmW at the very least.
> 
> But is that sufficient? Let me go find that race you mention...

OK, so copy_page_range() vs lockless_pages_from_mm(). Since I use
FOLL_PIN that should be sorted, it'll fall back the slow path and use
mmap_sem and serialize against the fork().

(Also, can I express my hate for __gup_longterm_unlocked(), that
function name is utter garbage)

However, I'm not quite sure what fork() does with pages that have a pin.
There's been a number of GUP vs fork() problems over the years, but I'm
afraid I have lost track of that and I can't quickly find anything in
the code..

Naively, a page that has async DMA activity should not be CoW'ed, or if
it is, care must be taken to ensure the original pages stays in the
original process, but I realize that's somewhat hard.

Let me dig in a bit more.
