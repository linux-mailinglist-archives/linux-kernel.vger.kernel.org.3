Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C194F1F09
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349711AbiDDWB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379588AbiDDRmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:42:04 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76ED331DE3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 10:40:07 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id f3so9656235pfe.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 10:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4Ap1B3r6MrRHJq7ic8NTcdp4zBPVsdxuxM3YE28a4ko=;
        b=isTOiIek44lUsCbHEGFEeJoaC9MUVOUUVfdhVCqtJw32NHja3WGT2xrTxMG1rsW/72
         SXiUohDsX0GmHBUQX8Sttnamsnf39IQhqxyzrIcs38Q8avCiL8TCcY5J4OwJWFCbIw3K
         3BFGk+d+DSckMEFPx7E9iRtzLi5gRMIx9B2Lsv8hJnKt9bLD3fyzIyzUYp6PXgMlDjhS
         +4lv5M2BjozTIV8znLJ0E7s039Ql9BU4Y6Dqcz1Nbkc7xnLRpiHakED3SQEv+C9+yABF
         NeOGVzxGwyBPPnp4DO6OM2+Ghecoe3zdsEacuJqw9V/uZUfL6ptnTKjLMF7LRNr9sytt
         ukYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=4Ap1B3r6MrRHJq7ic8NTcdp4zBPVsdxuxM3YE28a4ko=;
        b=jhVk/GnRlsDJgaMyWjHQwQYCYxb+bgesNGOvJ9fZz/gxC21NJwI9ev0KkRe8ThdMFX
         Ggh6mN3K0/0zY2/g5qlNoWgg7goADZ2MtGrXxNl/BUubDvoiNVjLncnKg37hFip2701P
         h0eKL8uQ84X1DfmTDwMmNyqapHIliYlvfpuZrTyRhMEofTbhiPWhet/vhQ6Dgdpw0EOO
         A4d+a+gzC9YlJIhSm60sGLixBzYNP+9mLeSjO/n58CtEqH+uggvJmzpb0VKM4Qzym45D
         39n/cJHAABMaPNq00T56zljFhuIEClCA642pJOG4WZnq1IKXwKqPE/U5ImOpshsxSuU/
         ZbIg==
X-Gm-Message-State: AOAM532BaD02/jYuytQow3fGQFDUO+rH8GmEabUhuosCuLSItczHC49m
        4YdqquUIGXZxmcv9vmGCmj8=
X-Google-Smtp-Source: ABdhPJxQFjE6D07JXiQRM6ijdLHliafdY5XlZqrs06IvIyepc84WNPjyfBECSV24LlSzxFklcaPG9Q==
X-Received: by 2002:a63:ec46:0:b0:381:81c4:ebbd with SMTP id r6-20020a63ec46000000b0038181c4ebbdmr842716pgj.534.1649094006767;
        Mon, 04 Apr 2022 10:40:06 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:baee])
        by smtp.gmail.com with ESMTPSA id lp4-20020a17090b4a8400b001c9ada2f28fsm97834pjb.8.2022.04.04.10.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 10:40:06 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 4 Apr 2022 07:40:04 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Create kworker only for boot CPU pool prior
 SMP initialization
Message-ID: <YkstdEGbfg9PAKKc@slm.duckdns.org>
References: <20220331131435.2864347-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331131435.2864347-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 09:14:35PM +0800, Zqiang wrote:
> The workqueue_init() is called before SMP initialization, which
> means only the boot CPU is online, just create kworker for boot
> CPU pool.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/workqueue.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index abcc9a2ac319..3948babe02d5 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -6120,11 +6120,9 @@ void __init workqueue_init(void)
>  	mutex_unlock(&wq_pool_mutex);
>  
>  	/* create the initial workers */
> -	for_each_online_cpu(cpu) {
> -		for_each_cpu_worker_pool(pool, cpu) {
> -			pool->flags &= ~POOL_DISASSOCIATED;
> -			BUG_ON(!create_worker(pool));
> -		}
> +	for_each_cpu_worker_pool(pool, smp_processor_id()) {
> +		pool->flags &= ~POOL_DISASSOCIATED;
> +		BUG_ON(!create_worker(pool));

I mean, I guess this would work but what's the benefit? It doesn't make any
practical difference and the code is now more fragile to external changes.

Thanks.

-- 
tejun
