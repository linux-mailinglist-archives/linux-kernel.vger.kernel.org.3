Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBF54DD611
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbiCRIZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbiCRIZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:25:51 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C494585978
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 01:24:31 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KKcQZ6QVkz9sg4;
        Fri, 18 Mar 2022 16:20:38 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 16:24:29 +0800
Subject: Re: [PATCH v2 09/11] mm/migration: fix potential page refcounts leak
 in migrate_pages
To:     Feng Tang <feng.tang@intel.com>
CC:     <ziy@nvidia.com>, <baolin.wang@linux.alibaba.com>,
        <ying.huang@intel.com>, <songmuchun@bytedance.com>,
        <apopple@nvidia.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220318070800.GB436@shbuild999.sh.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <4953e998-c088-29f7-e240-d27513bbfc93@huawei.com>
Date:   Fri, 18 Mar 2022 16:24:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220318070800.GB436@shbuild999.sh.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/18 15:08, Feng Tang wrote:
>> In -ENOMEM case, there might be some subpages of fail-to-migrate THPs
>> left in thp_split_pages list. We should move them back to migration
>> list so that they could be put back to the right list by the caller
>> otherwise the page refcnt will be leaked here. Also adjust nr_failed
>> and nr_thp_failed accordingly to make vm events account more accurate.
>  
> We just met a real world case for this when checking a malloc-oom
> issue and our fix is similar with yours :).
> 

Oh, what a coincidence! :)

> So I think you can remove the 'potential' from the patch subject.
> Feel free to add
> 
> Tested-by: Feng Tang <feng.tang@intel.com>
> Reviewed-by: Feng Tang <feng.tang@intel.com>

Many thanks for your test and comment!

> 
> Thanks,
> Feng
> 
>> Fixes: b5bade978e9b ("mm: migrate: fix the return value of migrate_pages()")
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>  mm/migrate.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 63a87ef0996f..97dfd1f4870d 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1438,6 +1438,14 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>  				}
>>  
>>  				nr_failed_pages += nr_subpages;
>> +				/*
>> +				 * There might be some subpages of fail-to-migrate THPs
>> +				 * left in thp_split_pages list. Move them back to migration
>> +				 * list so that they could be put back to the right list by
>> +				 * the caller otherwise the page refcnt will be leaked.
>> +				 */
>> +				list_splice_init(&thp_split_pages, from);
>> +				nr_thp_failed += thp_retry;
>>  				goto out;
>>  			case -EAGAIN:
>>  				if (is_thp)
>> -- 
>> 2.23.0
> 
> .
> 

