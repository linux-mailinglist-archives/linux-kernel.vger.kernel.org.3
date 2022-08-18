Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB10597B41
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 04:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242637AbiHRBzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 21:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242167AbiHRBzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 21:55:36 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A032520A1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 18:55:35 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M7SZ45yPbzlVj4;
        Thu, 18 Aug 2022 09:52:28 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 09:55:33 +0800
Subject: Re: [PATCH 4/6] mm: hugetlb_vmemmap: add missing smp_wmb() before
 set_pte_at()
To:     "Yin, Fengwei" <fengwei.yin@intel.com>,
        Muchun Song <muchun.song@linux.dev>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220816130553.31406-1-linmiaohe@huawei.com>
 <20220816130553.31406-5-linmiaohe@huawei.com>
 <D8C00BDA-160D-40CE-AFBD-9488F85E76CE@linux.dev>
 <ea67ab10-667e-f361-b80f-dafb13da4808@huawei.com>
 <0EAF1279-6A1C-41FA-9A32-414C36B3792A@linux.dev>
 <019c1272-9d01-9d51-91a0-2d656b25c318@intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <18adbf89-473e-7ba6-9a2b-522e1592bdc6@huawei.com>
Date:   Thu, 18 Aug 2022 09:55:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <019c1272-9d01-9d51-91a0-2d656b25c318@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

On 2022/8/18 9:14, Yin, Fengwei wrote:
> 
> 
> On 8/17/2022 7:21 PM, Muchun Song wrote:
>>
>>
>>> On Aug 17, 2022, at 16:41, Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>
>>> On 2022/8/17 10:53, Muchun Song wrote:
>>>>
>>>>
>>>>> On Aug 16, 2022, at 21:05, Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>>>
>>>>> The memory barrier smp_wmb() is needed to make sure that preceding stores
>>>>> to the page contents become visible before the below set_pte_at() write.
>>>>
>>>> I’m not sure if you are right. I think it is set_pte_at()’s responsibility.
>>>
>>> Maybe not. There're many call sites do the similar things:
>>>
>>> hugetlb_mcopy_atomic_pte
>>> __do_huge_pmd_anonymous_page
>>> collapse_huge_page
>>> do_anonymous_page
>>> migrate_vma_insert_page
>>> mcopy_atomic_pte
>>>
>>> Take do_anonymous_page as an example:
>>>
>>> 	/*
>>> 	 * The memory barrier inside __SetPageUptodate makes sure that
>>> 	 * preceding stores to the page contents become visible before
>>> 	 * the set_pte_at() write.
>>> 	 */
>>> 	__SetPageUptodate(page);
>>
>> IIUC, the case here we should make sure others (CPUs) can see new page’s
>> contents after they have saw PG_uptodate is set. I think commit 0ed361dec369
>> can tell us more details.
>>
>> I also looked at commit 52f37629fd3c to see why we need a barrier before
>> set_pte_at(), but I didn’t find any info to explain why. I guess we want
>> to make sure the order between the page’s contents and subsequent memory
>> accesses using the corresponding virtual address, do you agree with this?
> This is my understanding also. Thanks.

That's also my understanding. Thanks both.

Thanks,
Miaohe Lin

