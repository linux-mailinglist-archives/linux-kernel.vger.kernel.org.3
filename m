Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BEC539120
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 14:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344431AbiEaMv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 08:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244424AbiEaMvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 08:51:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D34179969A
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 05:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654001457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dNA8IBGIfRH1z/DDC9c/3LAwwmi5jZrAwWheo2TtFs4=;
        b=dDxVB08IRYBLErx6SAjxeDzSx415R5BF1vmSBgVyQ1bmF6d4IrtYiS93OiH7o/1g10zoly
        vLFUUDvZZcGlUSCIZctOIYS7ruLdt8R6mW+ayhO1TTwfaFhMx5Rnw4hoFwWx9pgHm36/ap
        itwzxO1Y/NB6PAoJTaajCrAn+S23940=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-61-dF9ykBB6N4yGSJliiRRHkg-1; Tue, 31 May 2022 08:50:56 -0400
X-MC-Unique: dF9ykBB6N4yGSJliiRRHkg-1
Received: by mail-wm1-f70.google.com with SMTP id n25-20020a05600c3b9900b0039733081b4dso1243154wms.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 05:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=dNA8IBGIfRH1z/DDC9c/3LAwwmi5jZrAwWheo2TtFs4=;
        b=0Gqpz+F8aL1YIJHfMmhvgAPteCz9F6acwvYiVog5NUkFj28H6yL7F8eNvxfkYw0tyK
         HjRXoxNpZhz4RLUeCb5zMpjlZAtogQslmAuw+3tC7ZUUaUf0JjV5PhrLmoewvpX3f8JS
         yfbWeNYzAsrzqJY8iIExN2Ss9tcVvGN+Qj0xb77/MgvmqU1hUfaIytwQKqYIuzoB4QT5
         qF8fETf73Blv3SvHcBT0yVXmGaiHIe35s+yT0rVk3kxCNNHQMa+MNxZfLgbewMWevQqQ
         0a881kcAagGiW+sIKhJKCVKwoK5f5O9pcyR5GYV6WOK8yxWbHN8H3A1BTOVIcjwSxboo
         nxVA==
X-Gm-Message-State: AOAM533IM96ZJnbDgpa6HYvmJvruyIBboA/XUStOp6xKj+NN80ULBQbq
        M/hWeLF1uOpRdGisEqiL34+vrT7xO+/QqlpmCWzp6SiuAWHHKok35KSV4OOMbyPsyWLWOivXAbR
        g02qNa851ecs6FUsvRseV7oMD
X-Received: by 2002:a1c:cc07:0:b0:397:b2f:ac59 with SMTP id h7-20020a1ccc07000000b003970b2fac59mr23587589wmb.157.1654001455444;
        Tue, 31 May 2022 05:50:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtHg7YEHavDUNWYO1KU/VZ8sWbhssqauNgDol40AiMkgIa6B0n4RRCJ5T0m8OcDOmoLyqoRQ==
X-Received: by 2002:a1c:cc07:0:b0:397:b2f:ac59 with SMTP id h7-20020a1ccc07000000b003970b2fac59mr23587574wmb.157.1654001455150;
        Tue, 31 May 2022 05:50:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:f100:8096:9368:ba52:a341? (p200300cbc708f10080969368ba52a341.dip0.t-ipconnect.de. [2003:cb:c708:f100:8096:9368:ba52:a341])
        by smtp.gmail.com with ESMTPSA id m15-20020a05600c3b0f00b003974ca9fa6dsm3464362wms.2.2022.05.31.05.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 05:50:54 -0700 (PDT)
Message-ID: <fbf6ee07-5e58-62b0-9fed-dcf4d0b71b08@redhat.com>
Date:   Tue, 31 May 2022 14:50:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4 2/4] mm/migration: remove unneeded lock page and
 PageMovable check
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com
Cc:     peterx@redhat.com, apopple@nvidia.com, ying.huang@intel.com,
        osalvador@suse.de, mike.kravetz@oracle.com,
        songmuchun@bytedance.com, hch@lst.de, dhowells@redhat.com,
        cl@linux.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220530113016.16663-1-linmiaohe@huawei.com>
 <20220530113016.16663-3-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220530113016.16663-3-linmiaohe@huawei.com>
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

On 30.05.22 13:30, Miaohe Lin wrote:
> When non-lru movable page was freed from under us, __ClearPageMovable must
> have been done.  So we can remove unneeded lock page and PageMovable check
> here. Also free_pages_prepare() will clear PG_isolated for us, so we can
> further remove ClearPageIsolated as suggested by David.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/migrate.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index e88ebb88fa6f..337336115e43 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1090,15 +1090,10 @@ static int unmap_and_move(new_page_t get_new_page,
>  		return -ENOSYS;
>  
>  	if (page_count(page) == 1) {
> -		/* page was freed from under us. So we are done. */
> +		/* Page was freed from under us. So we are done. */
>  		ClearPageActive(page);
>  		ClearPageUnevictable(page);
> -		if (unlikely(__PageMovable(page))) {
> -			lock_page(page);
> -			if (!PageMovable(page))
> -				ClearPageIsolated(page);
> -			unlock_page(page);
> -		}
> +		/* free_pages_prepare() will clear PG_isolated. */
>  		goto out;
>  	}
>  

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

