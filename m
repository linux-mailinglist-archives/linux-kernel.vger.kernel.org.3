Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D5349DE8A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbiA0Jzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:55:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60502 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232315AbiA0JzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:55:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643277325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ayJC/AZO9vzgGtnHmUqrAsjgR30wt4COjGg6oQDHxO0=;
        b=aPKLsa7zUMXolsLKrmUt3tzDuQkXlZvF1cFA4TD1w7mCFu/ddzGMoZpSJ42+IzBy2AYO6u
        uWwFs6Ej4E0ZNv30fLfFIsm2+yonvRaj0eRvATxED+Dxa9s/maPbHvYaT2TL8VjY6O2zYh
        60vHUq/It8vY1Bhnt6HUqpArpa27REg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-ezjar76PMAiIy1sw3wnrjw-1; Thu, 27 Jan 2022 04:55:22 -0500
X-MC-Unique: ezjar76PMAiIy1sw3wnrjw-1
Received: by mail-wm1-f69.google.com with SMTP id bg32-20020a05600c3ca000b00349f2aca1beso1237337wmb.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 01:55:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ayJC/AZO9vzgGtnHmUqrAsjgR30wt4COjGg6oQDHxO0=;
        b=fKoJ5zSWTigN9AQAALgVGnqJV4C07sVT+n9f8wOPseWze7NhRGY+8nK0AkSQv8VXlW
         U60T49UhFXh2fUJfRW1JcMbcPJRqumZ6wcpxAzym3Sh0BY6Jw1tdpzDlUAGtZmhv4KJg
         E7Hv75BnZL4dwV5i0sIAP8SPhrgv8iI9GYa89QLAsTNRcXXWo/eKwqXYVr25lxSU7k7u
         mctANaZWr7J+0lXHhkp39qufaDIdUeVtnt1eM+7UJSkw6gIAwjLDcNkMxqkWGKk6McdP
         5eJZCuRWZkBsCZc8K1VyisEuFkliaGbX9s5A19a4pKtZOTxIeBLHTAfk72gNHEqVI2RA
         pp3w==
X-Gm-Message-State: AOAM5317rvmyTExypnj/P45ppcK20mrnWmTDMKTYWR7osIvAIM5IG5Qk
        JceXapfqKXP9eH1AuinFSyGn1A8RsEWtVvebvled0DYP3f+xPzpzv9Ejobk4RaxniagyzYGJECd
        tmZguGOf7kLFEq7lo50coJ7Vm
X-Received: by 2002:adf:fd4e:: with SMTP id h14mr2208994wrs.675.1643277321621;
        Thu, 27 Jan 2022 01:55:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxZjm99+TehRbfRz6MCxIEwSAqNIX73JIx0nKVcQ4IDxr+ai0NNDfqWzRX2Azp20cMyui99Gw==
X-Received: by 2002:adf:fd4e:: with SMTP id h14mr2208981wrs.675.1643277321380;
        Thu, 27 Jan 2022 01:55:21 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:8300:4812:9d4f:6cd8:7f47? (p200300cbc70d830048129d4f6cd87f47.dip0.t-ipconnect.de. [2003:cb:c70d:8300:4812:9d4f:6cd8:7f47])
        by smtp.gmail.com with ESMTPSA id e13sm1980242wrq.35.2022.01.27.01.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 01:55:20 -0800 (PST)
Message-ID: <f65493d9-e46f-af9f-1895-1f5b546bb5ed@redhat.com>
Date:   Thu, 27 Jan 2022 10:55:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] mm/mmzone.h: remove unused macros
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220127093210.62293-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220127093210.62293-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.01.22 10:32, Miaohe Lin wrote:
> Remove pgdat_page_nr, nid_page_nr and NODE_MEM_MAP. They are unused now.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  include/linux/mmzone.h | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index aed44e9b5d89..6c004256d943 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -920,12 +920,6 @@ typedef struct pglist_data {
>  
>  #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
>  #define node_spanned_pages(nid)	(NODE_DATA(nid)->node_spanned_pages)
> -#ifdef CONFIG_FLATMEM
> -#define pgdat_page_nr(pgdat, pagenr)	((pgdat)->node_mem_map + (pagenr))
> -#else
> -#define pgdat_page_nr(pgdat, pagenr)	pfn_to_page((pgdat)->node_start_pfn + (pagenr))
> -#endif
> -#define nid_page_nr(nid, pagenr) 	pgdat_page_nr(NODE_DATA(nid),(pagenr))
>  
>  #define node_start_pfn(nid)	(NODE_DATA(nid)->node_start_pfn)
>  #define node_end_pfn(nid) pgdat_end_pfn(NODE_DATA(nid))
> @@ -1101,7 +1095,6 @@ static inline struct pglist_data *NODE_DATA(int nid)
>  {
>  	return &contig_page_data;
>  }
> -#define NODE_MEM_MAP(nid)	mem_map
>  
>  #else /* CONFIG_NUMA */
>  

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

