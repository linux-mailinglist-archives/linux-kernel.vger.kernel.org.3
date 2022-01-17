Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85137490B7D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240505AbiAQPgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:36:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22828 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240489AbiAQPgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:36:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642433771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0jP9NUGHSBRROmPolsKpE9Ht5fG16z4vLEx/qzEYMvM=;
        b=Eaz/NUuO5SIS66ECn9OaQH+U5sGOXcHs2IncOAz8Pg7CTvTQ5rxv0TvjIQ1iovy/1kAmM6
        vyM3Vqo+AspZ9wp6onX0JBK4q+arWUgDXfJrOXfwgsqHtbEy0OFk8Zzg6btsvi1lD8dEq0
        8RRNLPqmDXR+oz41o9XumQzO4kXIqZY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-WGjgUK4FMTyPLhy19_eyPw-1; Mon, 17 Jan 2022 10:32:06 -0500
X-MC-Unique: WGjgUK4FMTyPLhy19_eyPw-1
Received: by mail-ed1-f71.google.com with SMTP id x11-20020aa7d38b000000b004004e4fc8fdso11968849edq.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:32:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=0jP9NUGHSBRROmPolsKpE9Ht5fG16z4vLEx/qzEYMvM=;
        b=X+rYvpvw+tngjKu5t2jNBuAZpHPeSsm4SQm3J72HQopD11cqb91zKC8XrvgtlciRQz
         eHwzaFeiU5rp/ypxOLczCB2QWteGzxV6Mjf33E5add4iNotYOf/PjLjxUedeI38/+tSo
         UReW9wF8flWvuGMtq+duNSmc5Z/vcflCIAGof05x1VVQ2cKsYSfGbQCWttm/tsf8eaN/
         76CNNaosGrp8j5nQPU6y2D5UR9OnUtzMaJDeMvxJ8pbh9GvDURfM9U7Pbs/YAnC95cnG
         c59DNYQWCiBwdMGLOOpRsw68p8dG/S4h4SGpBxpUUHI52i8vsH+qXAkG1wnll0T63fTm
         YTLQ==
X-Gm-Message-State: AOAM533iOEZLC4kmegFl6ldbL0mTDkJuGkUBWd4doqr/bAIFcrYMp0Xq
        N3EWEGDc2/HPvGgrXR4Et2uwitWKPIaa50ZdUKiiT/pFnNXfBlx6GanIhXDHOMwa/zR9QbI0LIU
        dkdPS2JhroZhWLEpCivi9Yqnr
X-Received: by 2002:a05:6402:42ce:: with SMTP id i14mr21058738edc.126.1642433524352;
        Mon, 17 Jan 2022 07:32:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzC0KEtX0vuwV0ZCf9AwrJa2Vj8i8C9aUd5qTt/hWF1LTtiVg7dGt04/1NET3pWwmkxpYTtPQ==
X-Received: by 2002:a05:6402:42ce:: with SMTP id i14mr21058717edc.126.1642433524026;
        Mon, 17 Jan 2022 07:32:04 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:dd00:68a1:1bd:6733:bde9? (p200300cbc705dd0068a101bd6733bde9.dip0.t-ipconnect.de. [2003:cb:c705:dd00:68a1:1bd:6733:bde9])
        by smtp.gmail.com with ESMTPSA id u14sm5886078edv.92.2022.01.17.07.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 07:32:03 -0800 (PST)
Message-ID: <7d39763f-7fc6-a56f-4f1d-7bce42ff59d6@redhat.com>
Date:   Mon, 17 Jan 2022 16:32:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] Revert "mm/page_isolation: unset migratetype directly for
 non Buddy page"
Content-Language: en-US
To:     Chen Wandun <chenwandun@huawei.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        guillaume.tucker@collabora.com
References: <20220117142712.3967624-1-chenwandun@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220117142712.3967624-1-chenwandun@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.01.22 15:27, Chen Wandun wrote:
> This reverts commit 075782149abff45ee22f27315eced44d02b96779.
> 
> commit 075782149abf ("mm/page_isolation: unset migratetype directly for
> non Buddy page") will result memory that should in buddy disappear by
> mistake. move_freepages_block move all pages in pageblock instead of
> pages indicated by input parameter, so if input pages is not in buddy
> but other pages in pageblock is in buddy, it will result in page out of
> control.
> 

I was wondering about exactly that condition when skimming over the
patch but didn't have time review in detail.

Acked-by: David Hildenbrand <david@redhat.com>

> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
> ---
>  mm/page_isolation.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 6a0ddda6b3c5..f67c4c70f17f 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -115,7 +115,7 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
>  	 * onlining - just onlined memory won't immediately be considered for
>  	 * allocation.
>  	 */
> -	if (!isolated_page && PageBuddy(page)) {
> +	if (!isolated_page) {
>  		nr_pages = move_freepages_block(zone, page, migratetype, NULL);
>  		__mod_zone_freepage_state(zone, nr_pages, migratetype);
>  	}


-- 
Thanks,

David / dhildenb

