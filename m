Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDBA5749E4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiGNJ77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiGNJ74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:59:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A571DE29
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:59:55 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lk8zd3qkgzhZ0n;
        Thu, 14 Jul 2022 17:57:17 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 17:59:53 +0800
Subject: Re: [PATCH] mm/hugetlb: avoid corrupting page->mapping in
 hugetlb_mcopy_atomic_pte
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <mike.kravetz@oracle.com>, <songmuchun@bytedance.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>
References: <20220712130542.18836-1-linmiaohe@huawei.com>
 <20220713102357.8328614813db01b569650ffd@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <a47922cf-eb30-1ad9-fc96-1896254564ef@huawei.com>
Date:   Thu, 14 Jul 2022 17:59:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220713102357.8328614813db01b569650ffd@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/14 1:23, Andrew Morton wrote:
> On Tue, 12 Jul 2022 21:05:42 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> In MCOPY_ATOMIC_CONTINUE case with a non-shared VMA, pages in the page
>> cache are installed in the ptes. But hugepage_add_new_anon_rmap is called
>> for them mistakenly because they're not vm_shared. This will corrupt the
>> page->mapping used by page cache code.
> 
> Well that sounds bad.  And theories on why this has gone unnoticed for
> over a year?  I assume this doesn't have coverage in our selftests?

As discussed in another thread, when minor fault handling is proposed, only
VM_SHARED vma is expected to be supported. And the test case is also missing.

Thanks.

> 
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -6038,7 +6038,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>>  	if (!huge_pte_none_mostly(huge_ptep_get(dst_pte)))
>>  		goto out_release_unlock;
>>  
>> -	if (vm_shared) {
>> +	if (page_in_pagecache) {
>>  		page_dup_file_rmap(page, true);
>>  	} else {
>>  		ClearHPageRestoreReserve(page);
>> -- 
>> 2.23.0
> .
> 

