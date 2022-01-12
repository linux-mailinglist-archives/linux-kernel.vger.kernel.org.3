Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E436148C778
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 16:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343614AbiALPoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 10:44:25 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:59970 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241305AbiALPoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642002263; x=1673538263;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=x5XEAfB7yc7UwEh95na4p3I+08Ja8Oc5avplXUDituQ=;
  b=BtPvrrWjDd40S9ERdIvjewTowpYJ7Bkw2J9OM8+t6J8gBDTdlul36kkY
   geAidH9UyRW+B7GjHBPqS+zYuqBoFnKIuOSHgAiP0S97x/Ks1xETGNkv7
   tFURMTl1dRwBbNjUnEk+96JRJdLh21Pz2UpF5sgmWKwnvjezsFegybB2X
   w=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 12 Jan 2022 07:44:22 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 07:44:22 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 12 Jan 2022 07:43:41 -0800
Received: from [10.216.41.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 12 Jan
 2022 07:43:37 -0800
Subject: Re: [PATCH v3 RESEND] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED
 for shmem
To:     Mark Hemment <markhemm@googlemail.com>
CC:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>, <vbabka@suse.cz>,
        <rientjes@google.com>, <mhocko@suse.com>,
        "Suren Baghdasaryan" <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Charan Teja Reddy <charante@codeaurora.org>
References: <1641488717-13865-1-git-send-email-quic_charante@quicinc.com>
 <CANe_+UiDXHgPOZoqT9yxLgTwkVmjA7OiXduP1R0qO2vCt=KKWQ@mail.gmail.com>
 <c19b1c9e-6351-6e71-d472-5ccd39885984@quicinc.com>
 <CANe_+Uj+ccUSaCcU_+XixuM9eJkrh3M1TOCMB5D=8rpUxUM0JA@mail.gmail.com>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
Message-ID: <18269bfb-0dd9-a1c6-cd8b-94a0faf42105@quicinc.com>
Date:   Wed, 12 Jan 2022 21:13:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CANe_+Uj+ccUSaCcU_+XixuM9eJkrh3M1TOCMB5D=8rpUxUM0JA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Mark!!

On 1/12/2022 5:08 PM, Mark Hemment wrote:
>>>> +static int shmem_fadvise_dontneed(struct address_space *mapping, loff_t start,
>>>> +                               loff_t end)
>>>> +{
>>>> +       int ret;
>>>> +       struct page *page;
>>>> +       LIST_HEAD(list);
>>>> +       struct writeback_control wbc = {
>>>> +               .sync_mode = WB_SYNC_NONE,
>>>> +               .nr_to_write = LONG_MAX,
>>>> +               .range_start = 0,
>>>> +               .range_end = LLONG_MAX,
>>>> +               .for_reclaim = 1,
>>>> +       };
>>>> +
>>>> +       if (!shmem_mapping(mapping))
>>>> +               return -EINVAL;
>>>> +
>>>> +       if (!total_swap_pages)
>>>> +               return 0;
>>>> +
>>>> +       lru_add_drain();
>>>> +       shmem_isolate_pages_range(mapping, start, end, &list);
>>>> +
>>>> +       while (!list_empty(&list)) {
>>>> +               page = lru_to_page(&list);
>>>> +               list_del(&page->lru);
>>>> +               if (page_mapped(page))
>>>> +                       goto keep;
>>>> +               if (!trylock_page(page))
>>>> +                       goto keep;
>>>> +               if (unlikely(PageTransHuge(page))) {
>>>> +                       if (split_huge_page_to_list(page, &list))
>>>> +                               goto keep;
>>>> +               }
>>> I don't know the shmem code and the lifecycle of a shm-page, so
>>> genuine questions;
>>> When the try-lock succeeds, should there be a test for PageWriteback()
>>> (page skipped if true)?  Also, does page->mapping need to be tested
>>> for NULL to prevent races with deletion from the page-cache?
>> I failed to envisage it. I should have considered both these conditions
>> here. BTW, I am just thinking about why we shouldn't use
>> reclaim_pages(page_list) function here with an extra set_page_dirty() on
>> a page that is isolated? It just call the shrink_page_list() where all
>> these conditions are properly handled. What is your opinion here?
> Should be possible to use reclaim_pages() (I haven't look closely).
> It might actually be good to use this function, as will do some
> congestion throttling.  Although it will always try to unmap
> pages (note: your page_mapped() test is 'unstable' as done without the
> page locked), so might give behaviour you want to avoid.

page_mapped can be true between isolate and then asking for reclaim of
it through reclaim_pages(), and then can be unmapped there. Thanks for
pointing it out.

BTW, the posix_fadvise man pages[1] doesn't talk about any restrictions
with the mapped pages. If so, Am I allowed to even unmap the pages when
called FADV_DONTNEED on the file (agree for mapped, we can rely on
MADV_DONTNEED too)?

[1]https://man7.org/linux/man-pages/man2/posix_fadvise.2.html

> Note: reclaim_pages() is already used for madvise(PAGEOUT).  The shmem
> code would need to prepare page(s) to help shrink_page_list() to make
> progress (see madvise.c:madvise_cold_or_pageout_pte_range()).
> 
> Taking a step back; is fadvise(DONTNEED) really needed/wanted?  Yes,
> you gave a usecase (which I cut from this thread in my earlier reply),
> but I'm not familiar with various shmem uses to know if this feature
> is needed.  Someone else will need to answer this.

Actually I needed this for the use case mentioned. And regarding the
various use cases, I encountered that GEM buffers for display/graphics
are using the shmem buffers.
drivers/gpu/drm/i915/gem/i915_gem_shmem.c
