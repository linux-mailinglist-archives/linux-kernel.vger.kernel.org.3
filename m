Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B4E46B92C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhLGKeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhLGKeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:34:12 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACB7C061746;
        Tue,  7 Dec 2021 02:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ub6iik2lU0lg+71v5tGKDkXADgSKb2Jmgh0OwCSCJ5c=; b=Xc7n+lEf635a/0yKfgNDoFWV+k
        gnnOHCSxbRQVDnSoj9HZKvM4Oq26pWhZKqGJYWTuQcAikzF9EUifIKnwMDV1wm2nM8jX0h153FhJS
        kdWgB49vSgcLE/+V4THl2rMnOCNIx5yTAnPkwD0wP8OrxiK/9vQZT4DYfpofegPibTpHxIDG2KAU1
        ygrHVE3GynewFSd/SN5byode5ZZfjBvl3vfxXoAjMes0VWJ8pfIZiL0b2E495XfA+qcoNlx7bD84i
        d4W6z8oHoVOiMDPQLbODOi9Xpm+8xqmwspquQWf1TfMPN1VA3n4oRbjAiHtnd+WE5RFL5j3Mib2Us
        EDqIBaMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muXk6-002kJj-2z; Tue, 07 Dec 2021 10:30:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B2F9230002F;
        Tue,  7 Dec 2021 11:30:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9EF1B202A40B1; Tue,  7 Dec 2021 11:30:37 +0100 (CET)
Date:   Tue, 7 Dec 2021 11:30:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: switch to atomic_t for request references
Message-ID: <Ya83zQRVUCRRYNHQ@hirez.programming.kicks-ass.net>
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org>
 <Ya3KZiLg5lYjsGcQ@hirez.programming.kicks-ass.net>
 <CAHk-=wjXmGt9-JQp-wvup4y2tFNUCVjvx2W7MHzuAaxpryP4mg@mail.gmail.com>
 <282666e2-93d4-0302-b2d0-47d03395a6d4@kernel.dk>
 <202112061247.C5CD07E3C@keescook>
 <CAHk-=wh0RhnMfZG6xQJ=yHTgmPTaxjQOo1Q2=r+_ZR56yiRi4A@mail.gmail.com>
 <202112061455.F23512C3CB@keescook>
 <CAHk-=whLU+dk7EmPu5UC6DDSd76_dO4bVd4BkvxmR4W5-mmAgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whLU+dk7EmPu5UC6DDSd76_dO4bVd4BkvxmR4W5-mmAgg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 04:13:00PM -0800, Linus Torvalds wrote:

> IOW, I think that "try_get_page()" function is basically the *much*
> superior version of what is currently a broken "refcount_inc()".
> 
> And yes, it does warn about that overflow case that you claim only
> refcount_t does. And does so without the broken semantics that
> refcount h as.

That places the burden of the unlikely overflow case on the user. Now
every driver author needs to consider the overflow case and have a
corresponding error path. How many bugs will that introduce?

Why is saturation; iow. leaking the memory, a worse option than having
bad/broken/never-tested error paths all over the kernel?

