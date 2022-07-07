Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FAA56ABA1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236600AbiGGTOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236503AbiGGTOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:14:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BB612CDC2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 12:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657221242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ibEuIdfe6ue903/8NMATm2DmyfZepietq2qxST3Mwc=;
        b=J0QIvueLZO+DfapJDLIt/hNnAiTrnGylFBUFPo3Ol17BT+q8qoLvMW8S1I/QtHqJhiZkBE
        xhhsP9nCRNDwwxK1Vo2Wc5qwUCuEO48QuBpkJwDserQqfim3+8qdtv/cNxx1iAiDpSjOVV
        c2JU5iuIkGqFvgPIavdwrjMgsm/R3QY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-204-W9ZvZhmdPryWTebivYbRrg-1; Thu, 07 Jul 2022 15:13:58 -0400
X-MC-Unique: W9ZvZhmdPryWTebivYbRrg-1
Received: by mail-lf1-f72.google.com with SMTP id y19-20020a056512045300b004890b28f7c8so622580lfk.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 12:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent:cc
         :subject:content-language:to:references:in-reply-to
         :content-transfer-encoding;
        bh=6ibEuIdfe6ue903/8NMATm2DmyfZepietq2qxST3Mwc=;
        b=HdGCZMuRvVyMWGrGMjdeT/jKqIAt5oyTKMf9erEs7wVD1PphMdI1tx5UzImbobncjA
         VKVUcDIu0rKR1SOx2gtZB7KGfxrL+wu/FzzvBc6HBle48d6y6D/5ytZh28ncTttoDP3M
         sm/gAcvMNWdzabZux5/5n/u9HNAKE04KXDYOJc0OFSSHhmnkulMVa6vmYFFGYHMB6OEX
         sWYp3Ii+3ieeutsUPChNoqSCQ4n2vqr1hKRwXoMtwswkzzGvH8EQ2lPzpZ5AmAEZFXRe
         ZNaXkcDYTy8tEZAg8qGYC4VP5gCJNNV4DlJALbybi4MdfoxG7KdKQHkGwo4hb69W18R5
         UINw==
X-Gm-Message-State: AJIora+tMwdry88/MtJsWv2O07+Oj+IlzQarMSj9/VB6t+hdwesACIk3
        1otGBmLT/sz8l4VT57G5YGdgQX8a4PHFMNdsg6RKUt0drV4ifj89CAfU+fJj4YH1cqBqeNL/FgE
        6p+YlDN0YrxHfQKp2gK3nygIu
X-Received: by 2002:a05:6512:ba3:b0:47f:74e1:e3c4 with SMTP id b35-20020a0565120ba300b0047f74e1e3c4mr31272882lfv.585.1657221236354;
        Thu, 07 Jul 2022 12:13:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tXVcEwC0dqwY9XyyPgHLHPbPN5gpfpDsqrx7OVCmY4TFR7C+gnmJSN9PJuaU0cio2AXk6P0w==
X-Received: by 2002:a05:6512:ba3:b0:47f:74e1:e3c4 with SMTP id b35-20020a0565120ba300b0047f74e1e3c4mr31272867lfv.585.1657221236094;
        Thu, 07 Jul 2022 12:13:56 -0700 (PDT)
Received: from [192.168.0.50] (87-59-106-155-cable.dk.customer.tdc.net. [87.59.106.155])
        by smtp.gmail.com with ESMTPSA id s7-20020a056512314700b0047fbc399ad2sm304186lfi.245.2022.07.07.12.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 12:13:55 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <670cb075-a2a5-2e18-c4e4-2e71e5c5e456@redhat.com>
Date:   Thu, 7 Jul 2022 21:13:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Cc:     brouer@redhat.com, lorenzo@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        lipeng321@huawei.com, chenhao288@hisilicon.com
Subject: Re: [PATCH net-next v3] net: page_pool: optimize page pool page
 allocation in NUMA scenario
Content-Language: en-US
To:     Guangbin Huang <huangguangbin2@huawei.com>, jbrouer@redhat.com,
        hawk@kernel.org, ilias.apalodimas@linaro.org, davem@davemloft.net,
        kuba@kernel.org, edumazet@google.com, pabeni@redhat.com
References: <20220705113515.54342-1-huangguangbin2@huawei.com>
In-Reply-To: <20220705113515.54342-1-huangguangbin2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/07/2022 13.35, Guangbin Huang wrote:
> From: Jie Wang <wangjie125@huawei.com>
> 
> Currently NIC packet receiving performance based on page pool deteriorates
> occasionally. To analysis the causes of this problem page allocation stats
> are collected. Here are the stats when NIC rx performance deteriorates:
> 
> bandwidth(Gbits/s)		16.8		6.91
> rx_pp_alloc_fast		13794308	21141869
> rx_pp_alloc_slow		108625		166481
> rx_pp_alloc_slow_h		0		0
> rx_pp_alloc_empty		8192		8192
> rx_pp_alloc_refill		0		0
> rx_pp_alloc_waive		100433		158289
> rx_pp_recycle_cached		0		0
> rx_pp_recycle_cache_full	0		0
> rx_pp_recycle_ring		362400		420281
> rx_pp_recycle_ring_full		6064893		9709724
> rx_pp_recycle_released_ref	0		0
> 
> The rx_pp_alloc_waive count indicates that a large number of pages' numa
> node are inconsistent with the NIC device numa node. Therefore these pages
> can't be reused by the page pool. As a result, many new pages would be
> allocated by __page_pool_alloc_pages_slow which is time consuming. This
> causes the NIC rx performance fluctuations.
> 
> The main reason of huge numa mismatch pages in page pool is that page pool
> uses alloc_pages_bulk_array to allocate original pages. This function is
> not suitable for page allocation in NUMA scenario. So this patch uses
> alloc_pages_bulk_array_node which has a NUMA id input parameter to ensure
> the NUMA consistent between NIC device and allocated pages.
> 
> Repeated NIC rx performance tests are performed 40 times. NIC rx bandwidth
> is higher and more stable compared to the datas above. Here are three test
> stats, the rx_pp_alloc_waive count is zero and rx_pp_alloc_slow which
> indicates pages allocated from slow patch is relatively low.
> 
> bandwidth(Gbits/s)		93		93.9		93.8
> rx_pp_alloc_fast		60066264	61266386	60938254
> rx_pp_alloc_slow		16512		16517		16539
> rx_pp_alloc_slow_ho		0		0		0
> rx_pp_alloc_empty		16512		16517		16539
> rx_pp_alloc_refill		473841		481910		481585
> rx_pp_alloc_waive		0		0		0
> rx_pp_recycle_cached		0		0		0
> rx_pp_recycle_cache_full	0		0		0
> rx_pp_recycle_ring		29754145	30358243	30194023
> rx_pp_recycle_ring_full		0		0		0
> rx_pp_recycle_released_ref	0		0		0
> 
> Signed-off-by: Jie Wang <wangjie125@huawei.com>

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

> ---
> v2->v3:
> 1, Delete the #ifdefs
> 2, Use 'pool->p.nid' in the call to alloc_pages_bulk_array_node()
> 
> v1->v2:
> 1, Remove two inappropriate comments.
> 2, Use NUMA_NO_NODE instead of numa_mem_id() for code maintenance.
> ---
>   net/core/page_pool.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index f18e6e771993..b74905fcc3a1 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -389,7 +389,8 @@ static struct page *__page_pool_alloc_pages_slow(struct page_pool *pool,
>   	/* Mark empty alloc.cache slots "empty" for alloc_pages_bulk_array */
>   	memset(&pool->alloc.cache, 0, sizeof(void *) * bulk);
>   
> -	nr_pages = alloc_pages_bulk_array(gfp, bulk, pool->alloc.cache);
> +	nr_pages = alloc_pages_bulk_array_node(gfp, pool->p.nid, bulk,
> +					       pool->alloc.cache);
>   	if (unlikely(!nr_pages))
>   		return NULL;
>   

