Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DF3590C0B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 08:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbiHLGks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 02:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHLGkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 02:40:46 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37EF5B78F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 23:40:43 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4M3vCj56j2zGpTL;
        Fri, 12 Aug 2022 14:39:13 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 12 Aug 2022 14:40:40 +0800
Subject: Re: Linux 5.19 __NR_move_pages failed for hugepage
To:     "Wang, Haiyue" <haiyue.wang@intel.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>
References: <BYAPR11MB3495837E180867B47E551EFCF7649@BYAPR11MB3495.namprd11.prod.outlook.com>
 <d3966b09-ce41-9e92-e676-262e84b8e2e1@huawei.com>
 <BYAPR11MB349577B5D98EF6748CDE8873F7679@BYAPR11MB3495.namprd11.prod.outlook.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <91da2c3b-96f1-bb03-8fff-4c38f31cb9be@huawei.com>
Date:   Fri, 12 Aug 2022 14:40:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <BYAPR11MB349577B5D98EF6748CDE8873F7679@BYAPR11MB3495.namprd11.prod.outlook.com>
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

On 2022/8/12 11:04, Wang, Haiyue wrote:
>> -----Original Message-----
>> From: Miaohe Lin <linmiaohe@huawei.com>
>> Sent: Friday, August 12, 2022 09:59
>> To: Wang, Haiyue <haiyue.wang@intel.com>
>> Cc: akpm@linux-foundation.org; Linux-MM <linux-mm@kvack.org>; linux-kernel <linux-
>> kernel@vger.kernel.org>; Naoya Horiguchi <naoya.horiguchi@linux.dev>; David Hildenbrand
>> <david@redhat.com>
>> Subject: Re: Linux 5.19 __NR_move_pages failed for hugepage
>>
>> On 2022/8/11 16:01, Wang, Haiyue wrote:
>>> Hi Miaohe,
>>>
>>>
>>
>> Hi Haiyue,
>>
>> Many thanks for your report and debug.
>>
>>>
>>> When I call "*syscall (__NR_move_pages, 0, n_pages, ptr, 0, status, 0)*" to get the huge page node
>>>
>>> information, it is failed with '-2' returned in 'status' array.
>>>
>>>
>>>
>>> After some debug, I found that "*follow_huge_pud*" will return NULL if '*FOLL_GET*' is set.
>>>
>>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e66f17ff71772b209eed39de
>> 35aaa99ba819c93d
>> <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e66f17ff71772b209eed39d
>> e35aaa99ba819c93d>
>>>
>>>
>>>
>>> This will make your patch doesn't work for huge page.
>>>
>>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4cd614841c06338a087769ee
>> 3cfa96718784d1f5
>> <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4cd614841c06338a087769e
>> e3cfa96718784d1f5>
>>>
>>
>> Supporting of '*FOLL_GET*' in follow_huge_pud is introduced via the below commit:
>>
>> https://lore.kernel.org/all/20220714042420.1847125-9-
>> naoya.horiguchi@linux.dev/T/#mb3c83df087fba454b7b4ea32227fb8775ca70081
>>
>> But that's still not perfect yet. For s390 version of follow_huge_pud, FOLL_GET is still not supported.
>> And pgd level
>> hugepage doesn't support FOLL_GET now.
>>
>>>
>>>
>>> Not sure you know this issue or not, just share my debug information.
>>
>> I'm not sure whether it's better to revert my above "problematic" patch first then add it back when
>> all hugetlb pages support FOLL_GET.
>> Or we could just live with it? Any thoughts?
>>
> 
> TBH, the issue is more complicated than I think. :-(
> 
> Looks like only '[PATCH v7 5/8] mm, hwpoison: set PG_hwpoison for busy hugetlb pages' will be
> backported to 5.19 ? Only this patch has "Fixes:" tag. If so, it will break 5.19.

If you want to mitigate the problem of __NR_move_pages failing for hugepage, "[PATCH v7 2/8] mm/hugetlb:
make pud_huge() and follow_huge_pud() aware of non-present pud entry" could be backported to 5.19.

> 
> I just run VPP 'https://fd.io/' to find the error message about huge page allocation
> after I switched from 5.18 to 5.19.

Do you mean the reported problem is found by VPP? Anyway, you can send a patch to fix the problem if you like. :)
I will try fixing it if requested of course (but I'm not sure how to fix it yet).

Thanks,
Miaohe Lin

