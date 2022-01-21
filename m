Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A99495E80
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 12:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380195AbiAULle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 06:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350181AbiAULla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 06:41:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94658C061574;
        Fri, 21 Jan 2022 03:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xWZDmg9dD+bIX1jVVA1AvE8Malvggiw/J3x4iYuMuz0=; b=HsAX+SqW2L76NBQvWu1PrqWimf
        lTviSMT5+R6d+xAfx10tH3WdylZdHX7ZkzpwAifrznjJgJpkGCBEQ8HfUZe2IuVyU0IoEzWnlJNSd
        Rjwsq3ujrhV650oRKW7DNK1Ze9woD5gBYFVZTHkH8wgB6aeVD9/kLlKAAXa1zm7dZDeyJg4VkITVk
        pzUXwU+8lLpJwkwrvHoXl6rMj4zlKsJsuYAW5r2d149PJW5qyFTlIshhjzzXgSKoeWvkXl1v8wtZl
        tOMtFLtlm9gywyy1pnJ9jw72BWJEiF72kwEuyPUfvpDxXELDLx8C+0uWwRV/fhfh2Szv954w6P6DC
        7zOF4wTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAsHt-00FYqS-Sx; Fri, 21 Jan 2022 11:41:02 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C4D369853F1; Fri, 21 Jan 2022 12:40:58 +0100 (CET)
Date:   Fri, 21 Jan 2022 12:40:58 +0100
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
Message-ID: <20220121114058.GE20638@worktop.programming.kicks-ass.net>
References: <20220120155517.066795336@infradead.org>
 <20220120160822.666778608@infradead.org>
 <ffb88819-a392-84f3-d40f-7406be8e3165@redhat.com>
 <20220121075157.GA20638@worktop.programming.kicks-ass.net>
 <20220121085917.GA22849@worktop.programming.kicks-ass.net>
 <10d6cc13-b96b-e1b6-8751-1b245b242738@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10d6cc13-b96b-e1b6-8751-1b245b242738@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 10:04:45AM +0100, David Hildenbrand wrote:
> On 21.01.22 09:59, Peter Zijlstra wrote:

> > However, I'm not quite sure what fork() does with pages that have a pin.
> 
> We COW the anon pages always, and we protect against concurrent GUP
> using the
> * mmap_lock in exclusive mode for ordinary GUP
> * mm->write_protect_seq for GUP-fast

Right, but neither the mmap_sem nor the write_protect_seq help anything
at all vs already extant page pins.

But I just found copy_present_page()'s page_needs_cow_for_dma(), which I
think deals with exactly that case, it avoids doing CoW on pinned pages
and instead feeds the child a full copy while keeping the pinned page in
the original process.

> > Naively, a page that has async DMA activity should not be CoW'ed, or if
> > it is, care must be taken to ensure the original pages stays in the
> > original process, but I realize that's somewhat hard.
> 
> That's precisely what I'm working on fixing ... and yes, it's hard.
> 
> Let me know if you need any other information, I've spent way too much
> time on this than I ever panned.

So let me try and get this right:

 - GUP post-fork breaks CoW for FOLL_WRITE/FOLL_PIN, without either
   there's a problem where one task might observe changes by another.

 - GUP pre-fork prevents CoW and does a full copy.

And that all mostly works, except for a fair amount of 'fun' cases?

