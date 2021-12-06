Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB71D46AE38
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 00:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359732AbhLFXH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 18:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359606AbhLFXH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 18:07:57 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE171C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 15:04:27 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 01C44CE17E3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 23:04:26 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6A81603E8;
        Mon,  6 Dec 2021 23:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1638831864;
        bh=5R+GpQykZxm/WYoRJ8Nr6M9bGylNawhu7NoDiTQ2Xd4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=y6UjRhIJuYtG1zmA8txfzTXBKxadhJMgs5+ZBkzMy6ZwylNDVHE3FSBu+zZV5zlQo
         1OpgNhVK8E404tZ6+x9WAAItB4c9LMeuewtKmP6B4nCpCl94OIq5DY4zRgA8xYOacA
         +CzgkanZLkq/OyfphB8vCSyBSe2j918I7tUB2GWE=
Date:   Mon, 6 Dec 2021 15:04:21 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>
Subject: Re: [PATCH] mm: don't call lru draining in the nested
 lru_cache_disable
Message-Id: <20211206150421.fc06972fac949a5f6bc8b725@linux-foundation.org>
In-Reply-To: <20211206221006.946661-1-minchan@kernel.org>
References: <20211206221006.946661-1-minchan@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Dec 2021 14:10:06 -0800 Minchan Kim <minchan@kernel.org> wrote:

> lru_cache_disable involves IPIs to drain pagevec of each core,
> which sometimes takes quite long time to complete depending
> on cpu's business, which makes allocation too slow up to
> sveral hundredth milliseconds. Furthermore, the repeated draining
> in the alloc_contig_range makes thing worse considering caller
> of alloc_contig_range usually tries multiple times in the loop.
> 
> This patch makes the lru_cache_disable aware of the fact the
> pagevec was already disabled. With that, user of alloc_contig_range
> can disable the lru cache in advance in their context during the
> repeated trial so they can avoid the multiple costly draining
> in cma allocation.

Isn't this racy?
 
> ...
>
> @@ -859,7 +869,12 @@ atomic_t lru_disable_count = ATOMIC_INIT(0);
>   */
>  void lru_cache_disable(void)
>  {
> -	atomic_inc(&lru_disable_count);
> +	/*
> +	 * If someone is already disabled lru_cache, just return with
> +	 * increasing the lru_disable_count.
> +	 */
> +	if (atomic_inc_not_zero(&lru_disable_count))
> +		return;
>  #ifdef CONFIG_SMP
>  	/*
>  	 * lru_add_drain_all in the force mode will schedule draining on
> @@ -873,6 +888,7 @@ void lru_cache_disable(void)
>  #else
>  	lru_add_and_bh_lrus_drain();
>  #endif

There's a window here where lru_disable_count==0 and new pages can get
added to lru?

> +	atomic_inc(&lru_disable_count);
>  }

