Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9A853910C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 14:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344346AbiEaMs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 08:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiEaMs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 08:48:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18B036211B
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 05:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654001304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EPrMSZovc8VHOvaBgoFEXFty7pLwDi2QHtnXl6KmPkE=;
        b=bZf+nRMMGBY1Oqb+wquP7UPSoGz5Q85OyOyRYzab73Q8MvhL857aKmnbqlXhGLpoY47kUb
        Hv6aQuDhDVnCMM6w0YOzqOWT1RtqV6HpyfMFzA6k4pDC1d+fEKrkpkEUIldKvj6eS8MZeg
        YIpnJ4W7iHaUOUYp+YiZOzSY+Qdkd/g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-IOf0MmWVNsSQIpFQSh3KaQ-1; Tue, 31 May 2022 08:48:23 -0400
X-MC-Unique: IOf0MmWVNsSQIpFQSh3KaQ-1
Received: by mail-wr1-f70.google.com with SMTP id s16-20020adfeb10000000b0020cc4e5e683so2029863wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 05:48:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=EPrMSZovc8VHOvaBgoFEXFty7pLwDi2QHtnXl6KmPkE=;
        b=VS4ZNPgOO9rSSX1M7afTsAZMWh/BBwTedKjx9kpEfIYXomKvslEauqC01Bsbjs7IxT
         /5fHYc2AOJan9MOZjjwqajyYs+E6P19e+BX/HOpX7jhJFIksqcY+iU+IXSNdhiLZEO+m
         qxyaWowZH8iFzCVdf0S7ab2pEpXW+W20KprMqktK/yYPi1UMbatIOvopYL4Uu+ukO4k2
         xRX9zDrJ8uPzu5bMwDJM7OA5F3nDLJHq+bjKlQ/zpOuxaht6rvxpB+ZT6GOm98RjaFIY
         uq2RQs19LyooOr2748J4HZetAYfrRvTDFFbJKwxV8B/IbtoSAkhUIO0dY33M3hhYeyS7
         NwqQ==
X-Gm-Message-State: AOAM532jH0pU0JbY9orcjgvmtTOUui1ZamXR4Oo5ApJyrTs8IkIP6+Mg
        tf2MfYO9fMhB3RSNcEx2DWm08OB36hZGdn6L4k9xjTKksKlKlV8ri8Amjc5uJLViDYNZz79uo10
        qNq+iPvGvF7oVYSXDLwt3L8/W
X-Received: by 2002:a05:600c:3b05:b0:397:54ce:896 with SMTP id m5-20020a05600c3b0500b0039754ce0896mr23468726wms.3.1654001301764;
        Tue, 31 May 2022 05:48:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3yBlVpu/2rIV/yUlL+sCnuhz1GmFj2iWNFe3ezeBDW/ktzwfQ3Xlkqb6JMZM4m2Fl8gnmXA==
X-Received: by 2002:a05:600c:3b05:b0:397:54ce:896 with SMTP id m5-20020a05600c3b0500b0039754ce0896mr23468714wms.3.1654001301565;
        Tue, 31 May 2022 05:48:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:f100:8096:9368:ba52:a341? (p200300cbc708f10080969368ba52a341.dip0.t-ipconnect.de. [2003:cb:c708:f100:8096:9368:ba52:a341])
        by smtp.gmail.com with ESMTPSA id n9-20020a5d4009000000b0021022ecd0a7sm9479833wrp.74.2022.05.31.05.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 05:48:20 -0700 (PDT)
Message-ID: <0e2005c7-8ccb-7d07-57ed-a04cfd7af369@redhat.com>
Date:   Tue, 31 May 2022 14:48:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] mm/memremap: fix missing call to untrack_pfn() in
 pagemap_range()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     anshuman.khandual@arm.com, osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220531122643.25249-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220531122643.25249-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.05.22 14:26, Miaohe Lin wrote:
> We forget to call untrack_pfn() to pair with track_pfn_remap() when range
> is not allowed to hotplug. Fix it by jump err_kasan.
> 
> Fixes: bca3feaa0764 ("mm/memory_hotplug: prevalidate the address range being added with platform")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/memremap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 2b92e97cb25b..b870a659eee6 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -214,7 +214,7 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
>  
>  	if (!mhp_range_allowed(range->start, range_len(range), !is_private)) {
>  		error = -EINVAL;
> -		goto err_pfn_remap;
> +		goto err_kasan;
>  	}
>  
>  	mem_hotplug_begin();

Thanks!

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

