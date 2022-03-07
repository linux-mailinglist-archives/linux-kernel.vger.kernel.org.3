Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772DD4D01D8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241214AbiCGOvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243397AbiCGOvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:51:31 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CDA85BE2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 06:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646664635; x=1678200635;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g3MS51Wrb/eQYTnuO0rlbMIdHyQkKGH4tCbFKOZOOtc=;
  b=jCuabJn3EGT4QdiJtsQFnrhUJrwdxUV97fO9/++2toMlAsPLtO/eIAZS
   X/1ZlZRZyDZevQY5NKWeopGjgcv1GNGxRUgM67Kmt4LpFL5i5d0ppOr3o
   zD6tTZQmnowmaBkScE9Osmkg4VVAuLbevNTK4yiXJMGF8y+bsG+/3naRe
   s=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 07 Mar 2022 06:50:35 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 06:50:35 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 7 Mar 2022 06:50:34 -0800
Received: from [10.216.62.152] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Mon, 7 Mar 2022
 06:50:30 -0800
Message-ID: <cc194110-2467-47d3-9868-89e092a542e9@quicinc.com>
Date:   Mon, 7 Mar 2022 20:20:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v4] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED for
 shmem
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>
CC:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        <markhemm@googlemail.com>, Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1644572051-24091-1-git-send-email-quic_charante@quicinc.com>
 <CAJuCfpGAaqZv68q-jrBuFArq+6wKBsNys+b=eaBr+03KZf-EHA@mail.gmail.com>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <CAJuCfpGAaqZv68q-jrBuFArq+6wKBsNys+b=eaBr+03KZf-EHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Suren for your comments!!

On 3/5/2022 2:00 AM, Suren Baghdasaryan wrote:
>> +               test_and_clear_page_young(page);
>> +               SetPageDirty(page);
> I asked Hugh about how clean shmem pages are handled during normal
> reclaim and his reply is:
> 
> Clean shmem pages are rare: they correspond to where a hole in a
> sparse file has been mapped read-only to userspace. Those get dropped
> from pagecache without being written to swap, when memory pressure
> comes to reclaim them. Otherwise, shmem pages are dirty: as soon as
> they've been read from swap and identified as shmem (moved from swap
> cache to page cache), that swap is freed so they're no longer clean
> representations of anything on swap. (Our use of "swap cache" and/or
> "page cache" may have inconsistencies in what I've written: sometimes
> we use them interchangeably, sometimes we're making a distinction.)
> 
> So, IIUC his explanation, you don't really need to mark clean shmem
> pages dirty for FADV_DONTNEED since normal reclaim does not do that
> either.

Thanks for the details here. Will change it in the next patch.


> 
>> +               list_add(&page->lru, list);
>> +               if (need_resched()) {
>> +                       xas_pause(&xas);
>> +                       cond_resched_rcu();
>> +               }
>> +       }
>> +       rcu_read_unlock();
>> +}
>> +
>> +static int shmem_fadvise_dontneed(struct address_space *mapping, loff_t start,
>> +                               loff_t end)
>> +{
>> +       LIST_HEAD(list);
>> +
>> +       if (!shmem_mapping(mapping))
>> +               return -EINVAL;
>> +
>> +       if (!total_swap_pages)
>> +               return 0;
>> +
>> +       lru_add_drain();
>> +       shmem_isolate_pages_range(mapping, start, end, &list);
>> +       reclaim_pages(&list);
>> +
>> +       return 0;
>> +}
>> +
>> +static int shmem_fadvise_willneed(struct address_space *mapping,
>> +                                pgoff_t start, pgoff_t long end)
>> +{
>> +       struct page *page;
>> +       pgoff_t index;
>> +
>> +       xa_for_each_range(&mapping->i_pages, index, page, start, end) {
>> +               if (!xa_is_value(page))
>> +                       continue;
>> +               page = shmem_read_mapping_page(mapping, index);
>> +               if (!IS_ERR(page))
>> +                       put_page(page);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int shmem_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
>> +{
>> +       loff_t endbyte;
>> +       pgoff_t start_index;.
>> +       pgoff_t end_index;
>> +       struct address_space *mapping;
>> +       int ret = 0;
>> +
>> +       mapping = file->f_mapping;
>> +       if (!mapping || len < 0)
>> +               return -EINVAL;
>> +
>> +       endbyte = (u64)offset + (u64)len;
>> +       if (!len || endbyte < len)
>> +               endbyte = -1;
>> +       else
>> +               endbyte--;
> The above block is exactly the same as in
> https://elixir.bootlin.com/linux/latest/source/mm/fadvise.c#L73 with
> the exception that generic_fadvise has comments with explanations of
> this math. You might consider consolidating them into a helper
> function to calculate the endbyte.


Yes, I simply copy pasted these. Will try to consolidate them into one.

> 
