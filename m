Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8CA514640
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 12:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349329AbiD2KKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 06:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356949AbiD2KKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 06:10:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2C20C6647
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 03:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651226844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fpr0txJA455XWxPJoeYia7uJlW7TBpvXJ9nc6LJTAiI=;
        b=TyKC0vsWEU0HoPc3iZ+VmxgAfjNRYUMFw9mWDlU6oICqRyu6mzWNv459q2UnrbkYaimPUi
        IfuU8VgAAoU108XX1hTQn0wdKZAasZaSPtqM5MUP5Cgf/cs90GbTrz/MoYWX+gRkI+qw1l
        sLRgJq9pBXS62a3UOuHj/D3pGgDVuA4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-hnt8IMnoO76_BBVLsjDihg-1; Fri, 29 Apr 2022 06:07:20 -0400
X-MC-Unique: hnt8IMnoO76_BBVLsjDihg-1
Received: by mail-wm1-f72.google.com with SMTP id n186-20020a1c27c3000000b00392ae974ca1so2791628wmn.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 03:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=fpr0txJA455XWxPJoeYia7uJlW7TBpvXJ9nc6LJTAiI=;
        b=OKQkh1TSoQOJ5dIUHihoSpuuQhYPYhFP2JeBdzTL1mXhq34lwj3HS5yNNp2Na2cPob
         +IwtjogMiuxzdT0hlvRs/kpekDFP4dPBpaUXu8QQXEBzXvOamrnc09iqAiOYffRWNSGE
         /N3huSjOi9+YTrRDgfT4KZKK4oFcg/RGj6WRt9BXkRXJHkQR/8GDZ2Ht4m80L2yyIeaE
         V+3VE8ii3NkKFsZQdYiaHHEBqvf5po9Fm9iC6Shsiu2qRBaKWAK4kRq7CdSnEu3Df6jE
         qjsyi3v5KIbuyKhBeaXlLDZ8rUJsF+WgyqxjWvnp1sqe3eAcuMPFGHB3wSKxaeiGzyqG
         0n+A==
X-Gm-Message-State: AOAM532vTFhzQVjBFCJ5qiGpVnM7Uw/RkMcJkQRSoVMw/lAPQ6hxpd0M
        WI4bNtC5b6UCNqEfQ3fxkG6PVCiHoYNbFAryYW8qDoRHzS1UFQlXiE3CXOlyE3c/4vVplbXnWUR
        ABb+zqF35EDFo0xXAXyH3V6cj
X-Received: by 2002:a5d:53c1:0:b0:20a:db5d:2590 with SMTP id a1-20020a5d53c1000000b0020adb5d2590mr19565967wrw.411.1651226839163;
        Fri, 29 Apr 2022 03:07:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/ncLi8P4tmLVekHMk9A2dzXZx8miO5UnaC9FxNq2yFv1PruoWKbaEGVCiHLmNtNf3I6G0lg==
X-Received: by 2002:a5d:53c1:0:b0:20a:db5d:2590 with SMTP id a1-20020a5d53c1000000b0020adb5d2590mr19565948wrw.411.1651226838856;
        Fri, 29 Apr 2022 03:07:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:fe00:bbeb:98e6:617a:dea1? (p200300cbc707fe00bbeb98e6617adea1.dip0.t-ipconnect.de. [2003:cb:c707:fe00:bbeb:98e6:617a:dea1])
        by smtp.gmail.com with ESMTPSA id o21-20020adfa115000000b0020adea2767csm2109058wro.83.2022.04.29.03.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 03:07:18 -0700 (PDT)
Message-ID: <525298ad-5e6a-2f8d-366d-4dcb7eebd093@redhat.com>
Date:   Fri, 29 Apr 2022 12:07:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, naoya.horiguchi@nec.com
Cc:     ying.huang@intel.com, hch@lst.de, dhowells@redhat.com,
        cl@linux.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220425132723.34824-1-linmiaohe@huawei.com>
 <20220425132723.34824-3-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 2/4] mm/migration: remove unneeded lock page and
 PageMovable check
In-Reply-To: <20220425132723.34824-3-linmiaohe@huawei.com>
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

On 25.04.22 15:27, Miaohe Lin wrote:
> When non-lru movable page was freed from under us, __ClearPageMovable must
> have been done. Even if it's not done, ClearPageIsolated here won't hurt
> as page will be freed anyway. So we can thus remove unneeded lock page and
> PageMovable check here.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/migrate.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index b779646665fe..0fc4651b3e39 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1093,12 +1093,8 @@ static int unmap_and_move(new_page_t get_new_page,
>  		/* page was freed from under us. So we are done. */
>  		ClearPageActive(page);
>  		ClearPageUnevictable(page);
> -		if (unlikely(__PageMovable(page))) {
> -			lock_page(page);
> -			if (!PageMovable(page))
> -				ClearPageIsolated(page);
> -			unlock_page(page);
> -		}
> +		if (unlikely(__PageMovable(page)))
> +			ClearPageIsolated(page);
>  		goto out;
>  	}

Hm, that code+change raises a couple of questions.

We're doing here the same as in putback_movable_pages(). So I guess the
difference here is that the caller did release the reference while the
page was isolated, while we don't assume the same in
putback_movable_pages().


Shouldn't whoever owned the page have cleared that? IOW, is it even
valid that we see a movable or isolated page here (WARN/BUG?)?

At least for balloon compaction, I remember that __PageMovable() is
properly cleared before freeing it via balloon_page_delete().


Also, I am not sure how reliable that page count check is here: if we'd
have another speculative reference to the page, we might see
"page_count(page) > 1" and not take that path, although the previous
owner released the last reference.


-- 
Thanks,

David / dhildenb

