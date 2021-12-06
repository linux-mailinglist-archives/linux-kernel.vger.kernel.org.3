Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70195469172
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 09:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239288AbhLFIcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 03:32:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57280 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239226AbhLFIcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 03:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638779362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PzjUxYr2pMPTgEwgEgRbdKx0md6uaThlYOXKtVmfNzg=;
        b=HDMek3OCEusT8VvUrKUmzUS291M7hhmJV5p4hTq0qVGqri/StFa95eTpCeR5/n7rZ5slVK
        ZCVbcKt8aqEe/8Xxj36CKCW9w5gc0AXO/xBrPimSuRlkk3TOMVTd6CDoML+kvXUU4rLsVy
        o9V2GLMtsvXy6fk7r8PH10+rXN4B/Is=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-T4NaINr7N1GthyVU8-DRqg-1; Mon, 06 Dec 2021 03:29:20 -0500
X-MC-Unique: T4NaINr7N1GthyVU8-DRqg-1
Received: by mail-wm1-f71.google.com with SMTP id k25-20020a05600c1c9900b00332f798ba1dso7517943wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 00:29:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=PzjUxYr2pMPTgEwgEgRbdKx0md6uaThlYOXKtVmfNzg=;
        b=8Oo8Yfidyqh+N1oP5u6bZe0HQMawE4nxVOEiPHP2M1hpT33N/8ZYQIr+JDrClJx1Ht
         YUGNTtb82RoE1SjG3/EGHJSpZ9rcVmumQ1N1yQzzAFpqFT4wOwfzCRy5pJJDxVKq3a4G
         vtq/+VmY1HYwXQIS3h63YmPUrAKPMrTijRq8A1ireGKggH6dXPM1pYCmKvwzbMq07L0S
         EUrjXXgjxJl1h9OEC1mPB9h+Oci28RQpKVphEA+fIjtY/Kai2EpSyEI4ZM1HjvLLL2pF
         4hiy/vwfaWN3R+HEZrK2ZyDEctX3179A56PJr+KPQGklAFxHqhBO999Ue9zr3Smesg28
         9wFQ==
X-Gm-Message-State: AOAM5310Eizo3+Cxm4p18S3oQHiUZBczCygxfmosBmaSONaNV0iblklG
        W/jszMC4TqhORpjB2cD1+vMMNyYe503qHv9HGmXiwRcpw01tImehvZUnS3MGhKajgZnyfrD/3Cb
        Qdbig3AKdgwH0F9zDcuYNgtyD
X-Received: by 2002:a05:6000:1c2:: with SMTP id t2mr40152529wrx.378.1638779359511;
        Mon, 06 Dec 2021 00:29:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzaJbhp0QLANNU/lW0WnVH+1Q6Rd6Pb0aOt6vWWFmwMiYB9djope6/sd4Ay9LnH0OnT4ROQYw==
X-Received: by 2002:a05:6000:1c2:: with SMTP id t2mr40152513wrx.378.1638779359365;
        Mon, 06 Dec 2021 00:29:19 -0800 (PST)
Received: from [192.168.3.132] (p5b0c62c6.dip0.t-ipconnect.de. [91.12.98.198])
        by smtp.gmail.com with ESMTPSA id r17sm14169031wmq.5.2021.12.06.00.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 00:29:18 -0800 (PST)
Message-ID: <b7fe32e3-ed06-3701-9ec4-f8f8b838bc9a@redhat.com>
Date:   Mon, 6 Dec 2021 09:29:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        Michal Hocko <mhocko@kernel.org>
Cc:     shakeelb@google.com, ktkhai@virtuozzo.com, shy828301@gmail.com,
        guro@fb.com, vbabka@suse.cz, vdavydov.dev@gmail.com,
        raquini@redhat.com, Rafael Aquini <aquini@redhat.com>
References: <20211206033338.743270-1-npache@redhat.com>
 <20211206033338.743270-2-npache@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 1/2] include/linux/gfp.h: Do not allocate pages on a
 offlined node
In-Reply-To: <20211206033338.743270-2-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.12.21 04:33, Nico Pache wrote:
> We shouldn't allocate pages on a unavailable node. Add a check for this
> in __alloc_pages_node and return NULL to avoid issues further down the
> callchain.
> 
> Also update the VM_WARN_ON in __alloc_pages_node which could skip this
> warn if the gfp_mask is not GFP_THISNODE.
> 
> Co-developed-by: Rafael Aquini <aquini@redhat.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  include/linux/gfp.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index b976c4177299..e7e18f6d0d9d 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -565,7 +565,10 @@ static inline struct page *
>  __alloc_pages_node(int nid, gfp_t gfp_mask, unsigned int order)
>  {
>  	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
> -	VM_WARN_ON((gfp_mask & __GFP_THISNODE) && !node_online(nid));
> +	VM_WARN_ON(!node_online(nid));
> +
> +	if (!node_online(nid))
> +		return NULL;
>  
>  	return __alloc_pages(gfp_mask, order, nid, NULL);
>  }
> 

We had a related discussion just a month ago or so, and callers should
make sure to not allocate pages on an offline node. No need for runtime
checks for each end every allocation. The question is usually, where do
callers get the random offline node from. See:

https://lkml.kernel.org/r/20211108202325.20304-1-amakhalov@vmware.com

There was also a discussion about turning this at least into
VM_WARN_ON(!node_online(nid)), however, there are valid points that this
won't really help much. We'd need a BUG_ON, but we'll already crash
properly later when de-referencing the NULL pgdat pointer.

-- 
Thanks,

David / dhildenb

