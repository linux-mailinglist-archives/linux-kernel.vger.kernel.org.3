Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C0146C861
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 00:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238230AbhLGXsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 18:48:14 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49960 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhLGXsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 18:48:13 -0500
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3EF7BB81D81
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 23:44:42 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D4C660E98;
        Tue,  7 Dec 2021 23:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1638920680;
        bh=BEwEUCLZRSg2aVfAnY3W95UfGY4Oj5ctvBxKSFO7qgc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iYskK9Zu/idmCtyqe71iiLRVLganSC9yWh7Xeb/20f5UDuoW3vHTjkwx6Pu8oH7bm
         diddNxpbzyHanek/5Cyc4Jsyk0Qpu5ZExDIl16LGSpHg6lG1uhmJvwipx9cqAOmIj0
         1DopsKnJNabNwgBfaLWocXqyUrzT7szk+qVxT5Ho=
Date:   Tue, 7 Dec 2021 15:44:38 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nico Pache <npache@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        shakeelb@google.com, ktkhai@virtuozzo.com, shy828301@gmail.com,
        guro@fb.com, vbabka@suse.cz, vdavydov.dev@gmail.com,
        raquini@redhat.com, mhocko@suse.com, david@redhat.com
Subject: Re: [PATCH v2 1/1] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
Message-Id: <20211207154438.c1e49a3f0b5ebc9245aac61b@linux-foundation.org>
In-Reply-To: <20211207224013.880775-2-npache@redhat.com>
References: <20211207224013.880775-1-npache@redhat.com>
        <20211207224013.880775-2-npache@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Dec 2021 17:40:13 -0500 Nico Pache <npache@redhat.com> wrote:

> We have run into a panic caused by a shrinker allocation being attempted
> on an offlined node.
>
> Our crash analysis has determined that the issue originates from trying
> to allocate pages on an offlined node in expand_one_shrinker_info. This
> function makes the incorrect assumption that we can allocate on any node.
> To correct this we make sure the node is online before tempting an
> allocation. If it is not online choose the closest node.

This isn't fully accurate, is it?  We could allocate on a node which is
presently offline but which was previously onlined, by testing
NODE_DATA(nid).

It isn't entirely clear to me from the v1 discussion why this approach
isn't being taken?

AFAICT the proposed patch is *already* taking this approach, by having
no protection against a concurrent or subsequent node offlining?

> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -222,13 +222,16 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>  	int size = map_size + defer_size;
>  
>  	for_each_node(nid) {
> +		int tmp = nid;

Not `tmp', please.  Better to use an identifier which explains the
variable's use.  target_nid?

And a newline after defining locals, please.

>  		pn = memcg->nodeinfo[nid];
>  		old = shrinker_info_protected(memcg, nid);
>  		/* Not yet online memcg */
>  		if (!old)
>  			return 0;
>  
> -		new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
> +		if(!node_online(nid))

s/if(/if (/

> +			tmp = numa_mem_id();
> +		new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, tmp);
>  		if (!new)
>  			return -ENOMEM;
>  

And a code comment fully explaining what's going on here?
