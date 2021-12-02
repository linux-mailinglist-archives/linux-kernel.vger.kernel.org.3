Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409EC466679
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 16:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358956AbhLBPdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238168AbhLBPdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:33:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA990C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 07:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AItHeJ0oln2JoDLNrVD++S/qW9cwrMAx59j/XHAQAoM=; b=rk10OiZeU0ko0E7iakmFGjmT8e
        vVs8pF6SY3WYxgE8zXdFESHOyTaVeYqtccl3sJy3YRwtQE8adzZc3Oj+fYGkBfydqloGZfu6sdz7p
        k728ejXrBNgUgX6FfIJtOAvJ9NvVMhKcI5yM5qnqZhjn/5y9Pf+ADBeVlxKXK+W0g25/B1Vz9zhv0
        KriHA+LDC0ejP9vLW7DwydTEWr5Fs+M7HLG/4tMgFVTraWkU9B0/1LhFLTa0IMpe3sQOxWvYd21cd
        eXJGeK5mWMpUfk2myeNjsMCfZa/Go1eBRP20L6mtc3rqNt0RsGcdrc443ONJ4omMBEXOd7TGe0DGR
        nlaxG3JA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mso1r-004VWo-LJ; Thu, 02 Dec 2021 15:29:47 +0000
Date:   Thu, 2 Dec 2021 15:29:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Bixuan Cui <cuibixuan@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        w@1wt.eu, keescook@chromium.org
Subject: Re: [PATCH -next] mm: delete oversized WARN_ON() in kvmalloc() calls
Message-ID: <YajmawzehKqR+j0v@casper.infradead.org>
References: <1638410784-48646-1-git-send-email-cuibixuan@linux.alibaba.com>
 <20211201192643.ecb0586e0d53bf8454c93669@linux-foundation.org>
 <Yajk/oVypyUFTtgd@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yajk/oVypyUFTtgd@unreal>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 05:23:42PM +0200, Leon Romanovsky wrote:
> The problem is that this WARN_ON() is triggered by the users.

... or the problem is that you don't do a sanity check between the user
and the MM system.  I mean, that's what this conversation is about --
is it a bug to be asking for this much memory in the first place?

> At least in the RDMA world, users can provide huge sizes and they expect
> to get plain -ENOMEM and not dump stack, because it happens indirectly
> to them.
> 
> In our case, these two kvcalloc() generates WARN_ON().
> 
> 		umem_odp->pfn_list = kvcalloc(
> 			npfns, sizeof(*umem_odp->pfn_list), GFP_KERNEL);

Does it really make sense for the user to specify 2^31 PFNs in a single
call?  I mean, that's 8TB of memory.  Should RDMA put its own limit
in here, or should it rely on kvmalloc returning -ENOMEM?

