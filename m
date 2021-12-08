Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B462946DD53
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235570AbhLHVAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 16:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbhLHVAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 16:00:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8741BC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 12:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lmN1YK0yHRLzAidSuhsscvLMED/SEk/FH/tu9VZoW2A=; b=OGiIAhOQEJLWwjZtBIZx0BBQPe
        jiDdwedIuLbDYQa7G15wHQRTWYgFl7oVJNxnkpQ1GKvE1yQxo7EBn5YLIbV89tSnL7yijxcB3najG
        6mwWDAa7bi+R0SEkmLOtV9Fluj9PPSRTnglRQ14OkcLHc1mafj6BRf0TBdsrJS3sZLyn2g2cPcgna
        imqxKKxpAQOMyEK0IDY6X3RyUK60uDhBK2FbX6VlXGY4u/M3/4j1j9X7vgpde3A81IcARC4XLwXtc
        zLHhpZoz7YfDwpNXPfsYJkleDAWkvKNVHPwRuyL+dA0feTH6VgCAZEwPPHUAsPiywnUndhVzfObRt
        wBD16V0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mv3zZ-008lhZ-CN; Wed, 08 Dec 2021 20:56:46 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0FAB29811F7; Wed,  8 Dec 2021 21:56:47 +0100 (CET)
Date:   Wed, 8 Dec 2021 21:56:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mark.rutland@arm.com,
        elver@google.com, keescook@chromium.org, hch@infradead.org,
        torvalds@linux-foundation.org
Subject: Re: [RFC][PATCH 2/5] refcount: Use atomic_*_ofl()
Message-ID: <20211208205646.GB16608@worktop.programming.kicks-ass.net>
References: <20211208183655.251963904@infradead.org>
 <20211208183906.468934357@infradead.org>
 <YbEFR9LVCkf0GQ0s@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbEFR9LVCkf0GQ0s@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 08:19:35PM +0100, Peter Zijlstra wrote:
> On Wed, Dec 08, 2021 at 07:36:57PM +0100, Peter Zijlstra wrote:
> > Use the shiny new atomic_*_ofl() functions in order to have better
> > code-gen.
> > 
> 
> *sigh*, so I forgot to adjust the other primitives to the slightly
> tweaked range of these new functions..

Looks like it all just works. The add/sub stuff needs to check before
and after anyway, and it saturing slightly earlier isn't a problem.

The only difference I found was, so I'll just fold that.

--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -346,7 +346,7 @@ static inline void __refcount_dec(refcou
 	if (oldp)
 		*oldp = old;
 
-	if (unlikely(old <= 1))
+	if (unlikely(old - 1 <= 0))
 		refcount_warn_saturate(r, REFCOUNT_DEC_LEAK);
 }
 

