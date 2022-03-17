Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D479B4DC595
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbiCQMMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbiCQMMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:12:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DD861EA5DF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647519077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kSyLNb7c0c9c2nmyWguqMnTLe+v+e82hE8o/QMG7rOE=;
        b=DpG2BjfxyUsI+9RhpX9DTxTOQI8TbQvSGq5Jrh1aEaxR9dkER14CVAtER0gDt2LC7ibdym
        NvNig/uunnTWRUDrx3NRFEqSKn3nctcgfm0YiCuiiQRMONQaX2Oye38JMuei63j6mRg4rG
        YjBaZbvRK3ia0E9Mx0/DWeP3Ce/IvOc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-JU4rq-ViMCGRX6mSvoSgDw-1; Thu, 17 Mar 2022 08:11:16 -0400
X-MC-Unique: JU4rq-ViMCGRX6mSvoSgDw-1
Received: by mail-wr1-f69.google.com with SMTP id t15-20020a5d534f000000b001f1e5759cebso1494335wrv.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=kSyLNb7c0c9c2nmyWguqMnTLe+v+e82hE8o/QMG7rOE=;
        b=fqgYMECIwgaSrIFqnTWZPKeFP2swuwHXMdvC5uP2wetrCZOfgbFAHbv720pQNVigMe
         QiT9rTcN4eYtUrCvaW8rc6/r18hntFKu+kjLWQ9jjoXwekBf1uP9BQhmqzMNHNrDS3VO
         0De8bUk/vcwJI3z+Nky44+I9JQPQu41ui11Ygf0qycq2hd2crfuFDGAuq/EI3PkKm0lj
         0kFegR3SWJEWxj3FkJAy0D5E9CF23anejEkFkxXMpIEIngsKh7PJ9iTxPsNm6wMwv8F7
         ShU7jOnw34fVZIIbq8433qSrHf9hDZNeazMqFmIgqeG8F8jT+TG0ISxoTxrJDaXwAxY3
         UQVw==
X-Gm-Message-State: AOAM531TtiO1QJF+koPc/n//6+oq6julb0Wol+pSq3WFd33WhaG51NhO
        zXDr8loTrrqeW3gb/UnR3c4RHoOWiPnnD8dRYRYttTlGYdYVwGcnjdl4oLGPybmim0woVunipO8
        8tD1vxXWmpNgRymV0nORhUWa+
X-Received: by 2002:a05:6000:1868:b0:203:732e:6a96 with SMTP id d8-20020a056000186800b00203732e6a96mr3801006wri.39.1647519075000;
        Thu, 17 Mar 2022 05:11:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIXv62JgKNxYPnclkj3sS/CEL9HC1KuwOkjCVGiyV8rjULO7uR2QBoywnzjHaePed8KaNoGA==
X-Received: by 2002:a05:6000:1868:b0:203:732e:6a96 with SMTP id d8-20020a056000186800b00203732e6a96mr3800992wri.39.1647519074755;
        Thu, 17 Mar 2022 05:11:14 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id bg18-20020a05600c3c9200b0037c2ef07493sm4781066wmb.3.2022.03.17.05.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 05:11:14 -0700 (PDT)
Message-ID: <9f26eccb-d0f3-1c00-dce1-ab7fdd439fbb@redhat.com>
Date:   Thu, 17 Mar 2022 13:11:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 2/2] mm/memory-failure.c: make non-LRU movable pages
 unhandlable
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com, shy828301@gmail.com,
        mike.kravetz@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220318073945.62164-1-linmiaohe@huawei.com>
 <20220318073945.62164-3-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220318073945.62164-3-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.03.22 08:39, Miaohe Lin wrote:
> We can not really handle non-LRU movable pages in memory failure. Typically
> they are balloon, zsmalloc, etc. Assuming we run into a base (4K) non-LRU
> movable page, we could reach as far as identify_page_state(), it should not
> fall into any category except me_unknown. For the non-LRU compound movable
> pages, they could be taken for transhuge pages but it's unexpected to split
> non-LRU  movable pages using split_huge_page_to_list in memory_failure. So
> we could just simply make non-LRU  movable pages unhandlable to avoid these
> possible nasty cases.
> 
> Suggested-by: Yang Shi <shy828301@gmail.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>  mm/memory-failure.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index ecf45961f3b6..bf14bea2ed93 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1176,12 +1176,18 @@ void ClearPageHWPoisonTakenOff(struct page *page)
>   * does not return true for hugetlb or device memory pages, so it's assumed
>   * to be called only in the context where we never have such pages.
>   */
> -static inline bool HWPoisonHandlable(struct page *page)
> +static inline bool HWPoisonHandlable(struct page *page, unsigned long flags)
>  {
> -	return PageLRU(page) || __PageMovable(page) || is_free_buddy_page(page);
> +	bool movable = false;
> +
> +	/* Soft offline could mirgate non-LRU movable pages */

s/mirgate/migrate/

> +	if ((flags & MF_SOFT_OFFLINE) && __PageMovable(page))
> +		movable = true;

simply "return true" and drop "bool movable".

> +
> +	return movable || PageLRU(page) || is_free_buddy_page(page);

-- 
Thanks,

David / dhildenb

