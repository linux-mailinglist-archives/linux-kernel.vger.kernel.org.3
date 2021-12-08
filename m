Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D55546DD1D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240340AbhLHUg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbhLHUg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:36:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C14C061746;
        Wed,  8 Dec 2021 12:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/C1sx1Rrf17DkOHTiufRn+52P0irAvrEcXdsH2isf/0=; b=d2XLwSUa03ZKr1j4c51VJu+89D
        BM5dTs8cSS6rCwSdXkAf7/GwPOE+zJVPJhAOvO+FcAFjzORw2wj6pVX+8WNK/2LWVHX5ry+0u5BHY
        a38APjCYxx1FHtkSQ/xJOSP1yXu7W6Bl7087ZDe1JlO3k8mO6AQ+rFMDnUHprn1GdPVD50UXmyU5I
        nM846QGaezcjj87lGm7smvmHXFtql1iNA1r0HZadj4zmA5JoTlzf3DD9ACdgGs5SHrwg7iM5fJl6r
        t0nXOaTbKn0VXEVsXD7/+GwwuX2+lV/kE2BSMAKiWlXsELODsia+aANEN3KneBUc45sABauDmZ2Ao
        nhFmsteA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mv3cP-008khH-M6; Wed, 08 Dec 2021 20:32:50 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 96FBC9811F7; Wed,  8 Dec 2021 21:32:50 +0100 (CET)
Date:   Wed, 8 Dec 2021 21:32:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: switch to atomic_t for request references
Message-ID: <20211208203250.GA16608@worktop.programming.kicks-ass.net>
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

I got the constraints wrong :/ They match now.
