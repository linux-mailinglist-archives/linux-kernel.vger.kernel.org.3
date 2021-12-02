Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37FD466B99
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 22:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377023AbhLBV0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 16:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242942AbhLBV0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 16:26:37 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE209C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 13:23:14 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id s37so994339pga.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 13:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f92UhoV+UvtYus8uVnjAiNNc93iRwfX2vlNySXTiZA0=;
        b=lqmhKbkLMJ4IR225tm3NFDEkQx/1eYQG5+US8z4NtVACMz8mrHupVd4m6BYBmEYdQd
         acSBob80SxUuj/QjvBX6UKngQDhtyboMKpKrulyrnv90dCPgYM5gWX5JACyQQcDEFN2t
         mjjafX8urta1pud0A9TL8hOq7xyc+ci0vUN5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f92UhoV+UvtYus8uVnjAiNNc93iRwfX2vlNySXTiZA0=;
        b=6+EF8iC6BrtRdR+EDV1DEGiFHFbwoOYMqIlqUcwpEAmav/PK5dMY/9u01jnJgKtLJW
         KAAmzqWH5DK8Wouq3baz24lHtAY3Q2zkR9pJReh0IfHhY1cxCw+RaUhoXC6oWvlMQcx7
         k7T65UhV9c3JjDSGZrBk4XYggBayb7LyP8KOgSemUCT2usZ7td4FGuRMaC2GUWLBejQi
         A59W1gp3VQLZo+UkFzyNU0Uubf+nISHC6x/VIgLUyWQ0hRF9unABimXrrm7kRFUVE6tb
         Ty64ipFDTr4P9zk0gAJ+ggYpZTeiNkWpM08vw3ahBBRAIVppUArP1DVjmRD16pmxoUGN
         PgXA==
X-Gm-Message-State: AOAM530E3XZ0eQPDUciy12NxU2np10TxgfTp70nc1jN6mSzc9k2lc3oD
        Z4K3OlT2YI23M3TpR9GXN1oJFQ==
X-Google-Smtp-Source: ABdhPJynLXbQq+VwjTcfthHvA+r4AoagXGsII57SAR8iwsArMOCPYIqO1c/t31wTiFbEtBwrxc+QwA==
X-Received: by 2002:a63:be4e:: with SMTP id g14mr1353293pgo.194.1638480194239;
        Thu, 02 Dec 2021 13:23:14 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y7sm460527pge.44.2021.12.02.13.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 13:23:13 -0800 (PST)
Date:   Thu, 2 Dec 2021 13:23:13 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bixuan Cui <cuibixuan@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        w@1wt.eu
Subject: Re: [PATCH -next] mm: delete oversized WARN_ON() in kvmalloc() calls
Message-ID: <202112021320.87AB40A@keescook>
References: <1638410784-48646-1-git-send-email-cuibixuan@linux.alibaba.com>
 <20211201192643.ecb0586e0d53bf8454c93669@linux-foundation.org>
 <Yajk/oVypyUFTtgd@unreal>
 <YajmawzehKqR+j0v@casper.infradead.org>
 <YajviIws7csNbTxU@unreal>
 <202112021105.C9E64318F@keescook>
 <YakdWMtZzRCTeMUP@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YakdWMtZzRCTeMUP@unreal>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 09:24:08PM +0200, Leon Romanovsky wrote:
> On Thu, Dec 02, 2021 at 11:08:34AM -0800, Kees Cook wrote:
> > On Thu, Dec 02, 2021 at 06:08:40PM +0200, Leon Romanovsky wrote:
> > > On Thu, Dec 02, 2021 at 03:29:47PM +0000, Matthew Wilcox wrote:
> > > > On Thu, Dec 02, 2021 at 05:23:42PM +0200, Leon Romanovsky wrote:
> > > > > The problem is that this WARN_ON() is triggered by the users.
> > > > 
> > > > ... or the problem is that you don't do a sanity check between the user
> > > > and the MM system.  I mean, that's what this conversation is about --
> > > > is it a bug to be asking for this much memory in the first place?
> > > 
> > > We do a lot of checks, and in this case, user provided valid input.
> > > He asked size that doesn't cross his address space.
> > > https://elixir.bootlin.com/linux/v5.16-rc3/source/drivers/infiniband/core/umem_odp.c#L67
> > > 
> > > 		start = ALIGN_DOWN(umem_odp->umem.address, page_size);
> > > 		if (check_add_overflow(umem_odp->umem.address,
> > > 				       (unsigned long)umem_odp->umem.length,
> > > 				       &end))
> > > 			return -EOVERFLOW;
> > > 
> > > There is a feature called ODP (on-demand-paging) which is supported
> > > in some RDMA NICs. It allows to the user "export" their whole address
> > > space to the other RDMA node without pinning the pages. And once the
> > > other node sends data to not-pinned page, the RDMA NIC will prefetch
> > > it.
> > 
> > I think we have two cases:
> > 
> > - limiting kvmalloc allocations to INT_MAX
> > - issuing a WARN when that limit is exceeded
> > 
> > The argument for the having the WARN is "that amount should never be
> > allocated so we want to find the pathological callers".
> > 
> > But if the actual issue is that >INT_MAX is _acceptable_, then we have
> > to do away with the entire check, not just the WARN.
> 
> First we need to get rid from WARN_ON(), which is completely safe thing to do.
> 
> Removal of the check can be done in second step as it will require audit
> of whole kvmalloc* path.

If those are legit sizes, I'm fine with dropping the WARN. (But I still
think if they're legit sizes, we must also drop the INT_MAX limit.)

-- 
Kees Cook
