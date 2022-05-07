Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3909251E759
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 15:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446443AbiEGNOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 09:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385137AbiEGNOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 09:14:41 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3904146167
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 06:10:51 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id a11so8477715pff.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 06:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VvW+6AQdylaqYSS5bbVVsILc+xrDGFzgE29Ddi4rGxY=;
        b=6QjFTrBqbYjEerqAMbnBlZ4rfkQTm72PpK0tsNXUPmG4Z83A3Mhxg/G6rZyAvC8K6V
         3dhKswWTpY+KrEHzbYiG7ic4GxnUAFAK0T9tLn7f83bwpjmNneN34BXp34IHUgN0pEGq
         llHfTEODYAS+Ap4sZ4p63SLoOthmmupzQCMe2OhxZULOmpFX+OMHoK+pNQ1TEM2Bx5+r
         5fARJrDN3UFUpEpp2u0n6J2ZrdKvjbS08MdnRovcmZjZeh8Yco8L1EsWorA41+WBBtMS
         uhi6H9eONkEGdO3sI2KOR+U+dvja9KlT0RldRSR1Xo8qEzacyx4URmS9QB0GmvvI0EJq
         zVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VvW+6AQdylaqYSS5bbVVsILc+xrDGFzgE29Ddi4rGxY=;
        b=0HQ+3sPT1JX8v3k119sP2uuAwBxeB8aUx9yK4tEPB1vKj2k7K772u7QG3Uu/Dj2L/S
         z8JJt0Bd8PkUR7TLBMC6hqhbS/k3u/VwvsrMYVHDD9hEU9bzsIp14w0hTuQIfgXQIbMq
         APJjRSSCy7vOgg1wzOo73vrUywWfxb1dg8ZJ+UAR28zqABnR+YQ6O7izRoZ8pOMDcJ3S
         Khe2FeKPpoEDH8vWIrYuILFq9Q3yNtD4S/NtwemWWSjQLKw5/1oN2GjZD3YGCuPS/PI/
         /MnxpMD8Uc+NgmiJajFwWfLM1oHPlw6LyROEoOAj4GZj0bIZuhBrNSd7qx2YsSIpA3PF
         TH6Q==
X-Gm-Message-State: AOAM531AENz5I1HY4rUmTnXiXXGYsa7JXyzU/95nD09iKOWz448NXruX
        G2dj78Z08vIQ5H+9nD8kX08bPA==
X-Google-Smtp-Source: ABdhPJz9ByprCQmnFhqLNTBFVrH+91wxtv526hltZlfd81ZxNu7vKKFxevx5FUr60TYEsD4LKtNgsA==
X-Received: by 2002:a63:554c:0:b0:3c1:65f2:5543 with SMTP id f12-20020a63554c000000b003c165f25543mr6564926pgm.4.1651929050633;
        Sat, 07 May 2022 06:10:50 -0700 (PDT)
Received: from localhost ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id x2-20020aa79a42000000b0050dc7628169sm5280799pfj.67.2022.05.07.06.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 06:10:50 -0700 (PDT)
Date:   Sat, 7 May 2022 21:10:47 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, osalvador@suse.de,
        david@redhat.com, masahiroy@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v9 4/4] mm: hugetlb_vmemmap: add hugetlb_optimize_vmemmap
 sysctl
Message-ID: <YnZv19kuHqG+r25B@FVFYT0MHHV2J.usts.net>
References: <20220429121816.37541-1-songmuchun@bytedance.com>
 <20220429121816.37541-5-songmuchun@bytedance.com>
 <eadec7de-2e1a-2fb3-3317-c7b492a84e2b@oracle.com>
 <YnM4DRFhdD6iZIs1@FVFYT0MHHV2J.googleapis.com>
 <f77412f1-ffe5-659d-8a7d-578e0e8c5e2c@oracle.com>
 <YnOEl6Qwp5jp7RHp@FVFYT0MHHV2J>
 <a0c54e91-dcb2-debd-a1ef-b4906fed8ab1@oracle.com>
 <YnSM0Wd/lEc9wnwJ@FVFYT0MHHV2J.googleapis.com>
 <e199085c-d89d-093b-4257-0102980861bc@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e199085c-d89d-093b-4257-0102980861bc@oracle.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 09:50:53AM -0700, Mike Kravetz wrote:
> On 5/5/22 19:49, Muchun Song wrote:
> > On Thu, May 05, 2022 at 09:48:34AM -0700, Mike Kravetz wrote:
> >> On 5/5/22 01:02, Muchun Song wrote:
> >>> On Wed, May 04, 2022 at 08:36:00PM -0700, Mike Kravetz wrote:
> >>>> On 5/4/22 19:35, Muchun Song wrote:
> >>>>> On Wed, May 04, 2022 at 03:12:39PM -0700, Mike Kravetz wrote:
> >>>>>> On 4/29/22 05:18, Muchun Song wrote:
> >>>>>>> +static void vmemmap_optimize_mode_switch(enum vmemmap_optimize_mode to)
> >>>>>>> +{
> >>>>>>> +	if (vmemmap_optimize_mode == to)
> >>>>>>> +		return;
> >>>>>>> +
> >>>>>>> +	if (to == VMEMMAP_OPTIMIZE_OFF)
> >>>>>>> +		static_branch_dec(&hugetlb_optimize_vmemmap_key);
> >>>>>>> +	else
> >>>>>>> +		static_branch_inc(&hugetlb_optimize_vmemmap_key);
> >>>>>>> +	vmemmap_optimize_mode = to;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>>  static int __init hugetlb_vmemmap_early_param(char *buf)
> >>>>>>>  {
> >>>>>>>  	bool enable;
> >>>>>>> +	enum vmemmap_optimize_mode mode;
> >>>>>>>  
> >>>>>>>  	if (kstrtobool(buf, &enable))
> >>>>>>>  		return -EINVAL;
> >>>>>>>  
> >>>>>>> -	if (enable)
> >>>>>>> -		static_branch_enable(&hugetlb_optimize_vmemmap_key);
> >>>>>>> -	else
> >>>>>>> -		static_branch_disable(&hugetlb_optimize_vmemmap_key);
> >>>>>>> +	mode = enable ? VMEMMAP_OPTIMIZE_ON : VMEMMAP_OPTIMIZE_OFF;
> >>>>>>> +	vmemmap_optimize_mode_switch(mode);
> >>>>>>>  
> >>>>>>>  	return 0;
> >>>>>>>  }
> >>>>>>> @@ -60,6 +80,8 @@ int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
> >>>>>>>  	vmemmap_end	= vmemmap_addr + (vmemmap_pages << PAGE_SHIFT);
> >>>>>>>  	vmemmap_reuse	= vmemmap_addr - PAGE_SIZE;
> >>>>>>>  
> >>>>>>> +	VM_BUG_ON_PAGE(!vmemmap_pages, head);
> >>>>>>> +
> >>>>>>>  	/*
> >>>>>>>  	 * The pages which the vmemmap virtual address range [@vmemmap_addr,
> >>>>>>>  	 * @vmemmap_end) are mapped to are freed to the buddy allocator, and
> >>>>>>> @@ -69,8 +91,10 @@ int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
> >>>>>>>  	 */
> >>>>>>>  	ret = vmemmap_remap_alloc(vmemmap_addr, vmemmap_end, vmemmap_reuse,
> >>>>>>>  				  GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE);
> >>>>>>> -	if (!ret)
> >>>>>>> +	if (!ret) {
> >>>>>>>  		ClearHPageVmemmapOptimized(head);
> >>>>>>> +		static_branch_dec(&hugetlb_optimize_vmemmap_key);
> >>>>>>> +	}
> >>>>>>>  
> >>>>>>>  	return ret;
> >>>>>>>  }
> >>>>>>> @@ -84,6 +108,8 @@ void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
> >>>>>>>  	if (!vmemmap_pages)
> >>>>>>>  		return;
> >>>>>>>  
> >>>>>>> +	static_branch_inc(&hugetlb_optimize_vmemmap_key);
> >>>>>>
> >>>>>> Can you explain the reasoning behind doing the static_branch_inc here in free,
> >>>>>> and static_branch_dec in alloc?
> >>>>>> IIUC, they may not be absolutely necessary but you could use the count to
> >>>>>> know how many optimized pages are in use?  Or, I may just be missing
> >>>>>> something.
> >>>>>>
> >>>>>
> >>>>> Partly right. One 'count' is not enough. I have implemented this with similar
> >>>>> approach in v6 [1]. Except the 'count', we also need a lock to do synchronization.
> >>>>> However, both count and synchronization are included in static_key_inc/dec
> >>>>> infrastructure. It is simpler to use static_key_inc/dec directly, right? 
> >>>>>
> >>>>> [1] https://lore.kernel.org/all/20220330153745.20465-5-songmuchun@bytedance.com/
> >>>>>
> >>>>
> >>>> Sorry, but I am a little confused.
> >>>>
> >>>> vmemmap_optimize_mode_switch will static_key_inc to enable and static_key_dec
> >>>> to disable.  In addition each time we optimize (allocate) a hugetlb page after
> >>>> enabling we will static_key_inc.
> >>>>
> >>>> Suppose we have 1 hugetlb page optimized.  So static count == 2 IIUC.
> >>>> The someone turns off optimization via sysctl.  static count == 1 ???
> >>>
> >>> Definitely right.
> >>>
> >>>> If we then add another hugetlb page via nr_hugepages it seems that it
> >>>> would be optimized as static count == 1.  Is that correct?  Do we need
> >>>
> >>> I'm wrong.
> >>>
> >>>> to free all hugetlb pages with optimization before we can add new pages
> >>>> without optimization?
> >>>>
> >>>
> >>> My bad. I think the following code would fix this.
> >>>
> >>> Thanks for your review carefully.
> >>>
> >>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> >>> index 5820a681a724..997e192aeed7 100644
> >>> --- a/mm/hugetlb_vmemmap.c
> >>> +++ b/mm/hugetlb_vmemmap.c
> >>> @@ -105,7 +105,7 @@ void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
> >>>         unsigned long vmemmap_end, vmemmap_reuse, vmemmap_pages;
> >>>
> >>>         vmemmap_pages = hugetlb_optimize_vmemmap_pages(h);
> >>> -       if (!vmemmap_pages)
> >>> +       if (!vmemmap_pages || READ_ONCE(vmemmap_optimize_mode) == VMEMMAP_OPTIMIZE_OFF)
> >>>                 return;
> >>>
> >>>         static_branch_inc(&hugetlb_optimize_vmemmap_key);
> >>>  
> >>
> >> If vmemmap_optimize_mode == VMEMMAP_OPTIMIZE_OFF is sufficient for turning
> >> off optimizations, do we really need to static_branch_inc/dev for each
> >> hugetlb page?
> >>
> > 
> > static_branch_inc/dec is necessary since the user could change
> > vmemmap_optimize_mode to off after the 'if' judgement.
> > 
> > CPU0:				CPU1:
> > // Assume vmemmap_optimize_mode == 1
> > // and static_key_count == 1
> > if (vmemmap_optimize_mode == VMEMMAP_OPTIMIZE_OFF)
> > 	return;
> > 				hugetlb_optimize_vmemmap_handler();
> > 					vmemmap_optimize_mode = 0;
> > 					static_branch_dec();
> > 					// static_key_count == 0
> > // Enable static_key if necessary
> > static_branch_inc();
> > 
> > Does this make sense for you?
> 
> Yes, it makes sense and is require because hugetlb_optimize_vmemmap_pages()
> performs two functions:
> 1) It determines if vmemmap_optimization is enabled
> 2) It specifies how many vmemmap pages can be saved with optimization
> hugetlb_optimize_vmemmap_pages returns 0 if static_key_count == 0, so this
> would cause problems in places such as hugetlb free path (hugetlb_vmemmap_alloc).  I hope my understanding is correct?
>

Right.
 
> Would it make the code more clear if we did not do the check for
> vmemmap_optimization in hugetlb_optimize_vmemmap_pages()?  Instead:
> - hugetlb_optimize_vmemmap_pages ALWAYS returns the number of vmemmap pages
>   that can be freed/optimized
> - At hugetlb allocation time (hugetlb_vmemmap_free) we only check
>   hugetlb_optimize_vmemmap_enabled() to determine if optimization should
>   be performed.
> - After hugetlb_vmemmap_free, we can use HPageVmemmapOptimized to determine
>   if vmemap pages need to be allocated in hugetlb freeing paths.
>

I think this works as well. My initial consideration was that
embedding hugetlb_optimize_vmemmap_enabled() in
hugetlb_optimize_vmemmap_pages() could make the caller (e.g.
flush_free_hpage_work()) of hugetlb_optimize_vmemmap_pages()
more efficient when static_key == 0.  Maybe I could add
the check for vmemmap_optimization to flush_free_hpage_work()
and then remove the check from hugetlb_optimize_vmemmap_pages().
Will do this in a new version.

Thanks.

> Perhaps, there is something wrong with the above suggestion?
> 
> I know you have always had hugetlb_optimize_vmemmap_pages perform the two
> functions.  So, splitting functionality may not be more clear for you.  I am
> OK leaving code as is (key inc/dec for each page).  Just wanted to get your
> (and perhaps other) thoughts on splitting functionality as described above.   
> -- 
> Mike Kravetz
> 
