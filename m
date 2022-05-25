Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BA75336D3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 08:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244178AbiEYGkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 02:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbiEYGkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 02:40:47 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AEB527E9
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 23:40:43 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L7Lz24Nf5zjWy0;
        Wed, 25 May 2022 14:39:58 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 25 May 2022 14:40:40 +0800
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
 <20220525043233.GA808704@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <dd9ac56b-c50a-6c6f-339b-50c347f601b4@huawei.com>
Date:   Wed, 25 May 2022 14:40:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220525043233.GA808704@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/25 12:32, HORIGUCHI NAOYA(堀口 直也) wrote:
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
>> ---
> 
> ...
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
> 
> I'm not familiar with folio yet and might miss some basic thing,
> but is it OK to decrement by one instead of folio_nr_pages()?

info->swapped is also decremented by one in shmem_swapin_folio(). In fact, no huge page
swapin is supported yet (this is also true for non-shmem case). So I think info->swapped--
should be OK. Or am I miss something?

> 
> Thanks,
> Naoya Horiguchi

Many thanks for review and comment! It's really helpful! :)

> 

