Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F2E55A670
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 05:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbiFYDRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 23:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiFYDRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 23:17:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618BC49B52
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 20:17:29 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LVJz21KbLzkWVj;
        Sat, 25 Jun 2022 11:15:42 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 25 Jun 2022 11:17:26 +0800
Subject: Re: [PATCH 02/16] mm/huge_memory: access vm_page_prot with READ_ONCE
 in remove_migration_pmd
To:     Zach O'Keefe <zokeefe@google.com>
CC:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        <akpm@linux-foundation.org>, <shy828301@gmail.com>,
        <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220622170627.19786-1-linmiaohe@huawei.com>
 <20220622170627.19786-3-linmiaohe@huawei.com>
 <20220623031401.wdyt5ylin4aijzhh@box.shutemov.name>
 <7ee4a597-d7cb-f387-5613-f51b17262745@huawei.com>
 <YrYFM+xKu4Q7XJxz@google.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <ec983c29-8879-6562-5632-10c6fe5f8a11@huawei.com>
Date:   Sat, 25 Jun 2022 11:17:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YrYFM+xKu4Q7XJxz@google.com>
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

On 2022/6/25 2:40, Zach O'Keefe wrote:
> On 23 Jun 20:03, Miaohe Lin wrote:
>> On 2022/6/23 11:14, Kirill A. Shutemov wrote:
>>> On Thu, Jun 23, 2022 at 01:06:13AM +0800, Miaohe Lin wrote:
>>>> vma->vm_page_prot is read lockless from the rmap_walk, it may be updated
>>>> concurrently. Using READ_ONCE to prevent the risk of reading intermediate
>>>> values.
>>>
>>> Have you checked all other vm_page_prot reads that they hold mmap_lock?
>>
>> I took a glance when I made this patch.
>>
>>>
>>> I think the right fix would be to provide a helper to read vm_page_prot
>>> which does READ_ONCE() and use it everywhere. This seems more sustainable.
>>>
>>
>> This patch is inspired from the below commit
>>   6d2329f8872f ("mm: vm_page_prot: update with WRITE_ONCE/READ_ONCE")
>>
>> It changed all the places that need to use READ_ONCE. But remove_migration_pmd
>> is missed due to it's introduced later. It looks fine to add a helper to read
>> vm_page_prot which does READ_ONCE() but READ_ONCE is unneeded while under the
>> mmap_lock, so might it be a little overkill to add a helper because the helper
>> is used iff mmap_lock is not held?
>>
>> Thanks.
> 
> IMO adding the READ_ONCE() as proposed in fine. Adding a helper to be called
> dependent on locking context still requires the caller / dev to know what the
> locking context is - so I don't think it provides much benefit.

I tend to agree with Zach. Thanks!

> .
> 

