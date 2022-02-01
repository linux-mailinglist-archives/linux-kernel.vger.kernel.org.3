Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435AD4A598C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 11:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbiBAKCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 05:02:09 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:45616 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbiBAKCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:02:08 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7C7D0210FD;
        Tue,  1 Feb 2022 10:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643709727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DwKIOekMdXuDieQfYrBOzsRU+nvxbhd7QX5IZC35fHA=;
        b=MXpl4TbguNhk2+iA1AtguAanBRt4ZPOBb9z4Nyy2M5JEI4+/3D6FnwFmBWi7ZrXuvIL4vL
        Vp/A9xzM7RcgnWqJwoicmA1nyTXwe9qZVAWljma1FKxyW+IaAmnSF8K+7A6YJRJjvdaRW7
        zxFSeSBJQwLvigvpdZ/FjkVFSBT1kh0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5F1B4A3B81;
        Tue,  1 Feb 2022 10:02:07 +0000 (UTC)
Date:   Tue, 1 Feb 2022 11:02:07 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     mm-commits@vger.kernel.org, tj@kernel.org, rppt@linux.ibm.com,
        raquini@redhat.com, osalvador@suse.de, npache@redhat.com,
        eric.dumazet@gmail.com, dennis@kernel.org, david@redhat.com,
        cl@linux.com, amakhalov@vmware.com, richard.weiyang@gmail.com,
        akpm@linux-foundation.org
Subject: Re: +
 memcg-do-not-tweak-node-in-alloc_mem_cgroup_per_node_info.patch added to -mm
 tree
Message-ID: <YfkFH2H8Gzs7jXZp@dhcp22.suse.cz>
References: <20220131221901.F21E4C340E8@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131221901.F21E4C340E8@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 31-01-22 14:19:01, Andrew Morton wrote:
> From: Wei Yang <richard.weiyang@gmail.com>
> Subject: memcg: do not tweak node in alloc_mem_cgroup_per_node_info
> 
> alloc_mem_cgroup_per_node_info is allocated for each possible node and
> this used to be a problem because not !node_online nodes didn't have

Wei has pointed to my typo here. s@not !node_online@!online@

> appropriate data structure allocated.  This has changed by "mm: handle
> uninitialized numa nodes gracefully" so we can drop the special casing
> here.
> 
> Link: https://lkml.kernel.org/r/20220127085305.20890-7-mhocko@kernel.org
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Alexey Makhalov <amakhalov@vmware.com>
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: Eric Dumazet <eric.dumazet@gmail.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Rafael Aquini <raquini@redhat.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  mm/memcontrol.c |   14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> --- a/mm/memcontrol.c~memcg-do-not-tweak-node-in-alloc_mem_cgroup_per_node_info
> +++ a/mm/memcontrol.c
> @@ -5067,18 +5067,8 @@ struct mem_cgroup *mem_cgroup_from_id(un
>  static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
>  {
>  	struct mem_cgroup_per_node *pn;
> -	int tmp = node;
> -	/*
> -	 * This routine is called against possible nodes.
> -	 * But it's BUG to call kmalloc() against offline node.
> -	 *
> -	 * TODO: this routine can waste much memory for nodes which will
> -	 *       never be onlined. It's better to use memory hotplug callback
> -	 *       function.
> -	 */
> -	if (!node_state(node, N_NORMAL_MEMORY))
> -		tmp = -1;
> -	pn = kzalloc_node(sizeof(*pn), GFP_KERNEL, tmp);
> +
> +	pn = kzalloc_node(sizeof(*pn), GFP_KERNEL, node);
>  	if (!pn)
>  		return 1;
>  
> _
> 
> Patches currently in -mm which might be from richard.weiyang@gmail.com are
> 
> mm-page_alloc-add-same-penalty-is-enough-to-get-round-robin-order.patch
> mm-page_alloc-add-penalty-to-local_node.patch
> memcg-do-not-tweak-node-in-alloc_mem_cgroup_per_node_info.patch

-- 
Michal Hocko
SUSE Labs
