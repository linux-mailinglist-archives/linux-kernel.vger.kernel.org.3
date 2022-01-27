Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B3C49E3AC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242133AbiA0NjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:39:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43286 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242015AbiA0NiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:38:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 465DE61C06
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 13:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84951C340E4;
        Thu, 27 Jan 2022 13:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643290684;
        bh=Z4jXUhGXYRsf6W87aXU9TwJRX0rB6w8vez308ZXgmGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cThq6PKD8052QciPNtsjzAI5JXCdzZ3Av3FiLuJIYnkhMe5xaJX9U9J0KMOHl8pNG
         TpMvGdEQNUl6ohX+qs1i/5nT1oRcohtBIajMqmsCmxe1LwcVY56ZEx3o2yEAQt6eKV
         YmUMg0mEkyekS5BDhrSu1vhNiTG1lZNnm1vVNcbfolMGPkf7B2sYZTE1iZa3a/G9Xp
         Nqw0SGXrNxuPTYcbFYGu3urfpPsORyCMYDVJ15nEPAJEwH9V0PWXAJBeEuIsH+gGY4
         Na6pMH6tGoB4871lw7K4zBdhkxAT1kghmmjlyl0MfKt7kmOTOACElrzjo+MG9ITIK1
         pP/S9gGyqswXA==
Date:   Thu, 27 Jan 2022 15:37:56 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Rafael Aquini <raquini@redhat.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 3/6] mm, memory_hotplug: drop arch_free_nodedata
Message-ID: <YfKgNEgv8mIUxqRD@kernel.org>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-4-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127085305.20890-4-mhocko@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 09:53:02AM +0100, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> Prior to "mm: handle uninitialized numa nodes gracefully" memory hotplug
> used to allocate pgdat when memory has been added to a node
> (hotadd_init_pgdat) arch_free_nodedata has been only used in the
> failure path because once the pgdat is exported (to be visible
> by NODA_DATA(nid)) it cannot really be freed because there is no
> synchronization available for that.
> 
> pgdat is allocated for each possible nodes now so the memory hotplug
> doesn't need to do the ever use arch_free_nodedata so drop it.
> 
> This patch doesn't introduce any functional change.
> 
> Acked-by: Rafael Aquini <raquini@redhat.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/ia64/mm/discontig.c       |  5 -----
>  include/linux/memory_hotplug.h |  3 ---
>  mm/memory_hotplug.c            | 10 ----------
>  3 files changed, 18 deletions(-)
> 
> diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
> index dd0cf4834eaa..73d0db36edb6 100644
> --- a/arch/ia64/mm/discontig.c
> +++ b/arch/ia64/mm/discontig.c
> @@ -615,11 +615,6 @@ pg_data_t * __init arch_alloc_nodedata(int nid)
>  	return memblock_alloc(size, SMP_CACHE_BYTES);
>  }
>  
> -void arch_free_nodedata(pg_data_t *pgdat)
> -{
> -	kfree(pgdat);
> -}
> -
>  void arch_refresh_nodedata(int update_node, pg_data_t *update_pgdat)
>  {
>  	pgdat_list[update_node] = update_pgdat;
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index cdd66bfdf855..60f09d3ebb3d 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -24,17 +24,14 @@ struct vmem_altmap;
>   * node_data[nid] = kzalloc() works well. But it depends on the architecture.
>   *
>   * In general, generic_alloc_nodedata() is used.
> - * Now, arch_free_nodedata() is just defined for error path of node_hot_add.
>   *
>   */
>  extern pg_data_t *arch_alloc_nodedata(int nid);
> -extern void arch_free_nodedata(pg_data_t *pgdat);
>  extern void arch_refresh_nodedata(int nid, pg_data_t *pgdat);
>  
>  #else /* CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */
>  
>  #define arch_alloc_nodedata(nid)	generic_alloc_nodedata(nid)
> -#define arch_free_nodedata(pgdat)	generic_free_nodedata(pgdat)
>  
>  #ifdef CONFIG_NUMA
>  /*
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index fc991831d296..875cdc7ffa58 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1217,16 +1217,6 @@ static pg_data_t __ref *hotadd_init_pgdat(int nid)
>  	return pgdat;
>  }
>  
> -static void rollback_node_hotadd(int nid)
> -{
> -	pg_data_t *pgdat = NODE_DATA(nid);
> -
> -	arch_refresh_nodedata(nid, NULL);
> -	free_percpu(pgdat->per_cpu_nodestats);
> -	arch_free_nodedata(pgdat);
> -}
> -
> -
>  /*
>   * __try_online_node - online a node if offlined
>   * @nid: the node ID
> -- 
> 2.30.2
> 

-- 
Sincerely yours,
Mike.
