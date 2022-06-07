Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B34453FF8A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244329AbiFGM5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243173AbiFGM5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:57:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6AB21DA56
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654606657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4QSRH8DM0EWIFp4tvv53kVC06dJu/u/EgMkz7xegTNs=;
        b=JwuA4sJ0ipqJqvtOSSqgvTrwxX3OkcAsIAdGvsxHVkzrDfil504yLgE9AVQAfpq/N+FlBC
        nzh0vXS+19ZhKEzWNY+cNMUjuu8bI3lFHz0FmxriHNWUOLbqUnieem899bqzsobd0KX8mm
        u1ja7zKIOc1o8EU6KwR2OQzQjBFfhfA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-6MxAzz9lP2SNJOjaBAnJBQ-1; Tue, 07 Jun 2022 08:57:36 -0400
X-MC-Unique: 6MxAzz9lP2SNJOjaBAnJBQ-1
Received: by mail-wr1-f72.google.com with SMTP id h2-20020adfe982000000b002102da95c71so3860816wrm.23
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 05:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=4QSRH8DM0EWIFp4tvv53kVC06dJu/u/EgMkz7xegTNs=;
        b=blY3N2zz9MbdEAVBHux9Z/WhewRrcn9lRMVuHk8KKDC4RP6dIX6OUbRU4cckY6L8o7
         7q2e+9NZ/d3YtmmuQrw6X5x+b01gqsaxVZ2V48To9VHLl2982Yds3QiBVanNdgmNbUGR
         nIPdHeRT9DXfcstj45Nj6gRvz8k7bwIm0EXjOaKRzcqSVljePRQibCsN9UKlA1FcrPm8
         kK46/pT6W6bsFbR4/pXC39/eFbmu5iICImg3sOeuDdNdpg+HuL/6Cn9d5NyJlZ/r445b
         ZB2R5jkenXgCsQQ3fFswL/yuWRAbLcGVneyqoK9gkysEQt74/G3aHYEceEotKf9UjnA1
         qS2w==
X-Gm-Message-State: AOAM530AmhvVdZ8U3FTw2WBDYthjr0Bwo4sEvicv6hugDteCIt7QOdcu
        kkFMjZVyjWu5GURfA0vAXpHAb0r8rv4j4nmRJPTCsgo/6ixofoNd+jYPhfT26IirPzYzYSfV9vX
        kt8d7p/K3MjUyaqm1ntZqLODO
X-Received: by 2002:a05:600c:4f90:b0:397:89b1:539b with SMTP id n16-20020a05600c4f9000b0039789b1539bmr54389411wmq.149.1654606654440;
        Tue, 07 Jun 2022 05:57:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUkMuPhmF8WVpmZThM74o1w4iOAEeqbYNAVijCPByVKvmwU21f0ZJXPf9IJ4t1pum0BoCPxA==
X-Received: by 2002:a05:600c:4f90:b0:397:89b1:539b with SMTP id n16-20020a05600c4f9000b0039789b1539bmr54389386wmq.149.1654606654169;
        Tue, 07 Jun 2022 05:57:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:500:4c8d:4886:f874:7b6f? (p200300cbc70905004c8d4886f8747b6f.dip0.t-ipconnect.de. [2003:cb:c709:500:4c8d:4886:f874:7b6f])
        by smtp.gmail.com with ESMTPSA id n20-20020a7bc5d4000000b0039aef592ca0sm20181432wmk.35.2022.06.07.05.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 05:57:33 -0700 (PDT)
Message-ID: <11e5905b-f3a9-dced-d5dc-1446a3334f7f@redhat.com>
Date:   Tue, 7 Jun 2022 14:57:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/3] mm/page_alloc: use might_alloc()
Content-Language: en-US
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
References: <20220605152539.3196045-1-daniel.vetter@ffwll.ch>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220605152539.3196045-1-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.06.22 17:25, Daniel Vetter wrote:
> ... instead of open codding it. Completely equivalent code, just
> a notch more meaningful when reading.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> ---
>  mm/page_alloc.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2db95780e003..277774d170cb 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5177,10 +5177,7 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
>  			*alloc_flags |= ALLOC_CPUSET;
>  	}
>  
> -	fs_reclaim_acquire(gfp_mask);
> -	fs_reclaim_release(gfp_mask);
> -
> -	might_sleep_if(gfp_mask & __GFP_DIRECT_RECLAIM);
> +	might_alloc(gfp_mask);
>  
>  	if (should_fail_alloc_page(gfp_mask, order))
>  		return false;

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

