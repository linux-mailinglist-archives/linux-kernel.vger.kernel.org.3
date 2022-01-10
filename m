Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232FE489F79
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242072AbiAJSpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241206AbiAJSpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:45:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49963C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ttn+yS73TigEPGpcw2iqzr9CnaebrsST4PVtbMFaqN0=; b=KsFSWNgo4t73Sb74XHFILkTFLp
        eQfaEjBlx8U9z6Z4isrZ6ltYnzBzsuV7f5K8AaPiFmA8W11fB6AwP3o1bR6IRuyCU/gTC7U9SXirn
        9a10lf/iK1/tPtZsq3ZgVwzjsYYrx2y3FTT/pDC8LlfkZ6c6cII/syS/1NbbtWQIDv7yZIcO8heeU
        HWwIjRRrjyoorgyHIez7YHr9BCjvvHGEGfV0zO/i6rlQcrbVvqncq/RR1Qd22Hqe8WLfX/x2r+zdZ
        D6e9X1VpcSAKfCsYLWzxrOnghBrupzPK+IMr6sl5N+pKx6wU7ITnbNDMiz6vlVkf9zmavFSBKX+yX
        S5XNJ/lw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6zfR-002eHC-TG; Mon, 10 Jan 2022 18:45:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9ACF0300079;
        Mon, 10 Jan 2022 19:45:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 846AE284872AC; Mon, 10 Jan 2022 19:45:15 +0100 (CET)
Date:   Mon, 10 Jan 2022 19:45:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Tim Murray <timmurray@google.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] f2fs: move f2fs to use reader-unfair rwsems
Message-ID: <Ydx+u9YpzS8AZHrl@hirez.programming.kicks-ass.net>
References: <20220108164617.3130175-1-jaegeuk@kernel.org>
 <YdvoxkAAquI17UbX@infradead.org>
 <a23a3226-95d9-9835-c1c7-2d13f4a1ee16@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a23a3226-95d9-9835-c1c7-2d13f4a1ee16@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 11:18:27AM -0500, Waiman Long wrote:
> 
> On 1/10/22 03:05, Christoph Hellwig wrote:
> > Adding the locking primitive maintainers to this patch adding open coded
> > locking primitives..
> > 
> > On Sat, Jan 08, 2022 at 08:46:17AM -0800, Jaegeuk Kim wrote:
> > > From: Tim Murray <timmurray@google.com>
> > > 
> > > f2fs rw_semaphores work better if writers can starve readers,
> > > especially for the checkpoint thread, because writers are strictly
> > > more important than reader threads. This prevents significant priority
> > > inversion between low-priority readers that blocked while trying to
> > > acquire the read lock and a second acquisition of the write lock that
> > > might be blocking high priority work.
> > > 
> > > Signed-off-by: Tim Murray <timmurray@google.com>
> > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> We could certainly implement a down_read() variant (e.g.
> down_read_lowprio()) with its own slowpath function to do this within the
> rwsem code as long as there is a good use-case for this kind of
> functionality.

I think _unfair() or something along those lines is a *much* better
naming that _lowprio(). Consider a RT task ending up calling _lowprio().
That just doesn't make conceptual sense.

And then there's the lockdep angle; the thing being unfair will lead to
scenarios where lockdep will give a false positive because it expects
the r-w-r order to block things, which won't happen. A position needs to
be taken a-prioriy.

But before all that, a sane problem description. Can't propose solutions
without having a problem.
