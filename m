Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F30469240
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 10:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240540AbhLFJ0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 04:26:18 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:53006 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240475AbhLFJ0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 04:26:17 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EE42F21954;
        Mon,  6 Dec 2021 09:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638782567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yyoZa/Wc0n39DagB2wlfs+HMTHs1pv5n70Y3IKNj/Rg=;
        b=pTMUgH/Ia8fD5QRTqfhIW65flPjEgohuiR5TeCRrRpWdsZYFG+BQ65l2WtHdUk2tigclLn
        xTvQbm+OIhMOImHO0D0Ip5Z4yMbtz8fYzVP8umXexLfVZO0bP2Elp2WYJxHrNd9XvvzQty
        SBMGSqDMKec8NI2Kvyzg+zpe3I6jkzk=
Received: from suse.cz (unknown [10.163.30.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8F82EA3B81;
        Mon,  6 Dec 2021 09:22:47 +0000 (UTC)
Date:   Mon, 6 Dec 2021 10:22:44 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Nico Pache <npache@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        ktkhai@virtuozzo.com, shy828301@gmail.com, guro@fb.com,
        vbabka@suse.cz, vdavydov.dev@gmail.com, raquini@redhat.com,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [RFC PATCH 1/2] include/linux/gfp.h: Do not allocate pages on a
 offlined node
Message-ID: <Ya3WZC1JWU5jdtlC@dhcp22.suse.cz>
References: <20211206033338.743270-1-npache@redhat.com>
 <20211206033338.743270-2-npache@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206033338.743270-2-npache@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 05-12-21 22:33:37, Nico Pache wrote:
> We shouldn't allocate pages on a unavailable node. Add a check for this
> in __alloc_pages_node and return NULL to avoid issues further down the
> callchain.
> 
> Also update the VM_WARN_ON in __alloc_pages_node which could skip this
> warn if the gfp_mask is not GFP_THISNODE.

Page allocator trusts callers to know they are doing a right thing so
that no unnecessary branches have to be implemented and the fast path is
really optimized for performance. Allocating from an !node_online node
is a bug in the caller. One that is not really that hard to make
unfortunatelly but also one that is is not that common.

That being said I am not really sure we want to introduce this check.

> Co-developed-by: Rafael Aquini <aquini@redhat.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  include/linux/gfp.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index b976c4177299..e7e18f6d0d9d 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -565,7 +565,10 @@ static inline struct page *
>  __alloc_pages_node(int nid, gfp_t gfp_mask, unsigned int order)
>  {
>  	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
> -	VM_WARN_ON((gfp_mask & __GFP_THISNODE) && !node_online(nid));
> +	VM_WARN_ON(!node_online(nid));
> +
> +	if (!node_online(nid))
> +		return NULL;
>  
>  	return __alloc_pages(gfp_mask, order, nid, NULL);
>  }
> -- 
> 2.33.1

-- 
Michal Hocko
SUSE Labs
