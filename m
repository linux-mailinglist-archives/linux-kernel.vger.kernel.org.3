Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58B2466A66
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 20:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376809AbhLBT2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 14:28:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44318 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376813AbhLBT1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 14:27:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C28A1B8245D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 19:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C738C00446;
        Thu,  2 Dec 2021 19:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638473053;
        bh=ToLJiJi+yfxgYJ7dJxUGOXCS1eDFDGrtQfCtcKFg/cQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cu/9Y8XntevbtxwM0faRmrayGwywHAkeZoIP+/sW8XsTxtPgiy8mR1Y1bL94pfF6j
         kLT3u7SCR0H20XaGj5t6HH0YWeED9g0fonj8GZdg74k2bSHSRLavz2ZNTWM8Mp39G6
         EedJMEFJquAnnhhjKm2GwcqBCheUw6seZmYnVN8HVs1OW+cl2QaZ6lnE/oEHpWSy1V
         RquCM8V4TtFNsLnmGOsAAJ6jjSmJL/8E0YpVk75SGGlSRNsXWfjTc5Dc+U0zxQXpHP
         lDnxKjWrKTHGkMZWecdHzr9kX0i2qX1kW3es4z8lRMPZaFVpmguXW8ziC2Ukak+nnb
         2QqL43lh2c4gw==
Date:   Thu, 2 Dec 2021 21:24:08 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bixuan Cui <cuibixuan@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        w@1wt.eu
Subject: Re: [PATCH -next] mm: delete oversized WARN_ON() in kvmalloc() calls
Message-ID: <YakdWMtZzRCTeMUP@unreal>
References: <1638410784-48646-1-git-send-email-cuibixuan@linux.alibaba.com>
 <20211201192643.ecb0586e0d53bf8454c93669@linux-foundation.org>
 <Yajk/oVypyUFTtgd@unreal>
 <YajmawzehKqR+j0v@casper.infradead.org>
 <YajviIws7csNbTxU@unreal>
 <202112021105.C9E64318F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112021105.C9E64318F@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 11:08:34AM -0800, Kees Cook wrote:
> On Thu, Dec 02, 2021 at 06:08:40PM +0200, Leon Romanovsky wrote:
> > On Thu, Dec 02, 2021 at 03:29:47PM +0000, Matthew Wilcox wrote:
> > > On Thu, Dec 02, 2021 at 05:23:42PM +0200, Leon Romanovsky wrote:
> > > > The problem is that this WARN_ON() is triggered by the users.
> > > 
> > > ... or the problem is that you don't do a sanity check between the user
> > > and the MM system.  I mean, that's what this conversation is about --
> > > is it a bug to be asking for this much memory in the first place?
> > 
> > We do a lot of checks, and in this case, user provided valid input.
> > He asked size that doesn't cross his address space.
> > https://elixir.bootlin.com/linux/v5.16-rc3/source/drivers/infiniband/core/umem_odp.c#L67
> > 
> > 		start = ALIGN_DOWN(umem_odp->umem.address, page_size);
> > 		if (check_add_overflow(umem_odp->umem.address,
> > 				       (unsigned long)umem_odp->umem.length,
> > 				       &end))
> > 			return -EOVERFLOW;
> > 
> > There is a feature called ODP (on-demand-paging) which is supported
> > in some RDMA NICs. It allows to the user "export" their whole address
> > space to the other RDMA node without pinning the pages. And once the
> > other node sends data to not-pinned page, the RDMA NIC will prefetch
> > it.
> 
> I think we have two cases:
> 
> - limiting kvmalloc allocations to INT_MAX
> - issuing a WARN when that limit is exceeded
> 
> The argument for the having the WARN is "that amount should never be
> allocated so we want to find the pathological callers".
> 
> But if the actual issue is that >INT_MAX is _acceptable_, then we have
> to do away with the entire check, not just the WARN.

First we need to get rid from WARN_ON(), which is completely safe thing to do.

Removal of the check can be done in second step as it will require audit
of whole kvmalloc* path.

Thanks

> 
> -- 
> Kees Cook
