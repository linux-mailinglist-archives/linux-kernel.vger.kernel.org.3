Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C4D51456C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356583AbiD2JcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239126AbiD2JcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:32:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04158C3EB6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651224544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kC+rdIYX7c86XP7hqAoeoKmiKMXkQmQ2uMl1ygcYcWc=;
        b=Ai0B7We9zkhH9IzQ2Bq/fiYUb7/4DaUyRK2n/8hRNsBpoE3mIIigbvTrrlDaRM5TcEc6ja
        jw2pYvCtqAuuYQIuBxOK33OvBN6KojXANT1jxpayaaKfH/f/xlmnkhimXQGFMyui9Pbu9z
        eYFnkSJAJA/SiivHGpuSlmCCCuAS8WU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-303-FPE4ewEfMUed03OBQ5Shaw-1; Fri, 29 Apr 2022 05:28:54 -0400
X-MC-Unique: FPE4ewEfMUed03OBQ5Shaw-1
Received: by mail-wm1-f71.google.com with SMTP id t2-20020a7bc3c2000000b003528fe59cb9so2262932wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=kC+rdIYX7c86XP7hqAoeoKmiKMXkQmQ2uMl1ygcYcWc=;
        b=FujUfwPJnoDp4frsv5gMoa48pqIvL9CLa1zS35NPnetdwsT0D488Rh83sEVDs7YyYU
         oOxuScQt0+mX0bu/yd8MRrYG72vL2JbpAxbp2QQe7CEaAOye8nc+wBgkiME8mMem7VOi
         rPOm7VYafs4WcsbgEbBEzuotPeUydopyizvvKKzWjHGRryHj1AKKf1C5wSYbRGhRLawq
         SnL1nBYjQgn5uwW3Zgj6vWuiW+oREzKoaAOeLQPz0vR4y2qC4s+buzyhX9IKCtStTdP5
         8ltcz6/Dk/iFU/RVikz2jmqW2Plkj4RcYkpry12piNRC/clGAo5dT4pjZhB+agJsEMkO
         M9Yw==
X-Gm-Message-State: AOAM532yFDPFZlOBfFlE7heTp9MzHsIUahzkEE+kXPqlNA8wAxoHK8wC
        h3bHtmmQSf02jVvLc7pMLpXlyv4MOwOtXnLGtGsB+kwMQckzufTck5aGxEJA9xyORtyZ0QKG39S
        ZjiuClLylrMIMJj5+Qty2Uysp
X-Received: by 2002:adf:e7c1:0:b0:20a:b724:cedd with SMTP id e1-20020adfe7c1000000b0020ab724ceddmr30695048wrn.409.1651224533813;
        Fri, 29 Apr 2022 02:28:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfSVLq6mn3NtyCS59FHRJIwazRa2JwPUJpPbEwBXPToDHs98ejC2T4phMaRy9QqV+8eeKFYg==
X-Received: by 2002:adf:e7c1:0:b0:20a:b724:cedd with SMTP id e1-20020adfe7c1000000b0020ab724ceddmr30695035wrn.409.1651224533583;
        Fri, 29 Apr 2022 02:28:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:fe00:bbeb:98e6:617a:dea1? (p200300cbc707fe00bbeb98e6617adea1.dip0.t-ipconnect.de. [2003:cb:c707:fe00:bbeb:98e6:617a:dea1])
        by smtp.gmail.com with ESMTPSA id g25-20020adfa599000000b0020aeb9e5bdfsm2054937wrc.43.2022.04.29.02.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 02:28:53 -0700 (PDT)
Message-ID: <d2ab442f-99a3-fb09-00f4-8c5897cf1ccf@redhat.com>
Date:   Fri, 29 Apr 2022 11:28:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 4/4] hugetlb: Clean up hugetlb_cma_reserve
Content-Language: en-US
To:     Peng Liu <liupeng256@huawei.com>, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, yaozhenguo1@gmail.com,
        baolin.wang@linux.alibaba.com, songmuchun@bytedance.com,
        liuyuntao10@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220413032915.251254-1-liupeng256@huawei.com>
 <20220413032915.251254-5-liupeng256@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220413032915.251254-5-liupeng256@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.04.22 05:29, Peng Liu wrote:
> Use more generic functions to deal with issues related to online
> nodes. The changes will make the code simplified.
> 
> Signed-off-by: Peng Liu <liupeng256@huawei.com>
> ---
>  mm/hugetlb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 2e4d8d9fb7c6..4c529774cc08 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6953,7 +6953,7 @@ void __init hugetlb_cma_reserve(int order)
>  		if (hugetlb_cma_size_in_node[nid] == 0)
>  			continue;
>  
> -		if (!node_state(nid, N_ONLINE)) {
> +		if (!node_online(nid)) {
>  			pr_warn("hugetlb_cma: invalid node %d specified\n", nid);
>  			hugetlb_cma_size -= hugetlb_cma_size_in_node[nid];
>  			hugetlb_cma_size_in_node[nid] = 0;
> @@ -6992,7 +6992,7 @@ void __init hugetlb_cma_reserve(int order)
>  	}
>  
>  	reserved = 0;
> -	for_each_node_state(nid, N_ONLINE) {
> +	for_each_online_node(nid) {
>  		int res;
>  		char name[CMA_MAX_NAME];
>  

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

