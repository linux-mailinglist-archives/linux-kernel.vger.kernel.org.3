Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E74746A29F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 18:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237357AbhLFRXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 12:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236862AbhLFRXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 12:23:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439A5C061746;
        Mon,  6 Dec 2021 09:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y2+LK337slwbMibrfKzeQe6vLD/fHL8se/F3eRlVIUY=; b=jg+q0dqRHwv2mAbPr4kkpD8yyq
        l+Pws/qrNO2O55Cz66hnH8YJOzYmahN8/4SA2umFaWM5Gb8FGHzM6I2rQCMH4Toa5AWzptBIQKoIO
        CnrifM5rZy2uHNO59rIsM5cgtRXd50JQ4ySvNt7hO3j1xR/sZRRHXGVQ2So3mBesjJ2pE9OzRHA/t
        LY/dTp6Hd6wkVPVr97E1SGcHHpHq1/mFBGGPEcgaTrTAYcO270AC0P7d5+VKpGWlWS3xIbUdzLDKb
        E97rp1cRTNXLqqsAKUQ8EBqrRvLyU8WBG4/7QTtp+15MyiJ7JbMd8gosqL5fn1tZKf9GtxkmQUgyR
        +g0YFtPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muHee-005TRZ-Ig; Mon, 06 Dec 2021 17:19:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3356B300252;
        Mon,  6 Dec 2021 18:19:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D99C2019F824; Mon,  6 Dec 2021 18:19:56 +0100 (CET)
Date:   Mon, 6 Dec 2021 18:19:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        keescook@chromium.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: switch to atomic_t for request references
Message-ID: <Ya5GPJm+S1sgpDGj@hirez.programming.kicks-ass.net>
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org>
 <Ya3KZiLg5lYjsGcQ@hirez.programming.kicks-ass.net>
 <dbe2b14c-5f0a-80dd-b661-d0a7c74ba230@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbe2b14c-5f0a-80dd-b661-d0a7c74ba230@kernel.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 09:32:06AM -0700, Jens Axboe wrote:
> On 12/6/21 1:31 AM, Peter Zijlstra wrote:
> > On Sun, Dec 05, 2021 at 10:53:49PM -0800, Christoph Hellwig wrote:
> >> On Fri, Dec 03, 2021 at 08:35:40AM -0700, Jens Axboe wrote:
> >>> refcount_t is not as expensive as it used to be, but it's still more
> >>> expensive than the io_uring method of using atomic_t and just checking
> >>> for potential over/underflow.
> >>>
> >>> This borrows that same implementation, which in turn is based on the
> >>> mm implementation from Linus.
> >>
> >> If refcount_t isn't good enough for a normal kernel fast path we have
> >> a problem.  Can we discuss that with the maintainers instead of coming
> >> up with our home grown schemes again?
> > 
> > Quite; and for something that pretends to be about performance, it also
> > lacks any actual numbers to back that claim.
> 
> I can certainly generate that, it was already done for the two previous
> similar conversions though.

I've never seen those :-(
