Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3CBD46FF34
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 11:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240052AbhLJLAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbhLJLAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:00:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBF9C061746;
        Fri, 10 Dec 2021 02:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OsOjeqiwkNxCtbDHziimwLseQVWVs4KvQXBDBXX7iTs=; b=TZEtFFzFTNNvMMb3H+Z3Fil3Z7
        DorNuCP8VxmyH2bxGRLBzv5+0Epaf8fDRIQu4SwfR97UssQkEk8pIPTwchhoSN6RsB00B2c1frMBF
        JhiQbKmt4cmAuceGle1iiWpjmwAKZ1IlvBPSeFvsZmxHw529zs0uJ4WKqvsTOTV9xQ1GHuKjkr0dh
        +suDZns4j/q7zGT60+nWerCFlihD2yeR6vJZL+ht7V2XEk160bVD9keLl4Hi1HZRvIwx0Vu0hsVZS
        ftC1JKMw3HrOQUFH0bsTktbaLC4USq241E4RemRMFVulnXSohfCMW9y1JIcZqUvxM9zHUV29Fo1p1
        sROF1Zog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvdaR-00AFr6-Li; Fri, 10 Dec 2021 10:57:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 74F6830026A;
        Fri, 10 Dec 2021 11:57:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 60C142B2FBDFB; Fri, 10 Dec 2021 11:57:11 +0100 (CET)
Date:   Fri, 10 Dec 2021 11:57:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: switch to atomic_t for request references
Message-ID: <YbMyh6YBs9t8Pate@hirez.programming.kicks-ass.net>
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org>
 <Ya9E4HDK/LskTV+z@hirez.programming.kicks-ass.net>
 <Ya9hdlBuWYUWRQzs@hirez.programming.kicks-ass.net>
 <20211207202831.GA18361@worktop.programming.kicks-ass.net>
 <CAHk-=wg=yTX5DQ7xxD7xNhhaaEQw1POT2HQ9U0afYB+6aBTs6A@mail.gmail.com>
 <YbDmWFM5Kh1J2YqS@hirez.programming.kicks-ass.net>
 <CAHk-=wiFLbv2M9gRkh6_Zkwiza17QP0gJLAL7AgDqDArGBGpSQ@mail.gmail.com>
 <20211208184416.GY16608@worktop.programming.kicks-ass.net>
 <CAHk-=wg6reEPRY6ZDNA=3=cGRyK1csKhw0p3Ug57Z9by_Ev9Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg6reEPRY6ZDNA=3=cGRyK1csKhw0p3Ug57Z9by_Ev9Hw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 10:50:10AM -0800, Linus Torvalds wrote:
> On Wed, Dec 8, 2021 at 10:44 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > From testing xadd had different flags from add; I've not yet looked at
> > the SDM to see what it said on the matter.
> 
> That should not be the case. Just checked, and it just says
> 
>   "The CF, PF, AF, SF, ZF, and OF flags are set according to the
> result of the addition, which is stored in the destination operand"
> 
> which shows that I was confused about 'xadd' - I thought it returned
> the old value in the register ("fetch_add"). It doesn't. It returns
> the new one ("add_fetch"). And then 'fetch_add' ends up undoing it by
> doing a sub or whatever.
> 
> So the actual returned value and the flags should match on x86.
> 
> Other architectures have the "return old value" model, which does mean
> that my "different architectures can have different preferences for
> which one to test" argument was right, even if I got xadd wrong.

I think XADD does return old too; SDM states:

"Exchanges the first operand (destination operand) with the second
operand (source operand), then loads the sum of the two values into the
destination operand. The destination operand can be a register or a
memory location; the source operand is a register."

So it first exchanges and then adds. Which is why the flags are set for
add, not exchange.
