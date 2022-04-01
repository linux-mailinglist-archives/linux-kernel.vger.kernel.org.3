Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1F34EEB51
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 12:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343692AbiDAKbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 06:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbiDAKbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 06:31:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34FA04C793
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 03:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648808957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QnkWLPWaubJDCgjkk+KSAWH5tkw5z8xC00A/EFIIYy0=;
        b=Amn9Inm+m5gA20b/ge+ubQImoXBIXNT3KfngFcYLZkGy86gQNYQEUVS9mJwpvY7s2OUcEw
        6K0qLM2gqzL+X+hnhg9Y31GF7wwpRYvKhuYfuL6nAGWyZ/RkczR3cMpWZYIBiFLAKFu8oP
        bqCKulTiEU+cZnVwNXc6pgZkKS9Cwc0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-278-T1cAxpLfM8CvIqRofx6soQ-1; Fri, 01 Apr 2022 06:29:16 -0400
X-MC-Unique: T1cAxpLfM8CvIqRofx6soQ-1
Received: by mail-wr1-f71.google.com with SMTP id p16-20020adfc390000000b00204006989c2so514439wrf.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 03:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=QnkWLPWaubJDCgjkk+KSAWH5tkw5z8xC00A/EFIIYy0=;
        b=C699usoSTiwsa8a2jMHVxcCiSRFC5EprLt2VhLcCQYMiZY2FqeG6uMjoayATb2j+F0
         f0WrC8uQpTLDCyCKag8pEhj4GCKTrOxWpAleKAxAW2XoRf5+y+H1txLmWg55OthhCALS
         RwnnoFAmgRpIXde2VYgPADm98ujLNbDiO8gSxQ008GfnRa34dFJc73uRTYl1uekY8LSS
         ietsCM8k4Z2GwCQbaLuVy1qDx0BKLKNxMf1Ui4ouXcTq1M+lrjKSBS43ID99P/R06Bvi
         ZRT3CMEU0FcZAFdzwRJoO7p6ugzaU1W6YXSs3tVS3OKr2c5MnMF/cA1/RM2foKxpyuqF
         Jzig==
X-Gm-Message-State: AOAM531aYJf8buGIFnB+Az8zfT/P4nNLxX4poLqn3gPH/4ruuCONNoNH
        GzwaavzPLTMeIRPCpLd8Cjd1NBp3+c6falDKhcafl1CWCSf0nGPQpbP6NjxVQy3/GKreWq2FYlX
        LeVwzZzpha9H45FxpM7GiOgfA
X-Received: by 2002:a7b:c5cd:0:b0:38c:8b1b:d220 with SMTP id n13-20020a7bc5cd000000b0038c8b1bd220mr8037000wmk.118.1648808955143;
        Fri, 01 Apr 2022 03:29:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9ybJOrHbcXO9wX82TpTOQTaJOg6nrZTNTh6CO46+uv792qqm/WZuH6WSFX5+Yz4BYlJk/7A==
X-Received: by 2002:a7b:c5cd:0:b0:38c:8b1b:d220 with SMTP id n13-20020a7bc5cd000000b0038c8b1bd220mr8036979wmk.118.1648808954900;
        Fri, 01 Apr 2022 03:29:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:9e00:229d:4a10:2574:c6fa? (p200300cbc7069e00229d4a102574c6fa.dip0.t-ipconnect.de. [2003:cb:c706:9e00:229d:4a10:2574:c6fa])
        by smtp.gmail.com with ESMTPSA id 14-20020adf828e000000b00205b0fc825csm1749308wrc.65.2022.04.01.03.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 03:29:14 -0700 (PDT)
Message-ID: <2981c978-2e00-5e6a-a9c5-4c82f184430d@redhat.com>
Date:   Fri, 1 Apr 2022 12:29:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] mm/slab: remove some unused functions
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz
Cc:     roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220322091421.25285-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220322091421.25285-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.03.22 10:14, Miaohe Lin wrote:
> alternate_node_alloc and ____cache_alloc_node are always called when
> CONFIG_NUMA. So we can remove the unused !CONFIG_NUMA variant. Also
> forward declaration for alternate_node_alloc is unnecessary. Remove
> it too.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/slab.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index d9dec7a8fd79..81301df47057 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -619,18 +619,6 @@ static inline int cache_free_alien(struct kmem_cache *cachep, void *objp)
>  	return 0;
>  }
>  
> -static inline void *alternate_node_alloc(struct kmem_cache *cachep,
> -		gfp_t flags)
> -{
> -	return NULL;
> -}
> -
> -static inline void *____cache_alloc_node(struct kmem_cache *cachep,
> -		 gfp_t flags, int nodeid)
> -{
> -	return NULL;
> -}
> -
>  static inline gfp_t gfp_exact_node(gfp_t flags)
>  {
>  	return flags & ~__GFP_NOFAIL;
> @@ -639,7 +627,6 @@ static inline gfp_t gfp_exact_node(gfp_t flags)
>  #else	/* CONFIG_NUMA */
>  
>  static void *____cache_alloc_node(struct kmem_cache *, gfp_t, int);
> -static void *alternate_node_alloc(struct kmem_cache *, gfp_t);
>  
>  static struct alien_cache *__alloc_alien_cache(int node, int entries,
>  						int batch, gfp_t gfp)

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

