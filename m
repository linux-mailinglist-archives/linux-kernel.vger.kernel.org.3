Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E617452FA59
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 11:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242078AbiEUJei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 05:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238242AbiEUJef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 05:34:35 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674F564700
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 02:34:32 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L4z0c3TbGz1JC6s;
        Sat, 21 May 2022 17:33:04 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 21 May 2022 17:34:28 +0800
Subject: Re: [PATCH v4 4/5] mm/shmem: fix infinite loop when swap in shmem
 error at swapoff time
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hughd@google.com" <hughd@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        "david@redhat.com" <david@redhat.com>,
        "surenb@google.com" <surenb@google.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "rcampbell@nvidia.com" <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220519125030.21486-1-linmiaohe@huawei.com>
 <20220519125030.21486-5-linmiaohe@huawei.com>
 <20220520063433.GA584983@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <0f6dc98b-88f4-c0c9-eb7b-5356ad0e08b1@huawei.com>
Date:   Sat, 21 May 2022 17:34:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220520063433.GA584983@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/20 14:34, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Thu, May 19, 2022 at 08:50:29PM +0800, Miaohe Lin wrote:
>> When swap in shmem error at swapoff time, there would be a infinite loop
>> in the while loop in shmem_unuse_inode(). It's because swapin error is
>> deliberately ignored now and thus info->swapped will never reach 0. So
>> we can't escape the loop in shmem_unuse().
>>
>> In order to fix the issue, swapin_error entry is stored in the mapping
>> when swapin error occurs. So the swapcache page can be freed and the
>> user won't end up with a permanently mounted swap because a sector is
>> bad. If the page is accessed later, the user process will be killed
>> so that corrupted data is never consumed. On the other hand, if the
>> page is never accessed, the user won't even notice it.
>>
>> Reported-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Hi Miaohe,
> 
> Thank you for the update.  I might miss something, but I still see the same
> problem (I checked it on mm-everything-2022-05-19-00-03 + this patchset).

Hi Naoya,
I reproduce the issue in the linux-next-next-20220520 version. And I found even if
I *do not inject the swapin error*, the deadloop still occurs. After investigating the
code for a long while, I found the root cause:

diff --git a/mm/shmem.c b/mm/shmem.c
index d55dd972023a..6d23ed4d23cb 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1182,7 +1182,7 @@ static int shmem_find_swap_entries(struct address_space *mapping,
                if (swp_type(entry) != type)
                        continue;

-               indices[ret] = xas.xa_index;
+               indices[ret++] = xas.xa_index;
                if (!folio_batch_add(fbatch, folio))
                        break;

The origin code does not increment the ret value when a folio is found. I will send a patch
to fix this next week. Thanks! :)

BTW: With the above change, deadloop doesn't occur when swapin error is injected. I will take
a more close look at next week.

Thanks!

> 
> This patch has the effect to change the return value of shmem_swapin_folio(),
> -EIO (without this patch) to -EEXIST (with this patch).
> But shmem_unuse_swap_entries() checks neither, so no change from caller's view point.
> Maybe breaking in errors (rather than ENOMEM) in for loop in shmem_unuse_swap_entries()
> solves the issue?  I briefly checked with the below change, then swapoff can return
> with failure.
> 
> @@ -1222,7 +1222,7 @@ static int shmem_unuse_swap_entries(struct inode *inode,
>                         folio_put(folio);
>                         ret++;
>                 }
> -               if (error == -ENOMEM)
> +               if (error < 0)
>                         break;
>                 error = 0;
>         }
> 
>> ---
>>  mm/shmem.c | 39 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index d3c7970e0179..d55dd972023a 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -1175,6 +1175,10 @@ static int shmem_find_swap_entries(struct address_space *mapping,
>>  			continue;
>>  
>>  		entry = radix_to_swp_entry(folio);
>> +		/*
>> +		 * swapin error entries can be found in the mapping. But they're
>> +		 * deliberately ignored here as we've done everything we can do.
>> +		 */
>>  		if (swp_type(entry) != type)
>>  			continue;
>>  
>> @@ -1672,6 +1676,36 @@ static int shmem_replace_page(struct page **pagep, gfp_t gfp,
>>  	return error;
>>  }
>>  
>> +static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
>> +					 struct folio *folio, swp_entry_t swap)
>> +{
>> +	struct address_space *mapping = inode->i_mapping;
>> +	struct shmem_inode_info *info = SHMEM_I(inode);
>> +	swp_entry_t swapin_error;
>> +	void *old;
>> +
>> +	swapin_error = make_swapin_error_entry(&folio->page);
>> +	old = xa_cmpxchg_irq(&mapping->i_pages, index,
>> +			     swp_to_radix_entry(swap),
>> +			     swp_to_radix_entry(swapin_error), 0);
>> +	if (old != swp_to_radix_entry(swap))
>> +		return;
>> +
>> +	folio_wait_writeback(folio);
>> +	delete_from_swap_cache(&folio->page);
>> +	spin_lock_irq(&info->lock);
>> +	/*
>> +	 * Don't treat swapin error folio as alloced. Otherwise inode->i_blocks won't
>> +	 * be 0 when inode is released and thus trigger WARN_ON(inode->i_blocks) in
>> +	 * shmem_evict_inode.
>> +	 */
>> +	info->alloced--;
>> +	info->swapped--;
>> +	shmem_recalc_inode(inode);
>> +	spin_unlock_irq(&info->lock);
>> +	swap_free(swap);
>> +}
>> +
>>  /*
>>   * Swap in the page pointed to by *pagep.
>>   * Caller has to make sure that *pagep contains a valid swapped page.
> 
> (off-topic a little) BTW, the comment on shmem_swapin_folio() still mentions
> *pagep, but maybe it can be updated to *foliop.
> 
> Thanks,
> Naoya Horiguchi
> 
>> @@ -1695,6 +1729,9 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>>  	swap = radix_to_swp_entry(*foliop);
>>  	*foliop = NULL;
>>  
>> +	if (is_swapin_error_entry(swap))
>> +		return -EIO;
>> +
>>  	/* Look it up and read it in.. */
>>  	page = lookup_swap_cache(swap, NULL, 0);
>>  	if (!page) {
>> @@ -1762,6 +1799,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>>  failed:
>>  	if (!shmem_confirm_swap(mapping, index, swap))
>>  		error = -EEXIST;
>> +	if (error == -EIO)
>> +		shmem_set_folio_swapin_error(inode, index, folio, swap);

