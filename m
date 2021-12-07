Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777CE46C0A2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 17:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbhLGQ0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 11:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239611AbhLGQ0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 11:26:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCF5C061746;
        Tue,  7 Dec 2021 08:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1rW4TIWUctUZp5j8orRF9W/v8nGZZ2ml7HDMf4H1m74=; b=cdY349pydLJQo+bEopeFqYOLGL
        sL8IiC3+DKp0QSxadaKTHWynfhtq0gLwJEX8/6PqSQI2VQgP3YQUvVAwYHrKD9befSwOaTXKKdUSg
        +FUSqm3prnSAbx5p+Dae/mcsAb0oabEOiEKshXeBoWDmdhuPITVQDnMpepcg1DjaCDPUndcDJd7LE
        i5b1dIiZfutwmyOj8Q56EwUA+rafGZr84UCY90ESwQc9tSc+FrNwPJ/ecmJD3Z2bwayG1JVpPaNfg
        S2sdutUWxRXqeS2uETOBJuM6wBf8pJnFXl+fm4hVkE2cYEhOGPPglm34n5ec9x4RjK48AOgmOX5Dk
        tP3mAb9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mudFC-007X6w-SL; Tue, 07 Dec 2021 16:23:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 971F930002F;
        Tue,  7 Dec 2021 17:23:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 82AD1201C9141; Tue,  7 Dec 2021 17:23:06 +0100 (CET)
Date:   Tue, 7 Dec 2021 17:23:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: switch to atomic_t for request references
Message-ID: <Ya+KasdqLmXhB41c@hirez.programming.kicks-ass.net>
References: <Ya2zfVAwh4aQ7KVd@infradead.org>
 <Ya3KZiLg5lYjsGcQ@hirez.programming.kicks-ass.net>
 <CAHk-=wjXmGt9-JQp-wvup4y2tFNUCVjvx2W7MHzuAaxpryP4mg@mail.gmail.com>
 <282666e2-93d4-0302-b2d0-47d03395a6d4@kernel.dk>
 <202112061247.C5CD07E3C@keescook>
 <CAHk-=wh0RhnMfZG6xQJ=yHTgmPTaxjQOo1Q2=r+_ZR56yiRi4A@mail.gmail.com>
 <202112061455.F23512C3CB@keescook>
 <CAHk-=whLU+dk7EmPu5UC6DDSd76_dO4bVd4BkvxmR4W5-mmAgg@mail.gmail.com>
 <Ya83zQRVUCRRYNHQ@hirez.programming.kicks-ass.net>
 <CAHk-=whWJv6xNPQMk+FFumWix+_O1gfwTiCx6tpmcQ4cY=_F=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whWJv6xNPQMk+FFumWix+_O1gfwTiCx6tpmcQ4cY=_F=A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 08:10:02AM -0800, Linus Torvalds wrote:
> Can you really not understand my dislike of a data type that is
> fundamentally a lazy shortcut and intentionally hides error cases with
> leaks?

I see the distinction; I just don't see it as hiding. refcount_t will
very much generate a splat indicating things need fixing, the leak
simply ensures that it doesn't get worse from there on out.

Anyway, if the code already needs to handle that failure case, such as
inc_not_zero() usage, then there is indeed no additional complexity.
