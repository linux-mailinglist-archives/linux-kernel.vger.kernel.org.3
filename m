Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF49E50A0C6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346415AbiDUN2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiDUN2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:28:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A22E6616B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650547512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sqs+pKWJ10kORv4PfMRp36XoGqspoxIr45iV+Tc3Iao=;
        b=XNBHReA54eBPuIZWUJJBcY5sngM5WrkZhuar/kz18CJQBXb8ZVI5zOGidq+xiZOT9Xt9Di
        Wg3X20HgPCXtT4Dh2V3xlAXjHyYNd0tLfiF0hnD63Ez1NL039URvFRMnli/QYM3B+J+OIy
        Cg21Y4IWc8njEEvhlr+T2T+RHhnoQV4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-371-eYtj8fl1Mn-f3tvT1ojVMA-1; Thu, 21 Apr 2022 09:25:11 -0400
X-MC-Unique: eYtj8fl1Mn-f3tvT1ojVMA-1
Received: by mail-ed1-f71.google.com with SMTP id cf15-20020a0564020b8f00b0042599227276so897991edb.21
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Sqs+pKWJ10kORv4PfMRp36XoGqspoxIr45iV+Tc3Iao=;
        b=0BODqgNnSsFNiAaVRbAdUG38hAcpGrferoPO45UKWGn8HhDQAPlSTnsbSm8jPJZRlk
         kUTwF4AM+qYJTEJ86qzyKDz8PFyb3s8v5xkn2NHWN/dGUD+sWcw56th5u72Hiq9pxYJq
         UTOIu303Qu6V95nldSq/msbFJrJIigAoc5E6F5rU4qXxYNs5Er5bi1fq/SZUmWkunak/
         EZgGtlLtb15cTApEgPNuaCAz+l9yAcAJ4i6et3CVrXuE2bUmY9woI4AafKnIXEKF1pQO
         3rOIsQoUHjoeGFKZHe7MbPRR98H4Jje5RH74uH/kfx2L8Mvlq25LSo5QbREi4gVImm9O
         GkYw==
X-Gm-Message-State: AOAM5328QA5noBrVaVlQ0t1MdDUUEAql0F0B8LTEXZW3iDF5EjYTjIT2
        8sXnd8BNUvihCFoeQtc7YgiHNrQPjIKGg43Xvxt6KxeCYQpFiAKuISn05avo34rO2plpQepFUK8
        HtlLMHIK+3vcE5YQJHTBUWMUq
X-Received: by 2002:a05:6402:2741:b0:41f:69dc:9bcd with SMTP id z1-20020a056402274100b0041f69dc9bcdmr29065428edd.239.1650547510441;
        Thu, 21 Apr 2022 06:25:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOYQlwE/xAK5IgaYMJSwt/0FIwT404JWn54QFCv1zJDU9TwSYuM5h/cDIsi8nNEUfPm0Vonw==
X-Received: by 2002:a05:6402:2741:b0:41f:69dc:9bcd with SMTP id z1-20020a056402274100b0041f69dc9bcdmr29065404edd.239.1650547510203;
        Thu, 21 Apr 2022 06:25:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:de00:711b:76af:b335:9b70? (p200300cbc702de00711b76afb3359b70.dip0.t-ipconnect.de. [2003:cb:c702:de00:711b:76af:b335:9b70])
        by smtp.gmail.com with ESMTPSA id mp8-20020a1709071b0800b006efc915e1ccsm3548152ejc.118.2022.04.21.06.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 06:25:08 -0700 (PDT)
Message-ID: <0a793d7c-0591-28bc-5c36-a908c9d4900d@redhat.com>
Date:   Thu, 21 Apr 2022 15:25:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 3/3] mm/madvise: free hwpoison and swapin error entry
 in madvise_free_pte_range
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     willy@infradead.org, vbabka@suse.cz, dhowells@redhat.com,
        neilb@suse.de, apopple@nvidia.com, surenb@google.com,
        minchan@kernel.org, peterx@redhat.com, sfr@canb.auug.org.au,
        naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220421125348.62483-1-linmiaohe@huawei.com>
 <20220421125348.62483-4-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220421125348.62483-4-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.04.22 14:53, Miaohe Lin wrote:
> Once the MADV_FREE operation has succeeded, callers can expect they might
> get zero-fill pages if accessing the memory again. Therefore it should be
> safe to delete the hwpoison entry and swapin error entry. There is no
> reason to kill the process if it has called MADV_FREE on the range.
> 
> Suggested-by: Alistair Popple <apopple@nvidia.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/madvise.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 4d6592488b51..5f4537511532 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -624,11 +624,14 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>  			swp_entry_t entry;
>  
>  			entry = pte_to_swp_entry(ptent);
> -			if (non_swap_entry(entry))
> -				continue;
> -			nr_swap--;
> -			free_swap_and_cache(entry);
> -			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
> +			if (!non_swap_entry(entry)) {
> +				nr_swap--;
> +				free_swap_and_cache(entry);
> +				pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
> +			} else if (is_hwpoison_entry(entry) ||
> +				   is_swapin_error_entry(entry)) {
> +				pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
> +			}
>  			continue;
>  		}
>  

Reading the man page that should be fine, but might not be required.

"[...] the kernel can free the pages at any time. Once pages in the
range have been freed, the caller will see zero-fill-on-demand pages
upon subsequent page references."


LGTM

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

