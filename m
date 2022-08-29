Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FDE5A4697
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiH2J6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiH2J54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:57:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AC65EDE0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661767075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QMTykbwk6AZSjQjww3HImzZvto3dksoHZ/O5A3KMEas=;
        b=dToF02i1Po0b2qwwofUPqbAOPkeuyXbhPPauTgDUyKXsg0QW4ZkImMlADWbPYQg9XWe0MA
        XTQIQU630fzZTtd3JelUUENgeQIPabNO3Sh7oVzFVCGsIRwaNzmGjDXp6ULYG5kJgcemIj
        XxHg/d/LdMx3jBClX/+CnEw2rLpF2uQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-66-BamMkvBDO1qRYmN-gVzZsA-1; Mon, 29 Aug 2022 05:57:53 -0400
X-MC-Unique: BamMkvBDO1qRYmN-gVzZsA-1
Received: by mail-wr1-f70.google.com with SMTP id j9-20020a5d4649000000b00226d830857cso414027wrs.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=QMTykbwk6AZSjQjww3HImzZvto3dksoHZ/O5A3KMEas=;
        b=ZNxKqQM8w1vRApU1bVHbUmSvVEO5Zd5BI3+so4DuJV/e1NAkbp0+kYq1eEXaeP283k
         fz3dsTtuqa3g9eHpT3HqLUlAIqNJAp6vYeFosvIEVGEsXbJzF69+lSbKHSAlz1mXACnN
         kFeol7PoMh6aPQtFav9IvaW6MTpkJSeB2saE2w7zeRsvOiIs759zbgZj8ILcgo6DhR+r
         Ac6Dveq17FwgxVQwqGsfUBPSHh0UghfU0eXdYnanllWQy+Sp0KdGcXFwBioNG+wULOJ8
         T3GhWXuEqvV5F0IJzjVy1sAAjSOtYowgSX7lRi5/xhtApLy5m5SuuFA+8l6U9Hngxsvb
         99+g==
X-Gm-Message-State: ACgBeo0AUwjmZVvZt+ZPD5ePKAwfOLQ4qnrIlScUpnkotOp0x4ZBA7QO
        iu2/BA24+JHjF+rm8yfygy3hx1/8oLZx4FKzRLwhp9GbbfmBqoVOh4oIkERKJ0COVBXTNqeUvUf
        lntb4o9eAw241S94VgdNy0JG6
X-Received: by 2002:a05:600c:4e52:b0:3a6:d89:4d1b with SMTP id e18-20020a05600c4e5200b003a60d894d1bmr6563025wmq.150.1661767072725;
        Mon, 29 Aug 2022 02:57:52 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5pV92QAfBCLPVvi2BsGMldnaMsefPjmkba7aw6nv6pWQEK47OKVWgsQZ7B0jFoE7EkW4pukg==
X-Received: by 2002:a05:600c:4e52:b0:3a6:d89:4d1b with SMTP id e18-20020a05600c4e5200b003a60d894d1bmr6563012wmq.150.1661767072501;
        Mon, 29 Aug 2022 02:57:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3900:658b:bed0:4260:4c25? (p200300cbc7073900658bbed042604c25.dip0.t-ipconnect.de. [2003:cb:c707:3900:658b:bed0:4260:4c25])
        by smtp.gmail.com with ESMTPSA id m3-20020a05600c4f4300b003a84375d0d1sm4810726wmq.44.2022.08.29.02.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 02:57:50 -0700 (PDT)
Message-ID: <3a1e31ee-d36c-7f08-03db-65d8abda3eab@redhat.com>
Date:   Mon, 29 Aug 2022 11:57:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] mm/thp: simplify has_transparent_hugepage by using
 IS_BUILTIN
Content-Language: en-US
To:     Liu Shixin <liushixin2@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20220829095709.3287462-1-liushixin2@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220829095709.3287462-1-liushixin2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.08.22 11:57, Liu Shixin wrote:
> Simplify code of has_transparent_hugepage define by using IS_BUILTIN.
> 
> No functional change.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  include/linux/pgtable.h | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 73fb1b2af795..a108b60a6962 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1610,11 +1610,7 @@ typedef unsigned int pgtbl_mod_mask;
>  #endif
>  
>  #ifndef has_transparent_hugepage
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -#define has_transparent_hugepage() 1
> -#else
> -#define has_transparent_hugepage() 0
> -#endif
> +#define has_transparent_hugepage() IS_BUILTIN(CONFIG_TRANSPARENT_HUGEPAGE)
>  #endif
>  
>  /*

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

