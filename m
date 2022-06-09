Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CC75444E9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 09:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237422AbiFIHjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 03:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbiFIHjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 03:39:04 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E08120B2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 00:39:01 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LJbX51KV6z1K9GW;
        Thu,  9 Jun 2022 15:37:09 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 15:38:58 +0800
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_-next=5d_mm=ef=bc=9afix_build_error_of_def?=
 =?UTF-8?Q?ined_but_not_used?=
To:     Guan Jing <guanjing6@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
References: <20220609050028.28645-1-guanjing6@huawei.com>
 <20220609052420.GA1452839@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <5ae24232-91c0-99f5-48cc-beea1a16e426@huawei.com>
Date:   Thu, 9 Jun 2022 15:38:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220609052420.GA1452839@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2022/6/9 13:24, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Thu, Jun 09, 2022 at 01:00:28PM +0800, Guan Jing wrote:
>> If CONFIG_HUGETLB_PAGE is not set and CONFIG_FS_DAX=y.
>> Use command "make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-" to
>> build, will fail:
>>
>> mm/memory-failure.c:568:13: error: ‘collect_procs_fsdax’ defined
>> but not used [-Werror=unused-function]
>> 	static void collect_procs_fsdax(struct page *page,
>>              ^~~~~~~~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
>> make[1]: *** [mm/memory-failure.o] Error 1
>> make[1]: *** Waiting for unfinished jobs....
>> make: *** [mm] Error 2
>> make: *** Waiting for unfinished jobs....
>>
>> so extending "#ifdef CONFIG_HUGETLB_PAG" to cover
>> collect_procs_fsdax() would be a simple resolution.
> 
> Thank you for reporting. I think that collect_procs_fsdax() seems to not
> depend on hugetlb, so probably mf_dax_kill_procs() should be defined outside
> "#ifdef CONFIG_HUGETLB_PAGE"?

I tend to agree with Naoya. CONFIG_FS_DAX should not depend on CONFIG_HUGETLB_PAGE.
There are some functions, e.g. mf_generic_kill_procs, are under the CONFIG_HUGETLB_PAGE
unnecessarily. Those should be cleaned up altogether.

Thanks!

> 
> Thanks,
> Naoya Horiguchi
> 
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Fixes: 143ac5cd7289 ("mm: introduce mf_dax_kill_procs() for fsdax case")
>> Signed-off-by: Guan Jing <guanjing6@huawei.com>
>> ---
>>  mm/memory-failure.c | 56 ++++++++++++++++++++++-----------------------
>>  1 file changed, 28 insertions(+), 28 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 545f402c4890..952f117e4584 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -561,34 +561,6 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
>>  	i_mmap_unlock_read(mapping);
>>  }
>>  
>> -#ifdef CONFIG_FS_DAX
>> -/*
>> - * Collect processes when the error hit a fsdax page.
>> - */
>> -static void collect_procs_fsdax(struct page *page,
>> -		struct address_space *mapping, pgoff_t pgoff,
>> -		struct list_head *to_kill)
>> -{
>> -	struct vm_area_struct *vma;
>> -	struct task_struct *tsk;
>> -
>> -	i_mmap_lock_read(mapping);
>> -	read_lock(&tasklist_lock);
>> -	for_each_process(tsk) {
>> -		struct task_struct *t = task_early_kill(tsk, true);
>> -
>> -		if (!t)
>> -			continue;
>> -		vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
>> -			if (vma->vm_mm == t->mm)
>> -				add_to_kill(t, page, pgoff, vma, to_kill);
>> -		}
>> -	}
>> -	read_unlock(&tasklist_lock);
>> -	i_mmap_unlock_read(mapping);
>> -}
>> -#endif /* CONFIG_FS_DAX */
>> -
>>  /*
>>   * Collect the processes who have the corrupted page mapped to kill.
>>   */
>> @@ -1540,6 +1512,34 @@ static int try_to_split_thp_page(struct page *page, const char *msg)
>>  }
>>  
>>  #ifdef CONFIG_HUGETLB_PAGE
>> +#ifdef CONFIG_FS_DAX
>> +/*
>> + * Collect processes when the error hit a fsdax page.
>> + */
>> +static void collect_procs_fsdax(struct page *page,
>> +		struct address_space *mapping, pgoff_t pgoff,
>> +		struct list_head *to_kill)
>> +{
>> +	struct vm_area_struct *vma;
>> +	struct task_struct *tsk;
>> +
>> +	i_mmap_lock_read(mapping);
>> +	read_lock(&tasklist_lock);
>> +	for_each_process(tsk) {
>> +		struct task_struct *t = task_early_kill(tsk, true);
>> +
>> +		if (!t)
>> +			continue;
>> +		vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
>> +			if (vma->vm_mm == t->mm)
>> +				add_to_kill(t, page, pgoff, vma, to_kill);
>> +		}
>> +	}
>> +	read_unlock(&tasklist_lock);
>> +	i_mmap_unlock_read(mapping);
>> +}
>> +#endif /* CONFIG_FS_DAX */
>> +
>>  /*
>>   * Called from hugetlb code with hugetlb_lock held.
>>   *
>> -- 
>> 2.17.1

