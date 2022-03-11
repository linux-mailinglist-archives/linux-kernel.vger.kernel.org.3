Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB47E4D5E43
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347389AbiCKJVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245399AbiCKJVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:21:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 011371BD051
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646990413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JjMnaabkCThW4LfIHa74LeIIYTcgnA3J8O+F2l0SgkM=;
        b=ROnfCZqZOHuG1xNN+XdvwEpcncs89/AKof8BW69/hWvnfpdzYJrN2njt9Qr4/440vg/f+W
        3hxlFOHdCDKbcnof0kPJmNwUSLExHBvMa5Poo6GLCR5JJNZx5O7Vmfo2CEudybw1vpNSZJ
        rfu2oCaISwwygh7gO74wtwuY7KoXGiM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-498-tHs1gQtQMm-4ydOHmbO3mg-1; Fri, 11 Mar 2022 04:20:10 -0500
X-MC-Unique: tHs1gQtQMm-4ydOHmbO3mg-1
Received: by mail-wm1-f70.google.com with SMTP id 3-20020a05600c230300b00384e15ceae4so5258288wmo.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:20:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=JjMnaabkCThW4LfIHa74LeIIYTcgnA3J8O+F2l0SgkM=;
        b=LMxQV4csOdBJVGrATLj9ftJGum/NyAD9Q+sFMTzni3ZkAXxNRn/0ZQyxEc5fpuLrmg
         ABL7q+678Wvw3OOBLokdG1obCyfFvmupi6ZZuIEgzjA1ykBqe37WhxpBhbLt/feZtsSo
         fPj4Iz25ATsLCY96k/7ZgjnN5GgaNVQwXovQJ6i2V1MuFBm7o61gEtJzVHZV9onKwBaI
         MhvXhc2GmB3Iay7whIGxFRkDHDQ94GAwV4le++e3h1lmi4Zw8ijFucjuxagZn+D+2BgL
         hnLN+VfxRZ2y/rGMeMsXvrOG1s4vOOX90hfFnzjn6EDjAi/AAgxuOE0uBnp0f+Fxb6zk
         EVBg==
X-Gm-Message-State: AOAM532beGhg3bvIPtr+ahSj9kcLLmROoL5WUJaMcKiaWOpWf30NwV9R
        OvALIMNZyJ1Dd5xyaBVT3d+2ektiSklyGl5osbQYQ5qoXSPRquKvl2K5Gqmt8Qlw7EHonl8iX4A
        m8DEWTtVQ1ksAm2cOiECOofmz
X-Received: by 2002:a05:6000:1847:b0:203:813a:509e with SMTP id c7-20020a056000184700b00203813a509emr6485324wri.329.1646990409468;
        Fri, 11 Mar 2022 01:20:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx059XXbXV5c+1JfZ3BucwQzUjl7dzAZ6gRMB7RhWqx+WgCAbRdWc2w8xLDzsxYVlTt8YiWVQ==
X-Received: by 2002:a05:6000:1847:b0:203:813a:509e with SMTP id c7-20020a056000184700b00203813a509emr6485304wri.329.1646990409203;
        Fri, 11 Mar 2022 01:20:09 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:8200:163d:7a08:6e61:87a5? (p200300cbc7078200163d7a086e6187a5.dip0.t-ipconnect.de. [2003:cb:c707:8200:163d:7a08:6e61:87a5])
        by smtp.gmail.com with ESMTPSA id p11-20020adf9d8b000000b001f063deef80sm6101400wre.86.2022.03.11.01.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 01:20:08 -0800 (PST)
Message-ID: <52412f08-829a-6c29-60c6-a24c866e6253@redhat.com>
Date:   Fri, 11 Mar 2022 10:20:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] mm/khugepaged: sched to numa node when collapse huge page
Content-Language: en-US
To:     Bibo Mao <maobibo@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220311090119.2412738-1-maobibo@loongson.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220311090119.2412738-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.03.22 10:01, Bibo Mao wrote:
> collapse huge page is slow, specially when khugepaged daemon runs
> on different numa node with that of huge page. It suffers from
> huge page copying across nodes, also cache is not used for target
> node. With this patch, khugepaged daemon switches to the same numa
> node with huge page. It saves copying time and makes use of local
> cache better.

Hi,

just the usual question, do you have any performance numbers to back
your claims (e.g., "is slow, specially when") and proof that this patch
does the trick?


> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  mm/khugepaged.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 131492fd1148..460c285dc974 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -116,6 +116,7 @@ struct khugepaged_scan {
>  	struct list_head mm_head;
>  	struct mm_slot *mm_slot;
>  	unsigned long address;
> +	int node;
>  };
>  
>  static struct khugepaged_scan khugepaged_scan = {
> @@ -1066,6 +1067,7 @@ static void collapse_huge_page(struct mm_struct *mm,
>  	struct vm_area_struct *vma;
>  	struct mmu_notifier_range range;
>  	gfp_t gfp;
> +	const struct cpumask *cpumask;

We tend to stick to reverse Christmas tree format as good as possible.

>  
>  	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>  
> @@ -1079,6 +1081,13 @@ static void collapse_huge_page(struct mm_struct *mm,
>  	 * that. We will recheck the vma after taking it again in write mode.
>  	 */
>  	mmap_read_unlock(mm);
> +
> +	/* sched to specified node before huage page memory copy */

s/huage/huge/

> +	cpumask = cpumask_of_node(node);
> +	if ((khugepaged_scan.node != node) && !cpumask_empty(cpumask)) {
> +		set_cpus_allowed_ptr(current, cpumask);
> +		khugepaged_scan.node = node;
> +	}
>  	new_page = khugepaged_alloc_page(hpage, gfp, node);
>  	if (!new_page) {
>  		result = SCAN_ALLOC_HUGE_PAGE_FAIL;
> @@ -2380,6 +2389,7 @@ int start_stop_khugepaged(void)
>  		kthread_stop(khugepaged_thread);
>  		khugepaged_thread = NULL;
>  	}
> +	khugepaged_scan.node = NUMA_NO_NODE;
>  	set_recommended_min_free_kbytes();
>  fail:
>  	mutex_unlock(&khugepaged_mutex);


-- 
Thanks,

David / dhildenb

