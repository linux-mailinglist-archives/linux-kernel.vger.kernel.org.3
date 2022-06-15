Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B408354BEA4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 02:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbiFOAOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 20:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237070AbiFOANf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 20:13:35 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232451581C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 17:13:34 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id k12-20020a17090a404c00b001eaabc1fe5dso547858pjg.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 17:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GK+RatNe7O7pymDTcdCOcSL1LPyziJES5KYjngnW3ls=;
        b=PNsmbrR1clGfoGvo6PaeGg0wLXoEfuHMfpDBzKrPLaLUFvR1kRZQaqNcs/7sbT+01K
         kdDp0sHcIAvapHzSwqM9jOR1mt8MOwQlcxf5QWfev3PocFcgqmx2n76EnUBJ8uRuB028
         cX86nEKuSkyk16OdE4Nuweeip4qNvlavLfxEzTFjlgKXZPVfEv1a/xxaHE5C+Wv8eJUZ
         MfV0C8FN6NRSgPnQo251cOnktt8FQ/2eosg0wfEfgXwfYELiwOXl7BJsTNdbSFamBjfs
         biHMhicx9DLRcQmpiTcjGolXSkhz+EFzNL4UXNYubm9gSs+pFC1zLYRQgfDL+iAPirkd
         0JmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GK+RatNe7O7pymDTcdCOcSL1LPyziJES5KYjngnW3ls=;
        b=dbEjrNVHXZZDy6D2+DomAvK/niEFZTubvRA/lnyWjL4qih95Dy5CbxADKctfgYkpkQ
         XPDQTWqqDaOG+A5wtJUOaeaSFKfOpft5xhhjLfeQcmzPgjwUXtgb1WOxvhY2Z6l0Sqgh
         lkhrw4AP44SZ0ADyOHckf0f2iqXladS0S6p60B8wK1vKCpejN3Q/NzfbY8lhuttbmz+m
         eU5tej+SeZ0LBYsMuFzYByYhxOovZf80Er3+2tgH4RHTuqvstG++gj4zlP9nCPLrUZd1
         svrRKTHyAqnzhyZ+GH49rGh8VJ8X7OrLXsG0YQr6rOA6sora9tUerPbhjdKXqh3lZ0t6
         qyeA==
X-Gm-Message-State: AJIora/682bysPFbXaaszHkCbVCmffWVsKKf8kNEcdiD1P/vMQvhhyFw
        4hUYYFUvTwPEto2q3RPdIHpw7w==
X-Google-Smtp-Source: ABdhPJxszaGJA28msG+FfNo21WuIAW9xfufswsUUxnO4OB/tFQWMQ/e5Iu4mjDLDJKL+V5vYkLvc1A==
X-Received: by 2002:a17:902:8f86:b0:168:9a69:fd4c with SMTP id z6-20020a1709028f8600b001689a69fd4cmr6539782plo.141.1655252013309;
        Tue, 14 Jun 2022 17:13:33 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id j3-20020a170903024300b001620960f1dfsm7822937plh.198.2022.06.14.17.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 17:13:32 -0700 (PDT)
Date:   Tue, 14 Jun 2022 17:13:28 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, aarcange@redhat.com,
        willy@infradead.org, vbabka@suse.cz, dhowells@redhat.com,
        neilb@suse.de, apopple@nvidia.com, david@redhat.com,
        surenb@google.com, peterx@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] mm/khugepaged: remove unneeded shmem_huge_enabled()
 check
Message-ID: <YqkkKCnNe42dAPrP@google.com>
References: <20220611084731.55155-1-linmiaohe@huawei.com>
 <20220611084731.55155-2-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611084731.55155-2-linmiaohe@huawei.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Jun 16:47, Miaohe Lin wrote:
> If we reach here, hugepage_vma_check() has already made sure that hugepage
> is enabled for shmem. Remove this duplicated check.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/khugepaged.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 476d79360101..73570dfffcec 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2153,8 +2153,6 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
>  		if (khugepaged_scan.address < hstart)
>  			khugepaged_scan.address = hstart;
>  		VM_BUG_ON(khugepaged_scan.address & ~HPAGE_PMD_MASK);
> -		if (shmem_file(vma->vm_file) && !shmem_huge_enabled(vma))
> -			goto skip;
>  
>  		while (khugepaged_scan.address < hend) {
>  			int ret;
> -- 
> 2.23.0
> 
> 

Thanks for these cleanups, Miaohe.

Reviewed-by: Zach O'Keefe <zokeefe@google.com>
