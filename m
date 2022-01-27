Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDA749E2D5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241325AbiA0Mrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:47:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21281 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229689AbiA0Mra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:47:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643287649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dZnBBzh5J+R5PC7IW0A4Y3unxsbPS6AlQheb1fFM5X4=;
        b=gYSQS0HquqK5tARtXjMm0KMwD/J0Y6O0/HLYj3nZSZ6ICu7U0K8BO77Lm4fR6dDtb2lSfE
        wi4jnFB3gKXQ2OhtN3cyj3PrHH0o8eOWisY4p+YkXaw74fVqcCLcfUrK4Vlivbj4IXDkfJ
        tw5Le1n3KPoEfFX3ztA6+hFQ31gaTe0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-ebLl71ubO6Kok2SN88ybgA-1; Thu, 27 Jan 2022 07:47:28 -0500
X-MC-Unique: ebLl71ubO6Kok2SN88ybgA-1
Received: by mail-ej1-f72.google.com with SMTP id l18-20020a1709063d3200b006a93f7d4941so1302878ejf.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 04:47:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=dZnBBzh5J+R5PC7IW0A4Y3unxsbPS6AlQheb1fFM5X4=;
        b=BAx4lgAIf0VyxovrQ0Qo89IB2w0lcbbKcwd6eGAJM6IOZdLQWAIfa56uhK5KDxSnKU
         fp/i+kKMPt/OdQJupMFg+HaiQEgYQIiA9Xw9geb1uBlgwaGw6SshkJWDldvBoXPAHPcQ
         BFhkxfsuL/g1EqeaMz7Y+4HEEANMyWljIf3UOqDPpR9QawT6Cka6AuZ5LBFSlNrFmBz7
         TJMb9P9V0HViO+JH6WYdJiMdkLt/f14wgUxVAf46NDWr8eiuLignBYlDJ012JDdHMhF5
         u9gA16brvPB2I7oCwHJ1v4BLhzgDAAsL/wpJWgnULQxQs885/7JXSFbbeRQF8pUGQoWj
         TjZg==
X-Gm-Message-State: AOAM530b4zxXEFaGQL5kdXA2JtOgX0kZaR9i8ZDUSnBU7DCxVlIfN1zn
        Nfeu5lCNEtkaYjL/5VpYqUAg9/CnIbd+Fg6m5vep9wz/oQOjrI2ruQPg+VmzhGvJQfNIKW8TDuG
        fb4sdBcjqc79RdbIPLFLLCFZy
X-Received: by 2002:a05:6402:2690:: with SMTP id w16mr3350694edd.391.1643287646946;
        Thu, 27 Jan 2022 04:47:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz/KvoZH/SCNj+ZCxiXafUlBmjau+ROr+Sj3No415Ti56OXF65t8bPFAFw7LD5MM2w8HPfBKg==
X-Received: by 2002:a05:6402:2690:: with SMTP id w16mr3350674edd.391.1643287646697;
        Thu, 27 Jan 2022 04:47:26 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:8300:4812:9d4f:6cd8:7f47? (p200300cbc70d830048129d4f6cd87f47.dip0.t-ipconnect.de. [2003:cb:c70d:8300:4812:9d4f:6cd8:7f47])
        by smtp.gmail.com with ESMTPSA id p11sm11384498eds.38.2022.01.27.04.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 04:47:25 -0800 (PST)
Message-ID: <469b0996-8c2b-a8e1-4c37-f6e60a50ed1e@redhat.com>
Date:   Thu, 27 Jan 2022 13:47:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 5/6] mm: make free_area_init_node aware of memory less
 nodes
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
 <20220127085305.20890-6-mhocko@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220127085305.20890-6-mhocko@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.01.22 09:53, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> free_area_init_node is also called from memory less node initialization
> path (free_area_init_memoryless_node). It doesn't really make much sense
> to display the physical memory range for those nodes:
> Initmem setup node XX [mem 0x0000000000000000-0x0000000000000000]
> 
> Instead be explicit that the node is memoryless:
> Initmem setup node XX as memoryless
> 
> Acked-by: Rafael Aquini <raquini@redhat.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/page_alloc.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 32d0189de4c5..83da2279be72 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7682,9 +7682,14 @@ static void __init free_area_init_node(int nid)
>  	pgdat->node_start_pfn = start_pfn;
>  	pgdat->per_cpu_nodestats = NULL;
>  
> -	pr_info("Initmem setup node %d [mem %#018Lx-%#018Lx]\n", nid,
> -		(u64)start_pfn << PAGE_SHIFT,
> -		end_pfn ? ((u64)end_pfn << PAGE_SHIFT) - 1 : 0);
> +	if (start_pfn != end_pfn) {
> +		pr_info("Initmem setup node %d [mem %#018Lx-%#018Lx]\n", nid,
> +			(u64)start_pfn << PAGE_SHIFT,
> +			end_pfn ? ((u64)end_pfn << PAGE_SHIFT) - 1 : 0);
> +	} else {
> +		pr_info("Initmem setup node %d as memoryless\n", nid);
> +	}
> +
>  	calculate_node_totalpages(pgdat, start_pfn, end_pfn);
>  
>  	alloc_node_mem_map(pgdat);

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

