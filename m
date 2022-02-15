Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4554B67B7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbiBOJgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:36:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiBOJgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:36:09 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9649CB8221
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:35:59 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JybWx0LNyz9sgP;
        Tue, 15 Feb 2022 17:34:21 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Feb 2022 17:35:57 +0800
Subject: Re: [PATCH 2/8] mm/memory-failure.c: avoid walking page table when
 vma_address() return -EFAULT
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220210141733.1908-1-linmiaohe@huawei.com>
 <20220210141733.1908-3-linmiaohe@huawei.com> <20220214144826.GB2624914@u2004>
 <1c464c41-81f4-fff9-c4e0-45fd4d05e34b@huawei.com>
 <20220215083755.GA2001565@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <335dffa8-fc2d-d3da-e64b-b6d608e3fba6@huawei.com>
Date:   Tue, 15 Feb 2022 17:35:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220215083755.GA2001565@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2022/2/15 16:37, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Tue, Feb 15, 2022 at 10:40:02AM +0800, Miaohe Lin wrote:
>> On 2022/2/14 22:48, Naoya Horiguchi wrote:
>>> On Thu, Feb 10, 2022 at 10:17:27PM +0800, Miaohe Lin wrote:
>>>> It's unnecessary to walk the page table when vma_address() return -EFAULT.
>>>> Return early if so to save some cpu cycles.
>>>>
>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>
>>> Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>
>> Many thanks for your review and Acked-by tag!
> 
> You're welcome :)
> 
>>
>>>
>>> Does this patch fix the real problem rather than just saving cpu cycles?
>>> Without this patch, "address == -EFAULT" seems to make pgd_offset() return
>>> invalid pointer and result in some serious result like general protection fault.
>>
>> I think you're right. We might dereference the invalid pointer in the following pagetable
>> walk and results in general protection fault.
>>
>>> If that's the case, this patch might be worth sending to stable.
>>
>> But I'am not sure vma_address will return -EFAULT for dax pages in the real workload?
>> If so, I will send a v2 with Fixes tag.
> 
> Hm, actually I'm not sure either.  But dev_pagemap_mapping_shift() is called only
> when vma associated to the error page is found already in collect_procs_{file,anon},
> so vma_address() should not return -EFAULT except with some bug.
> So VM_BUG_ON() might be more suitable?

Agree. anon_vma_interval_tree_foreach/vma_interval_tree_foreach in collect_procs_{file,anon} should
have guaranteed the validity of the vma_address(). And rmap_walk_anon and rmap_walk_file do the
VM_BUG_ON_VMA(address == -EFAULT, vma). So VM_BUG_ON() might be really more suitable. Will do this
in v2.

Many thanks.

> 
> Thanks,
> Naoya Horiguchi
> 
