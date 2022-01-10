Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF53489BF6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbiAJPOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:14:54 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:9283 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232537AbiAJPOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641827692; x=1673363692;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=jAhOPW5TggcXrIDEgv1JvMUjotEvBmws9U1O6rH07Ng=;
  b=wCYN/7LNQZquoVO/sYjcxs0x/Yg7JFHFEXRkJJOUkxqEll7+Jbr3NG/i
   UzXzaOJG/IX9yLD1UDveUuuOWa2wkvafKDt4xpVSBETVZoWHqcnnhh0V/
   k7w8Avj7A4rq30WujZVyNK4CqT7yzB1tR2rqAACwEYRgqUap8ww/4C7QI
   Q=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Jan 2022 07:14:52 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 07:14:41 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 10 Jan 2022 07:14:39 -0800
Received: from [10.216.41.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 10 Jan
 2022 07:14:35 -0800
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
From:   Charan Teja Kalla <quic_charante@quicinc.com>
Message-ID: <c19b1c9e-6351-6e71-d472-5ccd39885984@quicinc.com>
Date:   Mon, 10 Jan 2022 20:44:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CANe_+UiDXHgPOZoqT9yxLgTwkVmjA7OiXduP1R0qO2vCt=KKWQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks again Mark for the review comments!!

On 1/10/2022 6:06 PM, Mark Hemment wrote:
> On Thu, 6 Jan 2022 at 17:06, Charan Teja Reddy
> <quic_charante@quicinc.com> wrote:
>>
>> From: Charan Teja Reddy <charante@codeaurora.org>
>>
>> Currently fadvise(2) is supported only for the files that doesn't
>> associated with noop_backing_dev_info thus for the files, like shmem,
>> fadvise results into NOP. But then there is file_operations->fadvise()
>> that lets the file systems to implement their own fadvise
>> implementation. Use this support to implement some of the POSIX_FADV_XXX
>> functionality for shmem files.
> ...
>> +static void shmem_isolate_pages_range(struct address_space *mapping, loff_t start,
>> +                               loff_t end, struct list_head *list)
>> +{
>> +       XA_STATE(xas, &mapping->i_pages, start);
>> +       struct page *page;
>> +
>> +       rcu_read_lock();
>> +       xas_for_each(&xas, page, end) {
>> +               if (xas_retry(&xas, page))
>> +                       continue;
>> +               if (xa_is_value(page))
>> +                       continue;
>> +               if (!get_page_unless_zero(page))
>> +                       continue;
>> +               if (isolate_lru_page(page))
>> +                       continue;
> 
> Need to unwind the get_page on failure to isolate.

Will be done.

> 
> Should PageUnevicitable() pages (SHM_LOCK) be skipped?
> (That is, does SHM_LOCK override DONTNEED?)


Should be skipped. Will be done.

> 
> ...
>> +static int shmem_fadvise_dontneed(struct address_space *mapping, loff_t start,
>> +                               loff_t end)
>> +{
>> +       int ret;
>> +       struct page *page;
>> +       LIST_HEAD(list);
>> +       struct writeback_control wbc = {
>> +               .sync_mode = WB_SYNC_NONE,
>> +               .nr_to_write = LONG_MAX,
>> +               .range_start = 0,
>> +               .range_end = LLONG_MAX,
>> +               .for_reclaim = 1,
>> +       };
>> +
>> +       if (!shmem_mapping(mapping))
>> +               return -EINVAL;
>> +
>> +       if (!total_swap_pages)
>> +               return 0;
>> +
>> +       lru_add_drain();
>> +       shmem_isolate_pages_range(mapping, start, end, &list);
>> +
>> +       while (!list_empty(&list)) {
>> +               page = lru_to_page(&list);
>> +               list_del(&page->lru);
>> +               if (page_mapped(page))
>> +                       goto keep;
>> +               if (!trylock_page(page))
>> +                       goto keep;
>> +               if (unlikely(PageTransHuge(page))) {
>> +                       if (split_huge_page_to_list(page, &list))
>> +                               goto keep;
>> +               }
> 
> I don't know the shmem code and the lifecycle of a shm-page, so
> genuine questions;
> When the try-lock succeeds, should there be a test for PageWriteback()
> (page skipped if true)?  Also, does page->mapping need to be tested
> for NULL to prevent races with deletion from the page-cache?

I failed to envisage it. I should have considered both these conditions
here. BTW, I am just thinking about why we shouldn't use
reclaim_pages(page_list) function here with an extra set_page_dirty() on
a page that is isolated? It just call the shrink_page_list() where all
these conditions are properly handled. What is your opinion here?

> 
> ...
>> +
>> +               clear_page_dirty_for_io(page);
>> +               SetPageReclaim(page);
>> +               ret = shmem_writepage(page, &wbc);
>> +               if (ret || PageWriteback(page)) {
>> +                       if (ret)
>> +                               unlock_page(page);
>> +                       goto keep;
>> +               }
>> +
>> +               if (!PageWriteback(page))
>> +                       ClearPageReclaim(page);
>> +
>> +               /*
>> +                * shmem_writepage() place the page in the swapcache.
>> +                * Delete the page from the swapcache and release the
>> +                * page.
>> +                */
>> +               __mod_node_page_state(page_pgdat(page),
>> +                               NR_ISOLATED_ANON + page_is_file_lru(page), compound_nr(page));
>> +               lock_page(page);
>> +               delete_from_swap_cache(page);
>> +               unlock_page(page);
>> +               put_page(page);
>> +               continue;
>> +keep:
>> +               putback_lru_page(page);
>> +               __mod_node_page_state(page_pgdat(page),
>> +                               NR_ISOLATED_ANON + page_is_file_lru(page), compound_nr(page));
>> +       }
> 
> The putback_lru_page() drops the last reference hold this code has on
> 'page'.  Is it safe to use 'page' after dropping this reference?

True. Will correct it in the next revision.

> 
> Cheers,
> Mark
> 
