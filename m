Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9729B5B12E9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 05:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiIHD25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 23:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiIHD2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 23:28:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CA3A4B3B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 20:28:54 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MNPcQ4nQCzNm4t;
        Thu,  8 Sep 2022 11:24:22 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 8 Sep 2022 11:28:53 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 8 Sep 2022 11:28:52 +0800
Subject: Re: [PATCH] mm/huge_memory: prevent THP_ZERO_PAGE_ALLOC increased
 twice
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20220905133813.2253703-1-liushixin2@huawei.com>
 <20220905130728.1e814d185b189faece6f2c2f@linux-foundation.org>
 <a694528c-f572-c651-24b3-77915053f992@huawei.com>
 <20220907163532.413d52275e8a8d865e9321d2@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <6c0aeb6c-0dcc-2abb-d6af-559ff881d289@huawei.com>
Date:   Thu, 8 Sep 2022 11:28:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20220907163532.413d52275e8a8d865e9321d2@linux-foundation.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/8 7:35, Andrew Morton wrote:
> On Tue, 6 Sep 2022 09:52:23 +0800 Liu Shixin <liushixin2@huawei.com> wrote:
>
>> On 2022/9/6 4:07, Andrew Morton wrote:
>>> On Mon, 5 Sep 2022 21:38:13 +0800 Liu Shixin <liushixin2@huawei.com> wrote:
>>>
>>>> If two or more threads call get_huge_zero_page concurrently, THP_ZERO_PAGE_ALLOC
>>>> may increased two or more times. But actually, this should only count
>>>> as once since the extra zero pages has been freed.
>>> Well, for better of for worse,
>>> Documentation/admin-guide/mm/transhuge.rst says
>>>
>>> thp_zero_page_alloc
>>> 	is incremented every time a huge zero page is
>>> 	successfully allocated. It includes allocations which where
>>> 	dropped due race with other allocation. Note, it doesn't count
>>> 	every map of the huge zero page, only its allocation.
>>>
>>> If you think this interprtation should be changed then please explain
>>> why, and let's be sure to update the documentation accordingly.
>>>
>>> .
>> Thanks for your explanation. I misunderstood the meaning of thp_zero_page_alloc before.
>> Although the rules are clearly explained in the documentation, I think that this variable
>> should only incremented when a huge zero page used for thp is successfully allocated and
>> the pages dropped due race should skip increment. It seems strange to count in all allocations.
>>
>> If there's something I still misunderstand, please point it out, thanks.
> It seems strange to me also.  Perhaps there's a rationale buried in the
> git and mailing list history.
>
> .
I didn't find previous discussion about this point. I update document in v2.
Kirill, what do you think about this change?

https://lore.kernel.org/linux-mm/20220908035533.2186159-1-liushixin2@huawei.com/

