Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7284772F6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237437AbhLPNQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:16:51 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37854 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237432AbhLPNQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:16:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EA5261961
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 13:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30310C36AE0;
        Thu, 16 Dec 2021 13:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639660609;
        bh=wS6+BRqAuEKqK2Jnb3RLW+2icICsIUFVktOV0XCXrtk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kB5aY6gmmzs8V3OR5sh6K2D10Qye9NP8jAuIPF6J023FxvfYGr4RQjmeZrKyA1mqS
         Q1ss5XawLlJXuvDpPJSjq17UlJVBispG6NRqSpDEx3aVl8BAMDFmnZ/ODxqesu+22i
         InCXvj7hwrFrvvkc7lNK27TWXn9x0/9XbjQIwIsk=
Date:   Thu, 16 Dec 2021 14:16:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, rafael@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
Subject: Re: [PATCH 1/2] mm: add MemAvailable to per-node meminfo
Message-ID: <Ybs8P3WcPtShi15o@kroah.com>
References: <20211216124655.32247-1-zhengqi.arch@bytedance.com>
 <20211216124655.32247-2-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216124655.32247-2-zhengqi.arch@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 08:46:54PM +0800, Qi Zheng wrote:
> In /proc/meminfo, we can show the sum of all the available memory
> as "MemAvailable". Add the same counter also to per-node meminfo
> under /sys.
> 
> With this counter, some processes that bind nodes can make some
> decisions by reading the "MemAvailable" of the corresponding nodes
> directly.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  drivers/base/node.c    |  4 ++++
>  include/linux/mm.h     |  1 +
>  include/linux/mmzone.h |  5 +++++
>  mm/page_alloc.c        | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 59 insertions(+)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 87acc47e8951..deb2a7965ae4 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -375,8 +375,10 @@ static ssize_t node_read_meminfo(struct device *dev,
>  	struct sysinfo i;
>  	unsigned long sreclaimable, sunreclaimable;
>  	unsigned long swapcached = 0;
> +	long available;
>  
>  	si_meminfo_node(&i, nid);
> +	available = si_mem_available_node(&i, nid);
>  	sreclaimable = node_page_state_pages(pgdat, NR_SLAB_RECLAIMABLE_B);
>  	sunreclaimable = node_page_state_pages(pgdat, NR_SLAB_UNRECLAIMABLE_B);
>  #ifdef CONFIG_SWAP
> @@ -386,6 +388,7 @@ static ssize_t node_read_meminfo(struct device *dev,
>  			    "Node %d MemTotal:       %8lu kB\n"
>  			    "Node %d MemFree:        %8lu kB\n"
>  			    "Node %d MemUsed:        %8lu kB\n"
> +			    "Node %d MemAvailable:   %8lu kB\n"

You just changed a user/kernel api without documenting it anywhere, or
ensuring that you did not just break anything.

Also, this api is crazy, and not ok, please never add anything new to
it, it is broken as-is.

thanks,

greg k-h
