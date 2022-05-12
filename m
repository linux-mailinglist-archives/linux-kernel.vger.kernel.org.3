Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D91524E62
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354474AbiELNhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354353AbiELNhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:37:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C2CBE0D0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652362655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CXmdhmeZNjqxLqkQ0Z6PawE3Kif9Q/4jnU0D4GWa8iQ=;
        b=XCsxT8EHoJ6xFUl4i6BgIcmQCTbqRVdlwEx/J9mKW6Le4PVFvT2NaJvxxuH3JwbkaRSD6Z
        Asko+apYghlTJnQUyut56Um6SNQh2Fp39lHLUfE454CWlrhoZU19/vMg/tO5jaHAWQg3N0
        GuY8sfS6s+MqFBGiFCpWPxlaJJs+VFE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-ZP223mQ2O66K8FOcCXpAew-1; Thu, 12 May 2022 09:37:19 -0400
X-MC-Unique: ZP223mQ2O66K8FOcCXpAew-1
Received: by mail-wr1-f71.google.com with SMTP id ba21-20020a0560001c1500b0020ca6a45dfcso2079131wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=CXmdhmeZNjqxLqkQ0Z6PawE3Kif9Q/4jnU0D4GWa8iQ=;
        b=vEyustr9aRfHlY4T/og8fedWAo0hwV8N+Do5hlBPQj7ifKbPXvKNjZFzyC65UFHIfu
         1T/qdsDKefi41ylY/pKHZLABA1T56G0ymiaZYns5wn0DWcE7PwgBzUhuLIMTwzSID5F6
         x5WOlzehrTZpY5oQ5ecNy8iALDbKoLJLixji2sQDWG/RII2/p0N0jXMgeI+HRLw3PlvP
         ZFnxSA6OahOXCcKhQOuLqUN/dfNSlaK0gvLqJc97xuGF6iyuodlWjzV0zZkEYC4SU4Xf
         ewURCFfQKLO9aXLYH4b7KB7y3WlAUw2lbcAgzUP91yNGCaV5N1rS7LJt+caVPyBT7SKj
         U49A==
X-Gm-Message-State: AOAM532/rdAj/H1FqtBaNxTL2zBbNjTWxXs4U8G1ltySpXrViTbbYrYx
        n8N4YT23J4jWCyAr8rfW+bRp7pVRscZxkVervnG12Ich4Pc2xnY+insmc/Nw81Nlwg8CKZ0bANm
        54PyUrzcKYVV2TRz2j9dFV3mo
X-Received: by 2002:a05:600c:3b9d:b0:394:70a0:12d2 with SMTP id n29-20020a05600c3b9d00b0039470a012d2mr10422244wms.64.1652362638561;
        Thu, 12 May 2022 06:37:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTpMovfSI+/5WBg1JxCATNTy/GKF/szeOVrwKcSj/DyMMtAJ+jAJswrTy8pTTX7puUqLFRYA==
X-Received: by 2002:a05:600c:3b9d:b0:394:70a0:12d2 with SMTP id n29-20020a05600c3b9d00b0039470a012d2mr10422216wms.64.1652362638308;
        Thu, 12 May 2022 06:37:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:d200:ee5d:1275:f171:136d? (p200300cbc701d200ee5d1275f171136d.dip0.t-ipconnect.de. [2003:cb:c701:d200:ee5d:1275:f171:136d])
        by smtp.gmail.com with ESMTPSA id v16-20020a7bcb50000000b003942a244ee0sm2549625wmj.37.2022.05.12.06.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 06:37:16 -0700 (PDT)
Message-ID: <fd5c6a00-ea0e-b5d8-999f-d7b65c193ae4@redhat.com>
Date:   Thu, 12 May 2022 15:37:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 06/15] mm/swap: remove buggy cache->nr check in
 refill_swap_slots_cache
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     willy@infradead.org, vbabka@suse.cz, dhowells@redhat.com,
        neilb@suse.de, apopple@nvidia.com, surenb@google.com,
        peterx@redhat.com, naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220509131416.17553-1-linmiaohe@huawei.com>
 <20220509131416.17553-7-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220509131416.17553-7-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.05.22 15:14, Miaohe Lin wrote:
> refill_swap_slots_cache is always called when cache->nr is 0. And if
> cache->nr != 0, we should return cache->nr instead of 0. So remove
> such buggy and confusing check.

Not sure about the "cache->nr != 0, we should return cache->nr instead
of 0" part, I'd just drop that from the patch description. We'd actually
end up overwriting cache->nr after your change, which doesn't sound
right and also different to what you describe here.

> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/swap_slots.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> index 2f877e6f87d7..2a65a89b5b4d 100644
> --- a/mm/swap_slots.c
> +++ b/mm/swap_slots.c
> @@ -258,7 +258,7 @@ void enable_swap_slots_cache(void)
>  /* called with swap slot cache's alloc lock held */
>  static int refill_swap_slots_cache(struct swap_slots_cache *cache)
>  {
> -	if (!use_swap_slot_cache || cache->nr)
> +	if (!use_swap_slot_cache)
>  		return 0;
>  
>  	cache->cur = 0;

I feel like if this function would be called with cache->nr, it would be
a BUG. So I'm fine with removing it, but we could also think about
turning it into some sort of WARN/BG to make it clearer that this is
unexpected.


Anyhow,

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

