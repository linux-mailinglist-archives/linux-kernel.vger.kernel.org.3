Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B23588CDD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 15:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237557AbiHCNSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 09:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbiHCNST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 09:18:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9D882620
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 06:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659532697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gQmr5zxXBeS+lEJrTKyBVLP3zOI2K8Zz09a8Jl2j1mE=;
        b=UAUBaUp6GW+C7QhRgJ1RP4hC8kYTVne9KcETnEKC+23Eb1s9epcZMUW04FouM8GGeDNUPV
        Dbwr54xj+MCOSPaMs9Kq8GMO5PVylqsqwlpPeOvqPWd42vfGCeewXVLgGPM0HSiw+gXcDA
        f5GCp/boN9FrX06yQ63zUizdmed3jdQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-TIgMwYWoN7uuTNO9UJ0Ghg-1; Wed, 03 Aug 2022 09:18:16 -0400
X-MC-Unique: TIgMwYWoN7uuTNO9UJ0Ghg-1
Received: by mail-wr1-f70.google.com with SMTP id n7-20020adfc607000000b0021a37d8f93aso4276141wrg.21
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 06:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=gQmr5zxXBeS+lEJrTKyBVLP3zOI2K8Zz09a8Jl2j1mE=;
        b=uxptxZgZZ15AW5WRKPDhzg2PZFe/Qo5YhU6C6ELIQN2pd4bo7Nz1fmquNO2+R5mQ5f
         DBZdOf8VY5GqRXHD73jgMVOuki8s7XL63aE2CMMheuH+VfzVmkN8j/3vUKhUBwRITpdJ
         RCs5cftR6n1aAdrP4/lOKeQEL/8DG0HZA0u4rrF4liEHZE9EEcTsHUCkAGyJkomAnUk8
         MLGO5Ts8/3mig77L1KcK+L4k9EN1ut5/MFrDvuCbL220vOUj8heCF1954jzjPViLtutD
         /TpxgjD00tZ/ashVVJFVX/L4+kc1yst+RUMLFISs69oMVzz5R52meNAp4Whzu3cYBPht
         UgXQ==
X-Gm-Message-State: ACgBeo1n5J5Jr+C67NO/NDx3w2JjULOfl3y/eGMPozeCedXd8Rhd3ltY
        id04s8vCTZCFMnM88qTMXJVKX7irfvqP0+Z2cp4XgUqEDjQz5eWQ/SAdzkMgmzG2KKHWClBQ+zW
        lxdYmGNDMnNcY6njCoHQjJlwO
X-Received: by 2002:a05:600c:1986:b0:3a3:490b:1fd4 with SMTP id t6-20020a05600c198600b003a3490b1fd4mr2768457wmq.140.1659532695209;
        Wed, 03 Aug 2022 06:18:15 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7gAwT2BPTspfhxNUy0lMGgiAhAO0xJhEFw1rSOXOPEgCd9IRmUbNYCiMoy0pSKBwI4T7m3sA==
X-Received: by 2002:a05:600c:1986:b0:3a3:490b:1fd4 with SMTP id t6-20020a05600c198600b003a3490b1fd4mr2768440wmq.140.1659532694934;
        Wed, 03 Aug 2022 06:18:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:9a00:1f5d:aaab:2398:9728? (p200300cbc7059a001f5daaab23989728.dip0.t-ipconnect.de. [2003:cb:c705:9a00:1f5d:aaab:2398:9728])
        by smtp.gmail.com with ESMTPSA id e15-20020adfe7cf000000b0021e8d205705sm17693526wrn.51.2022.08.03.06.18.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 06:18:14 -0700 (PDT)
Message-ID: <9b018e35-de8e-76ab-8f7b-c7b23e640217@redhat.com>
Date:   Wed, 3 Aug 2022 15:18:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mm/x86: Use SWP_TYPE_BITS in 3-level swap macros
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
References: <20220803003745.35263-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220803003745.35263-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.08.22 02:37, Peter Xu wrote:
> Replace all the magic "5" with the macro.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/x86/include/asm/pgtable-3level.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
> index e896ebef8c24..28421a887209 100644
> --- a/arch/x86/include/asm/pgtable-3level.h
> +++ b/arch/x86/include/asm/pgtable-3level.h
> @@ -256,10 +256,10 @@ static inline pud_t native_pudp_get_and_clear(pud_t *pudp)
>  /* We always extract/encode the offset by shifting it all the way up, and then down again */
>  #define SWP_OFFSET_SHIFT	(SWP_OFFSET_FIRST_BIT + SWP_TYPE_BITS)
>  
> -#define MAX_SWAPFILES_CHECK() BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > 5)
> -#define __swp_type(x)			(((x).val) & 0x1f)
> -#define __swp_offset(x)			((x).val >> 5)
> -#define __swp_entry(type, offset)	((swp_entry_t){(type) | (offset) << 5})
> +#define MAX_SWAPFILES_CHECK() BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > SWP_TYPE_BITS)
> +#define __swp_type(x)			(((x).val) & ((1UL << SWP_TYPE_BITS) - 1))
> +#define __swp_offset(x)			((x).val >> SWP_TYPE_BITS)
> +#define __swp_entry(type, offset)	((swp_entry_t){(type) | (offset) << SWP_TYPE_BITS})
>  
>  /*
>   * Normally, __swp_entry() converts from arch-independent swp_entry_t to

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

