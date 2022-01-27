Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A3549E2DA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241350AbiA0Muj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:50:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36788 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229689AbiA0Mui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:50:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643287837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N4n2fN70c2o+w/iLcI21Ax2ko496ej/NQO3wKSvR4ZI=;
        b=RyCscwUaurpnN/wS+mfte9alwti2pZL2u5DhKnC/xkJWMAwFKDlDmJs774CjGGOHOw8w85
        eEXiQjagYPPYByp6ATq+h/xhCsZd78Vdkim0IeqFJ4q5SxrxzH0mUK4Tu/GOIBa56k8cd0
        +X7yQGJBDuh5O37dqkcraVxx4PFESWU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-eiPm3vvKNQm1hw48MEy2lQ-1; Thu, 27 Jan 2022 07:50:36 -0500
X-MC-Unique: eiPm3vvKNQm1hw48MEy2lQ-1
Received: by mail-wr1-f71.google.com with SMTP id s25-20020adfa299000000b001d8d032255fso1027380wra.14
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 04:50:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=N4n2fN70c2o+w/iLcI21Ax2ko496ej/NQO3wKSvR4ZI=;
        b=Y6gZcao/eHYIOrHLYeyU9o7E+zhz7i46MOnqRsTGC1Rtbmv4FLY6ZNrFSG4Zi4lHyW
         m/pcsVta2AAlK/2JeulgE74MPnYS45J6g/4NLEj5ELDQ3B0Y8RF6YpCSXYTgaHrldkdt
         Y4mMl5iXvFuNLNFGu48qilO2MSKqKXNtTc5BVRQPobxfdkIN4sX5aYrbc66yDouubAw2
         gebYWAMe8KnAKwySj7UKIAnLt/NDXp2r1WDd0A2SLN7OzrQaxKZ2G5/3iSUnTNo3YwfG
         Hz5Le2ijwQ8KBcHd/iOwslwQIvEfGVNSQfbukIL48KYB+DobCocS1KiSm1i4GPc41B8Q
         xGXw==
X-Gm-Message-State: AOAM531K/24xPZW7c6+uNP6WUNk6gYv8Ov1U8T/D11/N55CIR3AK/xFH
        8DEOIJX9c0Nljfxp4Rrj+5zSfgAlymqKzQ5vpipAOo7zvCgWE+8sGzwN9+QKpbj6LoiDxIYhltK
        gGS4VB7BFS7HjmK3WH8yfarkI
X-Received: by 2002:a05:600c:40b:: with SMTP id q11mr11452759wmb.43.1643287835156;
        Thu, 27 Jan 2022 04:50:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyvEqG4sn9O9VkUMDlKL4v2sNRnP1uIUhjD+T7OfJkd/BnNRup3Dkx6tYN+Zd6MBIkEdiQ4iA==
X-Received: by 2002:a05:600c:40b:: with SMTP id q11mr11452739wmb.43.1643287834948;
        Thu, 27 Jan 2022 04:50:34 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:8300:4812:9d4f:6cd8:7f47? (p200300cbc70d830048129d4f6cd87f47.dip0.t-ipconnect.de. [2003:cb:c70d:8300:4812:9d4f:6cd8:7f47])
        by smtp.gmail.com with ESMTPSA id k12sm2208835wrd.110.2022.01.27.04.50.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 04:50:34 -0800 (PST)
Message-ID: <634987e7-27c0-bca5-30cd-de7a5ede30cd@redhat.com>
Date:   Thu, 27 Jan 2022 13:50:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 6/6] memcg: do not tweak node in
 alloc_mem_cgroup_per_node_info
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
 <20220127085305.20890-7-mhocko@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220127085305.20890-7-mhocko@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.01.22 09:53, Michal Hocko wrote:
> From: Wei Yang <richard.weiyang@gmail.com>
> 
> alloc_mem_cgroup_per_node_info is allocated for each possible node and
> this used to be a problem because not !node_online nodes didn't have
> appropriate data structure allocated. This has changed by "mm: handle
> uninitialized numa nodes gracefully" so we can drop the special casing
> here.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/memcontrol.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 09d342c7cbd0..8b3f9eef4c65 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5067,18 +5067,8 @@ struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
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

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

