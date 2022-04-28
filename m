Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C32C51380A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349081AbiD1PVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349122AbiD1PUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:20:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1575B42D3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651159032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sHEg8M8sspeeYGEbdvtWdwBiaF22012ZA01u4D76s0o=;
        b=DIAA9eXDe4EBs5P19W2U57CKOhZ68IiGDPs2Jn5BQncOUHZNwL+ZMQG9/la1h5dgZUsAoR
        I2zITQYCdNG6X+YsyRP+RHYWtWNwV6Tu6fklQ6FFn88LhXnNW9Mpr1509ezA0UJR4VFVZp
        CvOYv4JZGS+MAeqJtu+QOVOLNwCqYWk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-20V6xIZ6MrGH6WOZNqlwcA-1; Thu, 28 Apr 2022 11:17:11 -0400
X-MC-Unique: 20V6xIZ6MrGH6WOZNqlwcA-1
Received: by mail-wr1-f72.google.com with SMTP id w4-20020adfbac4000000b0020acba4b779so2050621wrg.22
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=sHEg8M8sspeeYGEbdvtWdwBiaF22012ZA01u4D76s0o=;
        b=QbQLp5HvXb+xznwaFbaT3VPrET+Z9qal91JRCMnukLPOwMwVjyn/DVPvRtnd/X+sOd
         yq2+L3vcTuRZvWVs4wtZ5pBq5hcuVV2hIAPSrs4gWhP/TdGxzSdHOfArEiiXt2f1T1ms
         0F1jWRn5p5IUCzwbps+dRa0o8jhgbP+3EeIBKg54vXMgUL6UfOggmFMVkpsmiEwLxS4z
         UgXAZoCQXC7n0iM/NkZ9RSipPsE/ifc8a5tKLlyYS704g7pCgBdc6SVuEjUH/s1ybjBL
         3nO3LjUfKuCdaIkrYy8sDc0xeaQXThKQQo9JrCfNIxAhhknRFBEqMs8znJMZEfIsZhOo
         KnJg==
X-Gm-Message-State: AOAM532dAFmSKv6YiG51BrCKy1awlIbVBFYH33ekTi0DHjpa3ELwMCM1
        cN2979i9Fdu4nQ1bfxIp1rgzQK+WdfioXui3Bh3WXUCwovf5xeHHDOTTDpiKkQoyKIFmheeXqbz
        NGkUbDPd9IYTZRfcxE7GRxWs/
X-Received: by 2002:a05:6000:1e05:b0:20a:ecc7:41cf with SMTP id bj5-20020a0560001e0500b0020aecc741cfmr8115361wrb.102.1651159029912;
        Thu, 28 Apr 2022 08:17:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5BQnX6mIdCOLdW46rgDYhg84e4FCHOWeThU4njV4qp4XrgDxqv1rwiDHi8KjnhsRdvQ2u9w==
X-Received: by 2002:a05:6000:1e05:b0:20a:ecc7:41cf with SMTP id bj5-20020a0560001e0500b0020aecc741cfmr8115344wrb.102.1651159029619;
        Thu, 28 Apr 2022 08:17:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:ef00:7443:a23c:26b8:b96? (p200300cbc708ef007443a23c26b80b96.dip0.t-ipconnect.de. [2003:cb:c708:ef00:7443:a23c:26b8:b96])
        by smtp.gmail.com with ESMTPSA id z11-20020a05600c220b00b00393ffde5f5fsm4731134wml.36.2022.04.28.08.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 08:17:08 -0700 (PDT)
Message-ID: <3a441789-b3e4-236e-2e44-e7a1c7258a94@redhat.com>
Date:   Thu, 28 Apr 2022 17:17:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Bibo Mao <maobibo@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Shi <shy828301@gmail.com>
References: <20220317065024.2635069-1-maobibo@loongson.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3] mm/khugepaged: sched to numa node when collapse huge
 page
In-Reply-To: <20220317065024.2635069-1-maobibo@loongson.cn>
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

On 17.03.22 07:50, Bibo Mao wrote:
> collapse huge page will copy huge page from general small pages,
> dest node is calculated from most one of source pages, however
> THP daemon is not scheduled on dest node. The performance may be
> poor since huge page copying across nodes, also cache is not used
> for target node. With this patch, khugepaged daemon switches to
> the same numa node with huge page. It saves copying time and makes
> use of local cache better.
> 
> With this patch, specint 2006 base performance is improved with 6%
> on Loongson 3C5000L platform with 32 cores and 8 numa nodes.

If it helps, that's nice as long as it doesn't hurt other cases.

> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
> changelog:
> V2: remove node record for thp daemon
> V3: remove unlikely statement
> ---
>  mm/khugepaged.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 131492fd1148..b3cf0885f5a2 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1066,6 +1066,7 @@ static void collapse_huge_page(struct mm_struct *mm,
>  	struct vm_area_struct *vma;
>  	struct mmu_notifier_range range;
>  	gfp_t gfp;
> +	const struct cpumask *cpumask;
>  
>  	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>  
> @@ -1079,6 +1080,13 @@ static void collapse_huge_page(struct mm_struct *mm,
>  	 * that. We will recheck the vma after taking it again in write mode.
>  	 */
>  	mmap_read_unlock(mm);
> +
> +	/* sched to specified node before huage page memory copy */

huage? I assume "huge"

> +	if (task_node(current) != node) {
> +		cpumask = cpumask_of_node(node);
> +		if (!cpumask_empty(cpumask))
> +			set_cpus_allowed_ptr(current, cpumask);
> +	}

I wonder if that will always be optimized out without NUMA and if we
want to check for IS_ENABLED(CONFIG_NUMA).


Regarding comments from others, I agree: I think what we'd actually want
is something like "try to reschedule to one of these CPUs immediately.
If they are all busy, just stay here.


Also, I do wonder if there could already be scenarios where someone
wants to let khugepaged run only on selected housekeeping CPUs (e.g.,
when pinning VCPUs in a VM to physical CPUs). It might even degrade the
VM performance in that case if we schedule something unrelated on these
CPUs. (I don't know which interfaces we might already have to configure
housekeeping CPUs for kthreads).

I can spot in kernel/kthread.c:kthread()

set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_TYPE_KTHREAD));

Hmmmmm ...


-- 
Thanks,

David / dhildenb

