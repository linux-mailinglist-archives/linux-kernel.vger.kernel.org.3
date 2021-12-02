Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBC0466799
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359135AbhLBQMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbhLBQMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:12:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6135CC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 08:08:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C8AB626E2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 16:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE86AC00446;
        Thu,  2 Dec 2021 16:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638461324;
        bh=p2KZgqN80W7bcbxbxXbmgjm5dt5Eb5v4ahxcjc2zNsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i2NWBKrh/rOMYSo3cpVbBs032u3wIInxX+tCB91LqMeHHCh+QDlgOhQ5EMOyRDM6R
         cy/TRhAbC0bZ/VRvuEO4ryHYfRlRgJ0rdS45P8v8FGM5HrYCG6PB9++q1Kred/Y8eI
         sEg4xF78miGqqwzJ9Ax75rqeJdxLoyS3Bw2KuE0liwkBixsYUDer7MCHnRabMcU8MF
         /GvMbtoCI1XvDZRHCS0ItkenUnEOFbOEeDKcHrdFo3WOdufpR9/Td6v99JeiJ0rcwK
         gVncFE6bUH7cPlIWEmtkWV+6BLuUONmkxyD98zj8a6U0m1FAz3DaxSZXw6GlvpkmYq
         r9veprvgTtaEA==
Date:   Thu, 2 Dec 2021 18:08:40 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Bixuan Cui <cuibixuan@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        w@1wt.eu, keescook@chromium.org
Subject: Re: [PATCH -next] mm: delete oversized WARN_ON() in kvmalloc() calls
Message-ID: <YajviIws7csNbTxU@unreal>
References: <1638410784-48646-1-git-send-email-cuibixuan@linux.alibaba.com>
 <20211201192643.ecb0586e0d53bf8454c93669@linux-foundation.org>
 <Yajk/oVypyUFTtgd@unreal>
 <YajmawzehKqR+j0v@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YajmawzehKqR+j0v@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 03:29:47PM +0000, Matthew Wilcox wrote:
> On Thu, Dec 02, 2021 at 05:23:42PM +0200, Leon Romanovsky wrote:
> > The problem is that this WARN_ON() is triggered by the users.
> 
> ... or the problem is that you don't do a sanity check between the user
> and the MM system.  I mean, that's what this conversation is about --
> is it a bug to be asking for this much memory in the first place?

We do a lot of checks, and in this case, user provided valid input.
He asked size that doesn't cross his address space.
https://elixir.bootlin.com/linux/v5.16-rc3/source/drivers/infiniband/core/umem_odp.c#L67

		start = ALIGN_DOWN(umem_odp->umem.address, page_size);
		if (check_add_overflow(umem_odp->umem.address,
				       (unsigned long)umem_odp->umem.length,
				       &end))
			return -EOVERFLOW;

There is a feature called ODP (on-demand-paging) which is supported
in some RDMA NICs. It allows to the user "export" their whole address
space to the other RDMA node without pinning the pages. And once the
other node sends data to not-pinned page, the RDMA NIC will prefetch
it.

> 
> > At least in the RDMA world, users can provide huge sizes and they expect
> > to get plain -ENOMEM and not dump stack, because it happens indirectly
> > to them.
> > 
> > In our case, these two kvcalloc() generates WARN_ON().
> > 
> > 		umem_odp->pfn_list = kvcalloc(
> > 			npfns, sizeof(*umem_odp->pfn_list), GFP_KERNEL);
> 
> Does it really make sense for the user to specify 2^31 PFNs in a single
> call?  I mean, that's 8TB of memory.  Should RDMA put its own limit
> in here, or should it rely on kvmalloc returning -ENOMEM?

I heard about such systems with so many available RAM. I don't know
about their usage pattern, most likely they will use hugepages, but
it is my guess.

The thing is that it is not RDMA-specific. You are asking to place same
if (size > KVMALLOC...) check in all subsystems.

Thanks
