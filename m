Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D57351B993
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346214AbiEEIGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346238AbiEEIGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:06:15 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3977D33E24
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:02:36 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id s14so3687571plk.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 01:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PShkJzVucYzHmTWOWA19iZ2R7/CUl/du8x+v8/m6eak=;
        b=rXiO+G2RVXc79XKg+DxGCyvWynPSvXSf5jHVcLN6vb8WTIXeDgIGVT9fXj2f7csWGP
         hgBzSRld+vHsk8GHK0BCXG0OTatp1gKjEN/+drDy44zoWmUKOJbZtYd3W32uXzIebLrJ
         LZLVxRpSkwc7TfRK/qKQLZos1PlfwEQv7hC14IxjPLY00C0+JbHSwcR6BettVHJLH8jJ
         0mHVxHwTyPXk8yqvjcCLskCITBkRQo2vU1Yqpo+pSNugqCxyjcfn2cG1cFaVw4k5Or4v
         YKTDltG7pWJ99XQ9JeSowH8FY4RaAoyI2zSRNCxXgchnAnAp4beFlmJROU1f//FlC1bN
         3tAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PShkJzVucYzHmTWOWA19iZ2R7/CUl/du8x+v8/m6eak=;
        b=TYHr0oR80C2xOhKh+yvRrQ4OEBZWGqx4wFK6b8L5rofPyR8F3Hkp/vP8Q50vXgeCz3
         yw8v61dIyHlV5rXChrEqSQ9Zat35X7KgvFuY8dJRD5cPwtVG1ZdE3wH/1L4aW47oE4EL
         u1oKADACDNeBBsINAZKJQWPQq3Gzb+mvMPjPCrAFvyHJMLapZ5RFE4bl0KVNsIAiDgQM
         62ZS3Nv00cw8TygcZnx/jkzkGgdVI2hdRi/hcSwoEUvyp9kcqm31IuEebK8cSBnPedcB
         veyDE6VmxkjS1xTY62UpPYvx3kEXBPDZJ5256eiLjDn5EdIASSRwqiRW8rZNmm9SSgzq
         RSow==
X-Gm-Message-State: AOAM531u4hkZqyq2Ko+2K1yDspiDYRPZwQE6bOCWlKH3pIlDfLxIZqT5
        tYFqPFRTfbMDHfjpecezg4/8UA==
X-Google-Smtp-Source: ABdhPJzcmP/gFjk5XJNOBaDdYfBOx/5hGLiE7KzRJVfV8g6ITCklmhjuG/AU1KnZXR3qk8hUmvtw3g==
X-Received: by 2002:a17:902:e494:b0:15a:4b81:1c16 with SMTP id i20-20020a170902e49400b0015a4b811c16mr26803407ple.10.1651737755636;
        Thu, 05 May 2022 01:02:35 -0700 (PDT)
Received: from localhost ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id p9-20020a170902a40900b0015e8d4eb2acsm793721plq.246.2022.05.05.01.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 01:02:35 -0700 (PDT)
Date:   Thu, 5 May 2022 16:02:31 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, osalvador@suse.de,
        david@redhat.com, masahiroy@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v9 4/4] mm: hugetlb_vmemmap: add hugetlb_optimize_vmemmap
 sysctl
Message-ID: <YnOEl6Qwp5jp7RHp@FVFYT0MHHV2J>
References: <20220429121816.37541-1-songmuchun@bytedance.com>
 <20220429121816.37541-5-songmuchun@bytedance.com>
 <eadec7de-2e1a-2fb3-3317-c7b492a84e2b@oracle.com>
 <YnM4DRFhdD6iZIs1@FVFYT0MHHV2J.googleapis.com>
 <f77412f1-ffe5-659d-8a7d-578e0e8c5e2c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f77412f1-ffe5-659d-8a7d-578e0e8c5e2c@oracle.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 08:36:00PM -0700, Mike Kravetz wrote:
> On 5/4/22 19:35, Muchun Song wrote:
> > On Wed, May 04, 2022 at 03:12:39PM -0700, Mike Kravetz wrote:
> >> On 4/29/22 05:18, Muchun Song wrote:
> >>> +static void vmemmap_optimize_mode_switch(enum vmemmap_optimize_mode to)
> >>> +{
> >>> +	if (vmemmap_optimize_mode == to)
> >>> +		return;
> >>> +
> >>> +	if (to == VMEMMAP_OPTIMIZE_OFF)
> >>> +		static_branch_dec(&hugetlb_optimize_vmemmap_key);
> >>> +	else
> >>> +		static_branch_inc(&hugetlb_optimize_vmemmap_key);
> >>> +	vmemmap_optimize_mode = to;
> >>> +}
> >>> +
> >>>  static int __init hugetlb_vmemmap_early_param(char *buf)
> >>>  {
> >>>  	bool enable;
> >>> +	enum vmemmap_optimize_mode mode;
> >>>  
> >>>  	if (kstrtobool(buf, &enable))
> >>>  		return -EINVAL;
> >>>  
> >>> -	if (enable)
> >>> -		static_branch_enable(&hugetlb_optimize_vmemmap_key);
> >>> -	else
> >>> -		static_branch_disable(&hugetlb_optimize_vmemmap_key);
> >>> +	mode = enable ? VMEMMAP_OPTIMIZE_ON : VMEMMAP_OPTIMIZE_OFF;
> >>> +	vmemmap_optimize_mode_switch(mode);
> >>>  
> >>>  	return 0;
> >>>  }
> >>> @@ -60,6 +80,8 @@ int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
> >>>  	vmemmap_end	= vmemmap_addr + (vmemmap_pages << PAGE_SHIFT);
> >>>  	vmemmap_reuse	= vmemmap_addr - PAGE_SIZE;
> >>>  
> >>> +	VM_BUG_ON_PAGE(!vmemmap_pages, head);
> >>> +
> >>>  	/*
> >>>  	 * The pages which the vmemmap virtual address range [@vmemmap_addr,
> >>>  	 * @vmemmap_end) are mapped to are freed to the buddy allocator, and
> >>> @@ -69,8 +91,10 @@ int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
> >>>  	 */
> >>>  	ret = vmemmap_remap_alloc(vmemmap_addr, vmemmap_end, vmemmap_reuse,
> >>>  				  GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE);
> >>> -	if (!ret)
> >>> +	if (!ret) {
> >>>  		ClearHPageVmemmapOptimized(head);
> >>> +		static_branch_dec(&hugetlb_optimize_vmemmap_key);
> >>> +	}
> >>>  
> >>>  	return ret;
> >>>  }
> >>> @@ -84,6 +108,8 @@ void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
> >>>  	if (!vmemmap_pages)
> >>>  		return;
> >>>  
> >>> +	static_branch_inc(&hugetlb_optimize_vmemmap_key);
> >>
> >> Can you explain the reasoning behind doing the static_branch_inc here in free,
> >> and static_branch_dec in alloc?
> >> IIUC, they may not be absolutely necessary but you could use the count to
> >> know how many optimized pages are in use?  Or, I may just be missing
> >> something.
> >>
> > 
> > Partly right. One 'count' is not enough. I have implemented this with similar
> > approach in v6 [1]. Except the 'count', we also need a lock to do synchronization.
> > However, both count and synchronization are included in static_key_inc/dec
> > infrastructure. It is simpler to use static_key_inc/dec directly, right? 
> > 
> > [1] https://lore.kernel.org/all/20220330153745.20465-5-songmuchun@bytedance.com/
> > 
> 
> Sorry, but I am a little confused.
> 
> vmemmap_optimize_mode_switch will static_key_inc to enable and static_key_dec
> to disable.  In addition each time we optimize (allocate) a hugetlb page after
> enabling we will static_key_inc.
> 
> Suppose we have 1 hugetlb page optimized.  So static count == 2 IIUC.
> The someone turns off optimization via sysctl.  static count == 1 ???

Definitely right.

> If we then add another hugetlb page via nr_hugepages it seems that it
> would be optimized as static count == 1.  Is that correct?  Do we need

I'm wrong.

> to free all hugetlb pages with optimization before we can add new pages
> without optimization?
>

My bad. I think the following code would fix this.

Thanks for your review carefully.

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 5820a681a724..997e192aeed7 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -105,7 +105,7 @@ void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
        unsigned long vmemmap_end, vmemmap_reuse, vmemmap_pages;

        vmemmap_pages = hugetlb_optimize_vmemmap_pages(h);
-       if (!vmemmap_pages)
+       if (!vmemmap_pages || READ_ONCE(vmemmap_optimize_mode) == VMEMMAP_OPTIMIZE_OFF)
                return;

        static_branch_inc(&hugetlb_optimize_vmemmap_key);
 
