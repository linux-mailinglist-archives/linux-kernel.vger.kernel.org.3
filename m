Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E322B575A18
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 05:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241084AbiGOD4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 23:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGOD4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 23:56:44 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B9565583
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 20:56:43 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LkctV5XsQzkX3S;
        Fri, 15 Jul 2022 11:54:26 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Jul 2022 11:56:41 +0800
Subject: Re: [PATCH] mm/hugetlb: avoid corrupting page->mapping in
 hugetlb_mcopy_atomic_pte
To:     Peter Xu <peterx@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <mike.kravetz@oracle.com>, <songmuchun@bytedance.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220712130542.18836-1-linmiaohe@huawei.com>
 <20220713102357.8328614813db01b569650ffd@linux-foundation.org>
 <a47922cf-eb30-1ad9-fc96-1896254564ef@huawei.com>
 <YtA7svbn4MtuT7qJ@xz-m1.local>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <402ae708-4c86-8feb-75c4-9339e1deac3b@huawei.com>
Date:   Fri, 15 Jul 2022 11:56:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YtA7svbn4MtuT7qJ@xz-m1.local>
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

On 2022/7/14 23:52, Peter Xu wrote:
> On Thu, Jul 14, 2022 at 05:59:53PM +0800, Miaohe Lin wrote:
>> On 2022/7/14 1:23, Andrew Morton wrote:
>>> On Tue, 12 Jul 2022 21:05:42 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>
>>>> In MCOPY_ATOMIC_CONTINUE case with a non-shared VMA, pages in the page
>>>> cache are installed in the ptes. But hugepage_add_new_anon_rmap is called
>>>> for them mistakenly because they're not vm_shared. This will corrupt the
>>>> page->mapping used by page cache code.
>>>
>>> Well that sounds bad.  And theories on why this has gone unnoticed for
>>> over a year?  I assume this doesn't have coverage in our selftests?
>>
>> As discussed in another thread, when minor fault handling is proposed, only
>> VM_SHARED vma is expected to be supported. And the test case is also missing.
> 
> Yes, after this patch applied it'll be great to have the test case covering
> private mappings too.
> 
> It's just that it'll be a bit more than setting test_uffdio_minor=1 for
> "hugetlb" test.  In hugetlb_allocate_area() we'll need to setup the alias
> too for !shared case, it'll be a bit challenging since currently we're
> using anonymous hugetlb mappings for private tests, and I'm not sure
> whether we'll need the hugetlb path back just like what we have with
> "hugetlb_shared" tests.

I'm afraid not. When minor fault handling is proposed, only VM_SHARED vma is
expected to be supported. It seems it's hard to image how one might benefit
from using it with a private mapping. But I'm not sure as I'm still a layman
in userfaultfd now. Any further suggestions?

> 

Thanks!
