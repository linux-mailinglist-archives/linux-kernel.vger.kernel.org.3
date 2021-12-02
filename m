Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532D6465C50
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 03:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354832AbhLBC5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 21:57:30 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:28141 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241048AbhLBC52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 21:57:28 -0500
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4J4L7J5v4jz1DJlb;
        Thu,  2 Dec 2021 10:51:08 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 2 Dec 2021 10:53:51 +0800
Received: from [10.174.177.232] (10.174.177.232) by
 dggpeml500006.china.huawei.com (7.185.36.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 2 Dec 2021 10:53:50 +0800
Subject: Re: [PATCH -next] mm: delete oversized WARN_ON() in kvmalloc() calls
To:     Bixuan Cui <cuibixuan@linux.alibaba.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>
CC:     <leon@kernel.org>, <akpm@linux-foundation.org>, <w@1wt.eu>,
        <keescook@chromium.org>
References: <1638410784-48646-1-git-send-email-cuibixuan@linux.alibaba.com>
From:   Tang Yizhou <tangyizhou@huawei.com>
Message-ID: <74508663-8c2d-5c83-147f-adad7b71d93b@huawei.com>
Date:   Thu, 2 Dec 2021 10:53:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <1638410784-48646-1-git-send-email-cuibixuan@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.232]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/2 10:06, Bixuan Cui wrote:
> Delete the WARN_ON() and return NULL directly for oversized parameter
> in kvmalloc() calls.
> Also add unlikely().
> 

The commit message should explain why we need to do this. Thanks.

> Fixes: 7661809d493b ("mm: don't allow oversized kvmalloc() calls")
> Signed-off-by: Bixuan Cui <cuibixuan@linux.alibaba.com>
> ---
> There are a lot of oversize warnings and patches about kvmalloc() calls
> recently. Maybe these warnings are not very necessary.
> 
> https://lore.kernel.org/all/YadOjJXMTjP85MQx@unreal
> 
> The example of size check in __do_kmalloc_node():
> __do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
> {
>         struct kmem_cache *cachep;
>         void *ret;
> 
>         if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
>                 return NULL;
>         cachep = kmalloc_slab(size, flags);
> 
>  mm/util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index 7e433690..d26f19c 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -587,7 +587,7 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
>  		return ret;
>  
>  	/* Don't even allow crazy sizes */
> -	if (WARN_ON_ONCE(size > INT_MAX))
> +	if (unlikely(size > INT_MAX))
>  		return NULL;
>  
>  	return __vmalloc_node(size, 1, flags, node,
> 

Tang
