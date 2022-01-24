Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6A64988AC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241988AbiAXStw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245375AbiAXSs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:48:58 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ABDC061751
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:48:58 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id z5so2734594plg.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Gzn3uL4rVVdIQDAl4BqctHY3PBm5IhFX7n3JXbdsza8=;
        b=Qh+FuWF89aMBe6tH8YCR707h4Gxwg0Ls7NK8D6oyRrTxLavxgit+eOxbNfYobiPB1P
         i257nnXOJ8+q5A2mnJooBL3VgJ9yLW8Gt8uzuRkJOzrL4ED+g0coDI1iBYnSaYVekOi/
         /S3xOTDv41y8sYC00uwEtka6RT+mYC3wDiqifhjjzZiM1HYvcJhgVNvFzbB4Z7K2K6GV
         FlxVGn/TG9/6zw0KTq50pVnWTnFDMi96DliTDzlOOKV+No0Ji1+Ez50CY9Q3alpzbIsb
         BLf5lgX6IJ+qdi80fHU8lg8GSB7aVZYkY93NfalIoxT0OpbAd9c5VN2Y9mk2ZirG0HWP
         lhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Gzn3uL4rVVdIQDAl4BqctHY3PBm5IhFX7n3JXbdsza8=;
        b=zUJeySmM6reT9sGXs+fD/3hwdIb3p+Q7Luo+kn/k0HxHUelcUQml0I7CL+H79mOKOR
         17cJdRg3EDV7vhrTsnwjLAGHrx9abgzqQ9odbj5pXx0JTAN29qov8Op8auQBSLgNkHrM
         6SNelHLLH9xzNOVlAHzwzwSvJzNNsAyvMQLLl2xDFpFu2blwmQmky0Tov5KssCBDzjQu
         fTLphURPRSaKDXSxNWJcn3gS+wh4gbkVZr2BcRMt//8Lqxyopj/OazRlHtY35opCBP3C
         sZScoYnQ9hgcBfm3+Hx2pAun93FsGGUGTjlMRSLXZRMep4BFUBMAjqEZIXB9ntQa79+H
         tc+w==
X-Gm-Message-State: AOAM531XY27yduRiFz9aF/Su3CA99UudRKY3iKJYCEqOSTGJCD32PWGF
        BSfkDQJ+VH+c5FuRZtU1N7R8fw==
X-Google-Smtp-Source: ABdhPJxpeHQ7qWhJZyBZR4jcIo1P20Ptn1cZClhGtSKAcWnnaDw6cFV4D/Pth0o3hjutXJnUc8uQnA==
X-Received: by 2002:a17:90b:1b0e:: with SMTP id nu14mr3174732pjb.39.1643050137402;
        Mon, 24 Jan 2022 10:48:57 -0800 (PST)
Received: from [2620:15c:29:204:1f99:bd65:fcbb:146c] ([2620:15c:29:204:1f99:bd65:fcbb:146c])
        by smtp.gmail.com with ESMTPSA id 20sm12251408pgz.59.2022.01.24.10.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 10:48:56 -0800 (PST)
Date:   Mon, 24 Jan 2022 10:48:55 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Peter Xu <peterx@redhat.com>, Zach O'Keefe <zokeefe@google.com>,
        SeongJae Park <sj@kernel.org>
cc:     Shakeel Butt <shakeelb@google.com>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: split thp synchronously on MADV_DONTNEED
In-Reply-To: <YaBevbuNuR+ToJ1o@xz-m1.local>
Message-ID: <e55d1f78-46c2-9ced-d7ad-c6deba4cb7b8@google.com>
References: <20211120201230.920082-1-shakeelb@google.com> <25b36a5c-5bbd-5423-0c67-05cd6c1432a7@redhat.com> <CALvZod5L1C1DV_DVs9O3xZm6CJnriunAoj89YLDdCp7ef5yBxA@mail.gmail.com> <YZ9kUD5AG6inbUEg@xz-m1.local> <CALvZod7L5Ga2xZOy_hgocsTxSuOYs840TiviOAhRwz59ATubWg@mail.gmail.com>
 <YaBevbuNuR+ToJ1o@xz-m1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Nov 2021, Peter Xu wrote:

> Some side notes: I digged out the old MADV_COLLAPSE proposal right after I
> thought about MADV_SPLIT (or any of its variance):
> 
> https://lore.kernel.org/all/d098c392-273a-36a4-1a29-59731cdf5d3d@google.com/
> 
> My memory was that there's some issue to be solved so that was blocked, however
> when I read the thread it sounds like the list was mostly reaching a consensus
> on considering MADV_COLLAPSE being beneficial.  Still copying DavidR in case I
> missed something important.
> 
> If we think MADV_COLLAPSE can help to implement an userspace (and more
> importantly, data-aware) khugepaged, then MADV_SPLIT can be the other side of
> kcompactd, perhaps.
> 
> That's probably a bit off topic of this specific discussion on the specific use
> case, but so far it seems all reasonable and discussable.
> 

Hi Peter,

Providing a (late) update since we now have some better traction on this, 
I think we'll be ready to post an RFC soon that introduces MADV_COLLAPSE.  
The work is being driven by Zach, now cc'd.

Let's also include SeongJae Park <sj@kernel.org> as well and keep him in 
the loop since DAMON could easily be extended with a DAMOS_COLLAPSE action 
to use MADV_COLLAPSE for hot regions of memory.

Idea for initial approach:

 - MADV_COLLAPSE core code based on the proposal you cite above for anon 
   memory as the inaugural support, collapse memory into thp in process 
   context

 - Batching support to collapse ranges of memory into multiple THP

 - Wire this up for madvise(2) (and process_madvise(2))

 - Enlightenment for file-backed thp

I think Zach's RFC will cover the first three, it could be debated if the 
initial patch series *must* support file-backed thp.  We'll see based on 
the feedback to the RFC.

There's also an extension where MADV_COLLAPSE could be potentially useful 
for hugetlb backed memory.  We have another effort underway that we've 
been talking with Mike Kravetz about that allows hugetlb memory to be 
mapped at multiple levels of the page tables.  There are several use cases 
but one of the driving factors is the performance of post-copy live 
migration; in this case, you'd be able to send smaller sized pages over 
the wire rather than, say, a 1GB gigantic page.

In this case, MADV_COLLAPSE could be useful to map smaller pages by 
a larger page table entry before all of the smaller pages have been live 
migrated.

That said, we have not invested time into an MADV_SPLIT yet.

Do you (or anybody else) have concerns about this approach?  Ideas for 
extensions?

Thanks!
