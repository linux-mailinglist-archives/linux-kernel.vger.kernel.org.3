Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376164D163D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343605AbiCHL3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbiCHL3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:29:11 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5681025E99
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:28:14 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KCXy42hMRzbc9v;
        Tue,  8 Mar 2022 19:23:24 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 19:28:11 +0800
Subject: Re: [PATCH 1/4] mm/memory-failure.c: fix race with changing page
 compound again
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Mike Kravetz <mike.kravetz@oracle.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220228140245.24552-1-linmiaohe@huawei.com>
 <20220228140245.24552-2-linmiaohe@huawei.com>
 <20220304082624.GA3778609@hori.linux.bs1.fc.nec.co.jp>
 <79f79813-bb9a-bfff-0837-a24d14da0b19@oracle.com>
 <999a0f88-9465-0c93-e922-8aa80fa64f81@huawei.com>
 <20220307070155.GA591088@hori.linux.bs1.fc.nec.co.jp>
 <89af9b3f-1ab9-15db-d476-574271ce8292@oracle.com>
 <20220308065658.GA610534@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <63c118d0-da95-4b43-3d1b-1d69f8241801@huawei.com>
Date:   Tue, 8 Mar 2022 19:28:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220308065658.GA610534@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2022/3/8 14:56, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Mon, Mar 07, 2022 at 11:07:32AM -0800, Mike Kravetz wrote:
> ...
>>>
>>>> +
>>>> +       /**
>>>> +        * The page could have changed compound pages due to race window.
>>>> +        * If this happens just bail out.
>>>> +        */
>>>> +       if (!PageHuge(p) || compound_head(p) != head) {
>>>> +               action_result(pfn, MF_MSG_DIFFERENT_COMPOUND, MF_IGNORED);
>>>> +               res = -EBUSY;
>>>> +               goto out;
>>>> +       }
>>>
>>> Let me have one comment on the diff. The result code MF_MSG_DIFFERENT_COMPOUND
>>> might not fit when PageHuge is false in the check (because it's no longer a
>>> compound page).  Maybe you may invent another result code, or changes
>>> MF_MSG_DIFFERENT_COMPOUND (for example) to MF_MSG_DIFFERENT_PAGE_SIZE?
>>>
>>
>> Suppose we do encounter this race.  Also, suppose p != head.
>> At the beginning of memory_failure_hugetlb, we do:
>>
>> struct page *head = compound_head(p);
>> ...
>> if (TestSetPageHWPoison(head))
>>
>> So, it could be that we set Poison in the 'head' page but the error was really
>> in another page.  Is that correct?
>>
>> Now with the race, head is not a huge page and the pages could even be on
>> buddy.  Does this mean we could have poison set on the wrong page in buddy?
> 
> Correct, the race might be rare, but this needs a fix.
> I think that setting PageHWPoison first (before taking refcount and page lock)
> is the root of all related problems.  This behavior came from the original
> concept in hwpoison that preventing consumption of corrupted data is the first
> priority.  But now I think that this makes no sense if we have this kind of bugs.
> 
> I'll try to write a patch for this (I only fix memory_failure_hugetlb() first,
> but generic path should be fixed later).
> Thank you for pointing out.

Many thanks for both of you for doing this. :)

> 
> - Naoya Horiguchi
> 

