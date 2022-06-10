Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6FE545D66
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346838AbiFJH2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346863AbiFJH21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:28:27 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0D133E3B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 00:28:26 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LKCH800nnzDqlB;
        Fri, 10 Jun 2022 15:28:03 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 15:28:24 +0800
Subject: Re: [v3 PATCH 3/7] mm: khugepaged: remove the redundant anon vma
 check
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <vbabka@suse.cz>, <kirill.shutemov@linux.intel.com>,
        <willy@infradead.org>, <akpm@linux-foundation.org>
References: <20220606214414.736109-1-shy828301@gmail.com>
 <20220606214414.736109-4-shy828301@gmail.com>
 <3f485480-9474-4401-bc4f-fb66aac1e591@huawei.com>
Message-ID: <519ec924-483c-aec0-cb84-b33b25ce92b4@huawei.com>
Date:   Fri, 10 Jun 2022 15:28:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <3f485480-9474-4401-bc4f-fb66aac1e591@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

On 2022/6/10 15:23, Miaohe Lin wrote:
> On 2022/6/7 5:44, Yang Shi wrote:
>> The hugepage_vma_check() already checked it, so remove the redundant
>> check.
>>
>> Signed-off-by: Yang Shi <shy828301@gmail.com>
>> ---
>>  mm/khugepaged.c | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index d0f8020164fc..7a5d1c1a1833 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -966,9 +966,6 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>>  		return SCAN_ADDRESS_RANGE;
>>  	if (!hugepage_vma_check(vma, vma->vm_flags))
>>  		return SCAN_VMA_CHECK;
>> -	/* Anon VMA expected */
>> -	if (!vma->anon_vma || !vma_is_anonymous(vma))
>> -		return SCAN_VMA_CHECK;
> 
> Is it possible that hugepage_vma_check returns true due to the shmem check, or file thp check since
> we dropped mmap_lock ? So anon vma is explicitly checked again here?

I just see your discussion with similar problem. Sorry for make noise.

> 
> Thanks!
> 
>>  	return 0;
>>  }
>>  
>>
> 

