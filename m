Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562CF49E2B0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241353AbiA0MmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:42:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47105 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241395AbiA0MmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:42:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643287327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ZCYUwqDDdrT8j+JPGM77Yy7DvHBOZi+hMacOjThVUY=;
        b=hssR1OZpjc8SJIfcDb4IMSXoALBnz4g/TQi6cVdQzI3C7vl3GCc+bgA2fqinJaDltgwauJ
        Qa475wXZvxMLNESWZum7ZyGwWN64sJjGpMWoLynFEWvEZ2uwf27CZ6/PDRraoivfqmwkJE
        BggKqoD752n+ixHGCq07ZhY8ncn/QqQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-542-1YOUl5ZSMVyL5oz83cHZuw-1; Thu, 27 Jan 2022 07:42:05 -0500
X-MC-Unique: 1YOUl5ZSMVyL5oz83cHZuw-1
Received: by mail-wm1-f71.google.com with SMTP id bg32-20020a05600c3ca000b00349f2aca1beso1421658wmb.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 04:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=+ZCYUwqDDdrT8j+JPGM77Yy7DvHBOZi+hMacOjThVUY=;
        b=si7odQBPnPhyxaRpdUhxMCESIqZuLvo9z/+hvy+cQRicM7vKZ/tRy883dwO1ENvE/I
         xsWWyR2wt8bui3eVTKgcbcPm7yTPm+o760tBzCagyY9YwjG9hgaNW6GqtZxqjzHh47qd
         EmjtJT4kU/llC8p4zSRbU3xRrb2h8NsQ/aj9Xllfm5v/opI/SGIvLfFh+pSytXjQdcGQ
         0BBZfB6Qg8/ht7tGi/pV6TMamK4M26S2t+C/QA3iFvaFQ33k00bFdt6VfMdFhiIL92k5
         rlMETMdc8U0lM6MgTxYCoaZFrRGYychrMRU58rVjtMB3a2A6AaBJsu5o9jI/2N2aJTv2
         2Sig==
X-Gm-Message-State: AOAM532ZuapiO9QXvQSpURkFTwO1xf6/8J4wnK46w1BNReOoUt1yevq7
        alwXX95vK4TaWbDrZEJ3LtO/+/atvpIDUt94sCUzFseRw9g4wxgu7ttrxSRCKQP6GGxsXAFBSz1
        EfhJlQg2RTMx7dd7SdstY7P5Y
X-Received: by 2002:a05:6000:2a2:: with SMTP id l2mr2917325wry.306.1643287324505;
        Thu, 27 Jan 2022 04:42:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJydYr4P2sdULpp26oBjp8Ca1fz+3CWDjiNf27VQMOA4/Yg68rBq308t6po6o05pm2mOjX23YQ==
X-Received: by 2002:a05:6000:2a2:: with SMTP id l2mr2917301wry.306.1643287324225;
        Thu, 27 Jan 2022 04:42:04 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:8300:4812:9d4f:6cd8:7f47? (p200300cbc70d830048129d4f6cd87f47.dip0.t-ipconnect.de. [2003:cb:c70d:8300:4812:9d4f:6cd8:7f47])
        by smtp.gmail.com with ESMTPSA id 6sm2558520wry.69.2022.01.27.04.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 04:42:03 -0800 (PST)
Message-ID: <7b3eaee6-ae9b-5159-3cd8-5b38e7890229@redhat.com>
Date:   Thu, 27 Jan 2022 13:42:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/6] mm, memory_hotplug: drop arch_free_nodedata
Content-Language: en-US
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Rafael Aquini <raquini@redhat.com>,
        Michal Hocko <mhocko@suse.com>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-4-mhocko@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220127085305.20890-4-mhocko@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.01.22 09:53, Michal Hocko wrote:
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

As mentioned, maybe we want to rip out rollback_node_hotadd() in the
previous patch.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

