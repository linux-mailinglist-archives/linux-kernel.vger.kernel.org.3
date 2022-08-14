Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65FD59258B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 18:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242656AbiHNQok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 12:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243391AbiHNQoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 12:44:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB01B192B2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 09:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660494858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/bLBxnLhyoe+Ri5hSyQerGnoHF0IT6FiQiuj35p9Rts=;
        b=CfmHoqOUl5IHbg1MUm03x/1ECVtRGQtYRhrK6wzHePM+9Ke14B3HZJah2GAc3JrkXiu4Oe
        3obUhB57+eUXt68wcHd7ZG2sG3N+SzuquOtlZRGISIIU6Co00nc7pLFAl+s7BRWp5+aRSo
        ZzYxjYvcjCzTdzalk5zwWQmJeIcCFKI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-536-M5EkHkrgOOuImeqd3Hw2tw-1; Sun, 14 Aug 2022 12:34:16 -0400
X-MC-Unique: M5EkHkrgOOuImeqd3Hw2tw-1
Received: by mail-wm1-f72.google.com with SMTP id h127-20020a1c2185000000b003a534ec2570so1713941wmh.7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 09:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=/bLBxnLhyoe+Ri5hSyQerGnoHF0IT6FiQiuj35p9Rts=;
        b=T6+P/JARcCXg51qF/XsbFMaTxRFFOLiF8pJdzmtmZVFIFiY7Uu1nEH4gW63d6MkRel
         8lXfb0rbc4IfKJCvTWI0TQK2Lx7JeQhOMZJaaoYLevoA4NGE5OkKc2wVQHmGvWZQXm3k
         A32O7YYYhQRBr/NxiUcQt0UDR07DgO3GkfGilpS4zz29zhAV3M77p268Ej5NLTItIarx
         aVuBcxJYwa8S/IKMbDdUfN2u++VVfiukI4ffY1LHYaWn/aQXRo73gQC45QM7aMko00GH
         SYjTD8C/9/UnMqQwrn0YB22OeoZIVT2Ni5hqge8qmSqTyZWLaCLYRbnOlnUFRF6M3LyW
         KrJg==
X-Gm-Message-State: ACgBeo2hRjUry6S7BPY6tSDLzWjDSSiRkxceeVkWwOhoFW6xXMl/vSm7
        tXgKecORZJ2TMPzf/x4GxuxuxWGwWow1nMWW8ajNgLD917sLGNTb5ewgBv66VnlYE8IRopakbjm
        ogozmHDpEmPhuRsy81L361k5t
X-Received: by 2002:a5d:5403:0:b0:21e:ea93:234d with SMTP id g3-20020a5d5403000000b0021eea93234dmr6345505wrv.125.1660494853563;
        Sun, 14 Aug 2022 09:34:13 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7kzxZUWuBRCpUoygu7uG0RhgLXN19/Gzo1QOzf6smajaXfRnesi/S7AxAMeQekyKieU4Giyw==
X-Received: by 2002:a5d:5403:0:b0:21e:ea93:234d with SMTP id g3-20020a5d5403000000b0021eea93234dmr6345494wrv.125.1660494853258;
        Sun, 14 Aug 2022 09:34:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72a:1e00:10cf:131b:999d:9b4a? (p200300cbc72a1e0010cf131b999d9b4a.dip0.t-ipconnect.de. [2003:cb:c72a:1e00:10cf:131b:999d:9b4a])
        by smtp.gmail.com with ESMTPSA id d7-20020a05600c34c700b003a35516ccc3sm6863678wmq.26.2022.08.14.09.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Aug 2022 09:34:12 -0700 (PDT)
Message-ID: <aff9df5d-81be-ee98-5b12-c70cbede8a31@redhat.com>
Date:   Sun, 14 Aug 2022 18:34:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/3] mm: handling Non-LRU pages returned by follow_page
Content-Language: en-US
To:     Haiyue Wang <haiyue.wang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, linmiaohe@huawei.com,
        ying.huang@intel.com, songmuchun@bytedance.com,
        naoya.horiguchi@linux.dev, alex.sierra@amd.com
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <20220814140534.363348-1-haiyue.wang@intel.com>
 <20220814140534.363348-4-haiyue.wang@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220814140534.363348-4-haiyue.wang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.08.22 16:05, Haiyue Wang wrote:
> Add the missed put_page handling for handling Non-LRU pages returned by
> follow_page with FOLL_GET flag set.
> 
> This is the second patch for fixing the commit
> 3218f8712d6b ("mm: handling Non-LRU pages returned by vm_normal_pages")
> 
> Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> ---
>  mm/huge_memory.c |  2 +-
>  mm/ksm.c         | 10 ++++++++++
>  mm/migrate.c     |  6 +++++-
>  3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2ee6d38a1426..b2ba17c3dcd7 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2966,7 +2966,7 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>  		if (IS_ERR_OR_NULL(page))
>  			continue;
>  
> -		if (!is_transparent_hugepage(page))
> +		if (is_zone_device_page(page) || !is_transparent_hugepage(page))
>  			goto next;
>  
>  		total++;
> diff --git a/mm/ksm.c b/mm/ksm.c
> index fe3e0a39f73a..1360bb52ada6 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -477,6 +477,10 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
>  				FOLL_GET | FOLL_MIGRATION | FOLL_REMOTE);
>  		if (IS_ERR_OR_NULL(page))
>  			break;
> +		if (is_zone_device_page(page)) {
> +			put_page(page);
> +			break;
> +		}

I think we can drop this check completely. While working on patches that
touch this code I realized that this check is completely useless. device
pages are never PageKsm pages and there is no need to special-case here.

If a zone device page could be PageKsm, then we wouldn't handle it here
correctly and not break ksm.

So just drop it.



-- 
Thanks,

David / dhildenb

