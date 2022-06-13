Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4234D549BB5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343636AbiFMSiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240833AbiFMShz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:37:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25ACA60D81
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 08:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655134804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9O1sbdf2ij2vjNGIB5kmQiO/dPYFEEYuNBpIJztkYLI=;
        b=g6wG/6mBYuSKKGv4BV0QTdLut4pwsl5nWYoDlwZ3HfBPm5u1vsfmUsJ4X4anL8BP8I2oPw
        J4PsM6Qv+/wXyFze14uzdKW1qSRErid+jVs1LmbjjJLu7e/ua2Gfe3w2tj293+ZLxoYy46
        9e0VyVcE3F5y6O54/0RbCAKZZjHWUu4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-I4SPbSIkNqaX-pVwHqcurg-1; Mon, 13 Jun 2022 11:40:02 -0400
X-MC-Unique: I4SPbSIkNqaX-pVwHqcurg-1
Received: by mail-wm1-f70.google.com with SMTP id c125-20020a1c3583000000b003978decffedso6055111wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 08:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=9O1sbdf2ij2vjNGIB5kmQiO/dPYFEEYuNBpIJztkYLI=;
        b=Wk6c8HgLMIiSNSW2EY1ScgaCPcTdqGYOAWhXODbbawkHrANroavBTKBVW0DiASuNhZ
         cM32kNjwDuUNhlMPjipskaZXrQLRPhEH+p59l5sXjh5zPK099KpX7OjKJDADF0LBuBoB
         +AMN387MfadZMRAQSMMgeL8zLJZT80ALi25v8pNruBw3fEanYdsB3XCn91BFptxdEnpi
         ve/jsyZT4lHURYOwlenLT1YKwSjPigRhubk9yZtPhBsaAzGpPrjd8nPrxAUFcVR34/26
         A4IaMLggvaRj7wdLVjeDQ6rEbjeajOziAASqyn9HgW28AcUGtXuLAw4aXctHzs/n6vpL
         dEHA==
X-Gm-Message-State: AOAM530g0qbYkuxKYhkYL1q0vpod/vZKyqCXUg/uxzowK2k3P9/ep43s
        T+4rYTDyDuVbRTesPqHdi4axwg/uLjraXiXz3h++eZoL8lc1vbj0wr+UdZNqS5Uf1c/Mqzv6psk
        Youe0ye1U77XGJGeWAIgfvPq+
X-Received: by 2002:a1c:7418:0:b0:39c:6ead:321c with SMTP id p24-20020a1c7418000000b0039c6ead321cmr54835wmc.171.1655134801547;
        Mon, 13 Jun 2022 08:40:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzd53JP6ehA2t0cS3jtwwK9+a0CJFs7Y0/eewsb9jvYGyOfgxsScdBrMX3bH7wHA4OxcpYqyA==
X-Received: by 2002:a1c:7418:0:b0:39c:6ead:321c with SMTP id p24-20020a1c7418000000b0039c6ead321cmr54821wmc.171.1655134801302;
        Mon, 13 Jun 2022 08:40:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:bd00:963c:5455:c10e:fa6f? (p200300cbc706bd00963c5455c10efa6f.dip0.t-ipconnect.de. [2003:cb:c706:bd00:963c:5455:c10e:fa6f])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c4f0f00b003942a244f39sm18189229wmq.18.2022.06.13.08.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 08:40:00 -0700 (PDT)
Message-ID: <4a6023f3-0fbd-32cf-7e52-bc72e2b4a407@redhat.com>
Date:   Mon, 13 Jun 2022 17:39:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 3/6] mm: hugetlb_vmemmap: introduce the name HVO
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, corbet@lwn.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20220613063512.17540-1-songmuchun@bytedance.com>
 <20220613063512.17540-4-songmuchun@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220613063512.17540-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.06.22 08:35, Muchun Song wrote:
> It it inconvenient to mention the feature of optimizing vmemmap pages associated
> with HugeTLB pages when communicating with others since there is no specific or
> abbreviated name for it when it is first introduced.  Let us give it a name HVO
> (HugeTLB Vmemmap Optimization) from now.
> 
> This commit also updates the document about "hugetlb_free_vmemmap" by the way
> discussed in thread [1].
> 
> Link: https://lore.kernel.org/all/21aae898-d54d-cc4b-a11f-1bb7fddcfffa@redhat.com/ [1]
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  7 ++++---
>  Documentation/admin-guide/mm/hugetlbpage.rst    |  3 +--
>  Documentation/admin-guide/sysctl/vm.rst         |  3 +--
>  fs/Kconfig                                      | 13 ++++++-------
>  mm/hugetlb_vmemmap.c                            |  8 ++++----
>  mm/hugetlb_vmemmap.h                            |  4 ++--
>  6 files changed, 18 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 391b43fee93e..7539553b3fb0 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1725,12 +1725,13 @@
>  	hugetlb_free_vmemmap=
>  			[KNL] Reguires CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>  			enabled.
> +			Control if HugeTLB Vmemmap Optimization (HVO) is enabled.
>  			Allows heavy hugetlb users to free up some more
>  			memory (7 * PAGE_SIZE for each 2MB hugetlb page).
> -			Format: { [oO][Nn]/Y/y/1 | [oO][Ff]/N/n/0 (default) }
> +			Format: { on | off (default) }
>  
> -			[oO][Nn]/Y/y/1: enable the feature
> -			[oO][Ff]/N/n/0: disable the feature
> +			on: enable HVO
> +			off: disable HVO
>  
>  			Built with CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON=y,
>  			the default is on.
> diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
> index a90330d0a837..64e0d5c512e7 100644
> --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> @@ -164,8 +164,7 @@ default_hugepagesz
>  	will all result in 256 2M huge pages being allocated.  Valid default
>  	huge page size is architecture dependent.
>  hugetlb_free_vmemmap
> -	When CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP is set, this enables optimizing
> -	unused vmemmap pages associated with each HugeTLB page.
> +	When CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP is set, this enables HVO.

Heh, it would be convenient to call this

CONFIG_HUGETLB_PAGE_VMEMMAP_OPTIMIZATION (HVO) then.

-- 
Thanks,

David / dhildenb

