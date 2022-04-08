Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932524F9130
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbiDHIyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbiDHIyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:54:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 512A8237019
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 01:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649407932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oJBkCLhhtTvaSyY708hDkFvl+npCwl4oscvepwItiog=;
        b=KGH5Ce90j1EF637ZStnqy9+irgjr/qVsrtNJwoNpqiqY8YHm3mefT9mxGZa2Q5tL/YF+wn
        n7uRfb/3SDKeUQhKT4BvLL8CFAl7cqJajt0jORYe1/VJURIQsnPlx+XrVY6uYkVJC693em
        V1VRl1Cn3hbIuhqfu+Jxi0vnXG9xfAI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-wqZfQzHbME6lwh6zk9jGdw-1; Fri, 08 Apr 2022 04:52:07 -0400
X-MC-Unique: wqZfQzHbME6lwh6zk9jGdw-1
Received: by mail-wm1-f72.google.com with SMTP id i6-20020a05600c354600b0038be262d9d9so5667428wmq.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 01:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=oJBkCLhhtTvaSyY708hDkFvl+npCwl4oscvepwItiog=;
        b=x9hWosZnMgw+kBGG2bit07Ym+DT0bbul0fbxWTdQgde50P6wndzEuCE79yRhCueUiz
         oeUcc+gW78pUjC2UriyyciUEXmCrmVTM9I2W2lICvkiqf92hgqdD+BldaHbwqUJf5Y8D
         6HaThhiDBcLYqYNcFQmGAwP6Wc9btfgkZT7JHLJNNDnw3SEv05p+m0AXEYn2o8ytPWlm
         sJX3U3JTIysnOUAPB3gURA9stlCaLPNeBtpkcM912rOx0Y0dtMmfoejOX1RHmdEpX1iD
         rF8fjvZtKWPEh9veEW5Y0Hi+HJvLG6FyQ3pmad1hZfqjFEWBbaJVlT4nKB1pKCouORw7
         iYuA==
X-Gm-Message-State: AOAM533ZbllZtBi+KIEMdswyf8Q8nOU3/5pQnCfb0ECRKQCJ0UnV0qHZ
        YOvXJb9DebGdUMmEca29eeW0PIq/sp33dx18YxBn5tLpLYAI4mEW5sO5jxcUGOuJlhcVY3JyKZa
        z3uXDy5p7O/49jjr/2Mi82VP2
X-Received: by 2002:adf:f390:0:b0:206:16e1:b020 with SMTP id m16-20020adff390000000b0020616e1b020mr13554884wro.194.1649407925888;
        Fri, 08 Apr 2022 01:52:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQFPCXmJ8V5LLQgyW9ibZI5VirMVcGjo+6OHBySw9rFxhGD1cCjDRUb1iE1oNeaCMXESwkpw==
X-Received: by 2002:adf:f390:0:b0:206:16e1:b020 with SMTP id m16-20020adff390000000b0020616e1b020mr13554866wro.194.1649407925662;
        Fri, 08 Apr 2022 01:52:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:fd00:612:f12b:a4a2:26b0? (p200300cbc704fd000612f12ba4a226b0.dip0.t-ipconnect.de. [2003:cb:c704:fd00:612:f12b:a4a2:26b0])
        by smtp.gmail.com with ESMTPSA id m187-20020a1c26c4000000b0038e9a8b2139sm2665179wmm.11.2022.04.08.01.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 01:52:05 -0700 (PDT)
Message-ID: <09d363ba-5bd0-75ae-8ece-cd91997f1b46@redhat.com>
Date:   Fri, 8 Apr 2022 10:52:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 1/3] mm/memory-failure.c: avoid false-postive
 PageSwapCache test
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com
Cc:     shy828301@gmail.com, mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220407130352.15618-1-linmiaohe@huawei.com>
 <20220407130352.15618-2-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220407130352.15618-2-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.04.22 15:03, Miaohe Lin wrote:
> PageSwapCache is only reliable when PageAnon is true because PG_swapcache
> serves as PG_owner_priv_1 which can be used by fs if it's pagecache page.
> So we should test PageAnon to distinguish pagecache page from swapcache
> page to avoid false-postive PageSwapCache test.

Well, that's not quite correct. Just because a page is PageAnon()
doesn't mean that it's in the swapache. It means that it might be in the
swapcache but cannot be in the pagecache.

Maybe you wanted to say

"So we should test PageAnon() to distinguish pagecache pages from
anonymous pages."

> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/memory-failure.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index ef402b490663..2e97302d62e4 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2262,7 +2262,7 @@ static int __soft_offline_page(struct page *page)
>  		return 0;
>  	}
>  
> -	if (!PageHuge(page) && PageLRU(page) && !PageSwapCache(page))
> +	if (!PageHuge(page) && PageLRU(page) && !PageAnon(page))
>  		/*
>  		 * Try to invalidate first. This should work for
>  		 * non dirty unmapped page cache pages.


-- 
Thanks,

David / dhildenb

