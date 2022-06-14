Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB8B54AA81
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354333AbiFNHYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354275AbiFNHYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:24:00 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12E53BF93
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:23:58 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id y16so5941468ili.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WgsPByWFwvmxTN6GW/uMi6kC/eCqUxKkzQvH+8GjA0Q=;
        b=NpIAuWM0RbO9xoxmZjSOjTmrkmHw9aJ0t4AZ/Wbpsg6xH7ArIvcbtmqUcBM5cUbKHH
         5xqRXIZ27/l9KZtdtnpcqsycUrnqML4JuLEVmW6jeC73ec1QkNGGkqtwAt07d27DVnpX
         0MvW5YY5H66m65onie1kxC12c+WNiv9Y7+mZUBkFFCgg2cqzs5dKfw4Kjs43vqnFJpI3
         pWOAgAG0h61eBIpprpOLGscaRiEgzhbIeiTYzm/S+llD55TjkYAiJGOzt1OmwCNPzoCJ
         bpnCWmI05A8hdqBzIhwhLALelmCucxBQt4yDdO3Z1DjHHolziDMEzep2UbwmCO7kzO5D
         ToxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WgsPByWFwvmxTN6GW/uMi6kC/eCqUxKkzQvH+8GjA0Q=;
        b=l9dMJXU2SMzgdHYbBOkYKZ9VmmxeE64veZuHbgWHzZrvF8ARy2ZHbQYA/XBT9Z9JqJ
         ksYin7c/HE7JiPk+jLt8iIBZSwVRNFXXov/ExPu8N3WdnX9YwKMqHVImk/jiRrayMf1D
         XAy18aiXsJo+KgiKeHonZ5G+JDkwQzUno8Ex/sdXJF/GUvZYYSWsooQqoAJhjDQSrP8K
         mZqA31FutYZmBPaj/1hGzbGBYqy4ODIyjJw9xtiraFteTVWwGIyTAJANQFbxL6WXq/jF
         wh1YJc3OSRnAMyvQ1MmeXhPzsbhAn3y2ZGNEUYyvE94txLEM5Hb1ZglBIkjklc0mtLTw
         FJ/g==
X-Gm-Message-State: AJIora9Yg47ZPdTakSh7U9levk+ayxxtuayJpXZ38zVZ9X09cq7qlTDX
        RV26v/VrkNwio/JWCVzMGaGw3A==
X-Google-Smtp-Source: AGRyM1tTdAgY4KPZSG2TLNgC428eedn0ZcqHWQI+CM35U4PQPM8vuUi36BqDkOW7JRkwKXukuMZr/g==
X-Received: by 2002:a92:504:0:b0:2d6:5aff:82ad with SMTP id q4-20020a920504000000b002d65aff82admr2153215ile.3.1655191437980;
        Tue, 14 Jun 2022 00:23:57 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:eaa7:1f3f:e74a:2a26])
        by smtp.gmail.com with ESMTPSA id f8-20020a02cac8000000b00331d411da60sm4544641jap.75.2022.06.14.00.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 00:23:57 -0700 (PDT)
Date:   Tue, 14 Jun 2022 01:23:52 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        page-reclaim@google.com, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v12 08/14] mm: multi-gen LRU: support page table walks
Message-ID: <Yqg3iLBGPyHOEfA2@google.com>
References: <20220614071650.206064-1-yuzhao@google.com>
 <20220614071650.206064-9-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614071650.206064-9-yuzhao@google.com>
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

On Tue, Jun 14, 2022 at 01:16:45AM -0600, Yu Zhao wrote:
> +static bool get_next_vma(unsigned long mask, unsigned long size, struct mm_walk *args,
> +			 unsigned long *vm_start, unsigned long *vm_end)
> +{
> +	unsigned long start = round_up(*vm_end, size);
> +	unsigned long end = (start | ~mask) + 1;
> +
> +	VM_WARN_ON_ONCE(mask & size);
> +	VM_WARN_ON_ONCE((start & mask) != (*vm_start & mask));
> +
> +	while (args->vma) {
> +		if (start >= args->vma->vm_end) {
> +			args->vma = args->vma->vm_next;
> +			continue;
> +		}
> +
> +		if (end && end <= args->vma->vm_start)
> +			return false;
> +
> +		if (should_skip_vma(args->vma->vm_start, args->vma->vm_end, args)) {
> +			args->vma = args->vma->vm_next;
> +			continue;
> +		}
> +
> +		*vm_start = max(start, args->vma->vm_start);
> +		*vm_end = min(end - 1, args->vma->vm_end - 1) + 1;
> +
> +		return true;
> +	}
> +
> +	return false;
> +}

Andrew,

The above function has a conflict with Maple Tree. Please use the
following fix-up if you apply MGLRU on top of Maple Tree. Thanks.

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 69a52aae1e03..05e62948e365 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3749,23 +3749,14 @@ static bool get_next_vma(unsigned long mask, unsigned long size, struct mm_walk
 {
 	unsigned long start = round_up(*vm_end, size);
 	unsigned long end = (start | ~mask) + 1;
+	VMA_ITERATOR(vmi, args->mm, start);
 
 	VM_WARN_ON_ONCE(mask & size);
 	VM_WARN_ON_ONCE((start & mask) != (*vm_start & mask));
 
-	while (args->vma) {
-		if (start >= args->vma->vm_end) {
-			args->vma = args->vma->vm_next;
+	for_each_vma_range(vmi, args->vma, end) {
+		if (should_skip_vma(args->vma->vm_start, args->vma->vm_end, args))
 			continue;
-		}
-
-		if (end && end <= args->vma->vm_start)
-			return false;
-
-		if (should_skip_vma(args->vma->vm_start, args->vma->vm_end, args)) {
-			args->vma = args->vma->vm_next;
-			continue;
-		}
 
 		*vm_start = max(start, args->vma->vm_start);
 		*vm_end = min(end - 1, args->vma->vm_end - 1) + 1;
