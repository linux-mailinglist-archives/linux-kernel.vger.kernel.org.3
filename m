Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD375135AB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347713AbiD1Nxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347710AbiD1Nxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:53:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2389DFFF
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651153817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eSrTpAY01c2sAeG8S3OyerXPiSesjlWTEqP60Y4j5NQ=;
        b=S2VSAmd8IDBW4FF3CW19t0VYpS5j8B0LOdcDBj3bg0Sfw9QvIuwPglZJsOAuEPpp3JQUZy
        Asmhza+x+s4SFvQz+TZQbVXJYgplumxA679fSAMqTE5vrUbB6Ai+AJmYv9W7cRxw7asAnk
        qFPTQ2COBrjNdgAuAuCm3yVIUjH/T5E=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-POftygYiPf2kk2rUqt_T9Q-1; Thu, 28 Apr 2022 09:50:15 -0400
X-MC-Unique: POftygYiPf2kk2rUqt_T9Q-1
Received: by mail-il1-f198.google.com with SMTP id x1-20020a056e020f0100b002c98fce9c13so1779594ilj.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eSrTpAY01c2sAeG8S3OyerXPiSesjlWTEqP60Y4j5NQ=;
        b=Q4bDhboru0by1/tTRtmCN7gtTi8+byQBnM1wRPqBHuHaK+FVibrPCj12hp8ko98GHE
         SRxXGB1Q2oJrfOGoFtY+SX3bPMVyi+EqOM5L0fh0AKJJ1KJrKGr8iYlrkEf19v++IUNe
         lI/XiiTCQdlmrUnpjFUhBxnE+QoNsvRPos0OPpsO0VAqo2TalKic2BTobQAIcbbR+8mk
         OGCBiXe1HZN8vUuc+tCm+ZCJ7lFHFTn8eTA2/JCLBkbbz86t8vjiGmAF2Qtsd3cN9OJy
         i1NGBwc+/g+HvaTiucytEiP9qv9kvgHrdlO70nLKjQO9A4vPu7l8q2rvo1L7LeJrTDp2
         YegA==
X-Gm-Message-State: AOAM530g38CmDz4pl7X7CQzL6+7z8pYbzcZIGpKFfXXVHnH1vGVoYuAv
        gxqR4JALD3bms1/4PBWaoFIWhBAggh2klccC6a0C1ny/I1izddzT7LfdXff/bMJQPVkJIT7qmPA
        AOqrGJq8LMHrfH5xebRGx2DFw
X-Received: by 2002:a05:6638:dc9:b0:323:68d6:e15a with SMTP id m9-20020a0566380dc900b0032368d6e15amr13889548jaj.238.1651153814152;
        Thu, 28 Apr 2022 06:50:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBVVKwnStvWwJKB1GlEEK2+/gpmNiM5imf8h7vzirYHVExWGex8bY2fS3no0+WVvn+STav4Q==
X-Received: by 2002:a05:6638:dc9:b0:323:68d6:e15a with SMTP id m9-20020a0566380dc900b0032368d6e15amr13889543jaj.238.1651153813906;
        Thu, 28 Apr 2022 06:50:13 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id n4-20020a6b4104000000b006549fdd0780sm12944272ioa.51.2022.04.28.06.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 06:50:13 -0700 (PDT)
Date:   Thu, 28 Apr 2022 09:50:12 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Bibo Mao <maobibo@loongson.cn>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH v3] mm/khugepaged: sched to numa node when collapse huge
 page
Message-ID: <YmqblMIxcnG792Mh@xz-m1.local>
References: <20220317065024.2635069-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220317065024.2635069-1-maobibo@loongson.cn>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bibo,

On Thu, Mar 17, 2022 at 02:50:24AM -0400, Bibo Mao wrote:
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

Totally not familiar with specint, so a pure question is whether it'll make
a real difference in real-world workloads?  As I assume in real world the
memory affinity to the processors should change relatively slow on tuned
systems, so even if khugepaged copied a bit slower then it'll not affect
much on the real workload after the movement completes?

The other question is if it makes sense, whether it's applicable to file
thps too (collapse_file)?

Thanks,

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
> +	if (task_node(current) != node) {
> +		cpumask = cpumask_of_node(node);
> +		if (!cpumask_empty(cpumask))
> +			set_cpus_allowed_ptr(current, cpumask);
> +	}
>  	new_page = khugepaged_alloc_page(hpage, gfp, node);
>  	if (!new_page) {
>  		result = SCAN_ALLOC_HUGE_PAGE_FAIL;

-- 
Peter Xu

