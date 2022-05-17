Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C5F52A120
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiEQMDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345863AbiEQMDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:03:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA6A4348F
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:03:05 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L2ZSB18ZczGpcx;
        Tue, 17 May 2022 20:00:10 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 20:03:03 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 20:03:03 +0800
Subject: Re: Question about hwpoison handling of 1GB hugepage
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
References: <0af88a11-4dfe-9a4e-7b94-08f12caafcf3@huawei.com>
 <20220403234250.GA2217943@hori.linux.bs1.fc.nec.co.jp>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <eae3ec5d-51ce-db2d-cc0b-f8e1d4310679@huawei.com>
Date:   Tue, 17 May 2022 20:03:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20220403234250.GA2217943@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Naoya,

Is there any progress on memory error handling on 1GB hugepage : )

Thanks,
Liu Shixin

On 2022/4/4 7:42, HORIGUCHI NAOYA(堀口　直也) wrote:
> On Thu, Mar 31, 2022 at 06:56:25PM +0800, Liu Shixin wrote:
>> Hi,
>>
>> Recently, I found a problem with hwpoison 1GB hugepage.
>> I created a process and mapped 1GB hugepage. This process will then fork a
>> child process and write/read this 1GB hugepage. Then I inject hwpoison into
>> this 1GB hugepage. The child process triggers the memory failure and is
>> being killed as expected. After this, the parent process will try to fork a
>> new child process and do the same thing. It is killed again and finally it
>> goes into such an infinite loop. I found this was caused by
>> commit 31286a8484a8 ("mm: hwpoison: disable memory error handling on 1GB hugepage")
> Hello Shixin,
>
> It's little unclear to me about what behavior you are expecting and
> what the infinite loop repeats, could you explain little more about them?
> (I briefly tried to reproduce it, but didn't make it...)
>
>> It looks like there is a bug for hwpoison 1GB hugepage so I try to reproduce
>> the bug described. After trying to revert the patch in an earlier version of
>> the kernel, I reproduce the bug described. Then I try to revert the patch in
>> latest version, and find the bug is no longer reproduced.
>>
>> I compare the code paths of 1 GB hugepage and 2 MB hugepage for second madvise(MADV_HWPOISON),
>> and find that the problem is caused because in gup_pud_range(), pud_none() and
>> pud_huge() both return false and then trigger the bug. But in gup_pmd_range(),
>> the pmd_none() is modified to pmd_present() which will make code return directly.
>> The I find that it is commit 15494520b776 ("mm: fix gup_pud_range") which
>> cause latest version not reproduced. I backport commit 15494520b776 in
>> earlier version and find the bug is no longer reproduced either.
> Thank you for the analysis.
> So this patch might make 31286a8484a8 unnecessary, that's a good news.
>
>> So I'd like to consult that is it the time to revert commit 31286a8484a8?
>> Or if we modify pud_huge to be similar with pmd_huge, is it sufficient?
>>
>> I also noticed there is a TODO comment in memory_failure_hugetlb():
>>     - conversion of a pud that maps an error hugetlb into hwpoison
>>       entry properly works, and
>>     - other mm code walking over page table is aware of pud-aligned
>>       hwpoison entries. 
> These are simply minimum requirements, but might not be sufficient.
> We need testing (with removing 31286a8484a8) to make sure that
> there's no issues on some corner cases.
> (I start to extend existing hugetlb-related testcases to 1GB ones.)
>
> Thanks,
> Naoya Horiguchi
>
>> I'm not sure whether the above fix are sufficient, so is there anything else need
>> to analysis that I haven't considered?

