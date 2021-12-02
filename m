Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B3D466661
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 16:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358935AbhLBP1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:27:15 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35012 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358930AbhLBP1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:27:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C3F3B823A8
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 15:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75191C00446;
        Thu,  2 Dec 2021 15:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638458627;
        bh=DoFQVdCmJ+10smCDr1M4YnkOUL3I84YplyEf7u4N/K8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=quP1VV8RgqGIfGlFDxjvb7grT5Kj08wlTT4Pxz46k19bev2OEMLxovMVvZm57BKhq
         tqOovp0EQcqrF2Gg0g6LF7vZu0f+Y3yt6MBK7UB5cezzmPydr0iQN7D0jLNWYn8QTW
         wzxeUfTbh654x5VFqkm5D5IpccLRBOtwSZTpW1q41P9Fi/nGUqXzJwxaSWNoDwF3b8
         xQ1WQkxYEsCsncHwWUmZlwOQfPL2sUPeQQbHU5eAR5HCVicYXtBNAZ0SPZMc6sBD+q
         DwgZ1bYxekU0AsPMeuM0BDpCn8kkZ75eXe5w7o5JZ3HoO5ClloXf8BDtiv+gcNr5Na
         foKnAtqzDqnEw==
Date:   Thu, 2 Dec 2021 17:23:42 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Bixuan Cui <cuibixuan@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        w@1wt.eu, keescook@chromium.org
Subject: Re: [PATCH -next] mm: delete oversized WARN_ON() in kvmalloc() calls
Message-ID: <Yajk/oVypyUFTtgd@unreal>
References: <1638410784-48646-1-git-send-email-cuibixuan@linux.alibaba.com>
 <20211201192643.ecb0586e0d53bf8454c93669@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201192643.ecb0586e0d53bf8454c93669@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 07:26:43PM -0800, Andrew Morton wrote:
> On Thu,  2 Dec 2021 10:06:24 +0800 Bixuan Cui <cuibixuan@linux.alibaba.com> wrote:
> 
> > Delete the WARN_ON() and return NULL directly for oversized parameter
> > in kvmalloc() calls.
> > Also add unlikely().
> > 
> > Fixes: 7661809d493b ("mm: don't allow oversized kvmalloc() calls")
> > Signed-off-by: Bixuan Cui <cuibixuan@linux.alibaba.com>
> > ---
> > There are a lot of oversize warnings and patches about kvmalloc() calls
> > recently. Maybe these warnings are not very necessary.
> 
> Or maybe they are.  Please let's take a look at these warnings, one at
> a time.  If a large number of them are bogus then sure, let's disable
> the runtime test.  But perhaps it's the case that calling code has
> genuine issues and should be repaired.

Andrew,

The problem is that this WARN_ON() is triggered by the users.

At least in the RDMA world, users can provide huge sizes and they expect
to get plain -ENOMEM and not dump stack, because it happens indirectly
to them.

In our case, these two kvcalloc() generates WARN_ON().

		umem_odp->pfn_list = kvcalloc(
			npfns, sizeof(*umem_odp->pfn_list), GFP_KERNEL);
		if (!umem_odp->pfn_list)
			return -ENOMEM;

		umem_odp->dma_list = kvcalloc(
			ndmas, sizeof(*umem_odp->dma_list), GFP_KERNEL);
https://elixir.bootlin.com/linux/v5.16-rc3/source/drivers/infiniband/core/umem_odp.c#L80

It is not a kernel programmer error to allow "oversized kvmalloc call" .

Thanks
