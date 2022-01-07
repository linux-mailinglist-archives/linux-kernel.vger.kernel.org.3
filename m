Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F98948783D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 14:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347583AbiAGNcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 08:32:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33603 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347576AbiAGNcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 08:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641562335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cFxA12PHF5x2snjaqknP/Xo7sJEChO7mQ3FWdzGbJfc=;
        b=W064crogQUwrQ5+zNHrqsmR4SO/aMxUP3Oba8eEgYEjdrRXJ1gv46b2RJw55Q4VW8b1qWd
        dMz8DNJkhtnz6icLU+WoTOxf405cuCEzqwZ+P1B8tb/iu3etqQjDd766MygECf4yR1iomD
        CZORRgOKzwdzTd1BX53QitzML5UzHqc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-28x2H94iNE-N2Snd8rPgXQ-1; Fri, 07 Jan 2022 08:32:13 -0500
X-MC-Unique: 28x2H94iNE-N2Snd8rPgXQ-1
Received: by mail-wm1-f71.google.com with SMTP id s190-20020a1ca9c7000000b00347c6c39d9aso512829wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 05:32:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent:cc
         :subject:content-language:to:references:in-reply-to
         :content-transfer-encoding;
        bh=cFxA12PHF5x2snjaqknP/Xo7sJEChO7mQ3FWdzGbJfc=;
        b=RZiG1hVzuFtcpsT+7n291Yij2OmtzW90SBCZeZR5SxB4IEh41gNdqv5IoGzskoE1QW
         gLciWsb3OXPw5et4qOLeIftnYehCKUN3gGRFuawla4ASRK16hqBeEZSQL3Jw399qqKmE
         YHOLOFRLazgDTIKNIq+vMGCLyGR8KBAoI62b3zuQ/IyPkXTsoB4nQtO9YKeLcTdvxYty
         6cQLRhMrgBhRiIl7kMlvLH7zCbpXC3b+3DKr4sAipd/pFgEWEnfc+WMIljwgy7fR6CbC
         Oh+x6XgQbnYH3zFb2l6+W2ECUBEqFgQx1bYuaL8hOlqSJyxd+3Tmf+EBU4DKT29Myvkb
         Emow==
X-Gm-Message-State: AOAM531RaU9YTOlF1gcDsyUwHmZ7ByZC1JJWU2oGEEfVi4qxqbCROIZo
        bjkJ8tFyvCCjtLe8G5fzR/+a2ryTh8CeaG5TQsd6LsE3DjS5iP/QT3HoKS3FSv3n7c1MIO0FmX+
        vIp2ZTlhVO8CKQJ5L3gliyEnL
X-Received: by 2002:a1c:6a13:: with SMTP id f19mr10216385wmc.13.1641562332705;
        Fri, 07 Jan 2022 05:32:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyftZXAOc3XjSdwFOB0wtyxXs5TYDRf8z1gme7WWUEWB4FfE05bcdM3IruZ8l9IzQVuhX/J9A==
X-Received: by 2002:a1c:6a13:: with SMTP id f19mr10216376wmc.13.1641562332491;
        Fri, 07 Jan 2022 05:32:12 -0800 (PST)
Received: from [192.168.2.20] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id o11sm8663447wmq.15.2022.01.07.05.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 05:32:11 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <3b7780d5-8f0b-0388-37e2-51ee8b282ab0@redhat.com>
Date:   Fri, 7 Jan 2022 14:32:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Cc:     brouer@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hawk@kernel.org,
        ilias.apalodimas@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH net-next] page_pool: remove spinlock in
 page_pool_refill_alloc_cache()
Content-Language: en-US
To:     Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        kuba@kernel.org
References: <20220107090042.13605-1-linyunsheng@huawei.com>
In-Reply-To: <20220107090042.13605-1-linyunsheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/01/2022 10.00, Yunsheng Lin wrote:
> As page_pool_refill_alloc_cache() is only called by
> __page_pool_get_cached(), which assumes non-concurrent access
> as suggested by the comment in __page_pool_get_cached(), and
> ptr_ring allows concurrent access between consumer and producer,
> so remove the spinlock in page_pool_refill_alloc_cache().

This should be okay as __ptr_ring_consume() have a memory barrier via 
READ_ONCE in __ptr_ring_peek(). The code page_pool_empty_ring() also 
does ptr_ring consume, but drivers should already take care that this 
will not be called concurrently, as it is part of the teardown code path 
(which can only run concurrently with ptr_ring producer side).

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

The original reason behind this lock was that I was planning to allow 
the memory subsystem to reclaim pages sitting in page_pool's cache.
Unfortunately I never got around to implement this.

> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>   net/core/page_pool.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 1a6978427d6c..6efad8b29e9c 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -130,9 +130,6 @@ static struct page *page_pool_refill_alloc_cache(struct page_pool *pool)
>   	pref_nid = numa_mem_id(); /* will be zero like page_to_nid() */
>   #endif
>   
> -	/* Slower-path: Get pages from locked ring queue */
> -	spin_lock(&r->consumer_lock);
> -
>   	/* Refill alloc array, but only if NUMA match */
>   	do {
>   		page = __ptr_ring_consume(r);
> @@ -157,7 +154,6 @@ static struct page *page_pool_refill_alloc_cache(struct page_pool *pool)
>   	if (likely(pool->alloc.count > 0))
>   		page = pool->alloc.cache[--pool->alloc.count];
>   
> -	spin_unlock(&r->consumer_lock);
>   	return page;
>   }
>   
> 

