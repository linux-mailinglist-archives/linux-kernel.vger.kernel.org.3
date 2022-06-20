Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C7D55188C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242190AbiFTMNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242384AbiFTMNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:13:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC6419F96
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 05:12:36 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LRT4H20CHzhYZh;
        Mon, 20 Jun 2022 20:10:23 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 20 Jun 2022 20:12:27 +0800
Subject: Re: [PATCH v2 1/3] mm/swapfile: make security_vm_enough_memory_mm()
 work as expected
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220608144031.829-1-linmiaohe@huawei.com>
 <20220608144031.829-2-linmiaohe@huawei.com>
 <87r13jrdst.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <a384f290-dff3-6dad-f1d3-8ec245b9bebd@huawei.com>
Date:   Mon, 20 Jun 2022 20:12:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87r13jrdst.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

On 2022/6/20 15:31, Huang, Ying wrote:
> Miaohe Lin <linmiaohe@huawei.com> writes:
> 
>> security_vm_enough_memory_mm() checks whether a process has enough memory
>> to allocate a new virtual mapping. And total_swap_pages is considered as
>> available memory while swapoff tries to make sure there's enough memory
>> that can hold the swapped out memory. But total_swap_pages contains the
>> swap space that is being swapoff. So security_vm_enough_memory_mm() will
>> success even if there's no memory to hold the swapped out memory because
>> total_swap_pages always greater than or equal to p->pages.
> 
> Per my understanding, swapoff will not allocate virtual mapping by
> itself.  But after swapoff, the overcommit limit could be exceeded.
> security_vm_enough_memory_mm() is used to check that.  For example, in a
> system with 4GB memory and 8GB swap, and 10GB is in use,
> 
> CommitLimit:    4+8 = 12GB
> Committed_AS:   10GB
> 
> security_vm_enough_memory_mm() in swapoff() will fail because
> 10+8 = 18 > 12.  This is expected because after swapoff, the overcommit
> limit will be exceeded.
> 
> If 3GB is in use,
> 
> CommitLimit:    4+8 = 12GB
> Committed_AS:   3GB
> 
> security_vm_enough_memory_mm() in swapoff() will succeed because
> 3+8 = 11 < 12.  This is expected because after swapoff, the overcommit
> limit will not be exceeded.

In OVERCOMMIT_NEVER scene, I think you're right.

> 
> So, what's the real problem of the original implementation?  Can you
> show it with an example as above?

In OVERCOMMIT_GUESS scene, in a system with 4GB memory and 8GB swap, and 10GB is in use,
pages below is 8GB, totalram_pages() + total_swap_pages is 12GB, so swapoff() will succeed
instead of expected failure because 8 < 12. The overcommit limit is always *ignored* in the
below case.

	if (sysctl_overcommit_memory == OVERCOMMIT_GUESS) {
		if (pages > totalram_pages() + total_swap_pages)
			goto error;
		return 0;
	}

Or am I miss something?

> 
> Best Regards,
> Huang, Ying

Thanks!

> 
>> In order to fix it, p->pages should be retracted from total_swap_pages
>> first and then check whether there's enough memory for inuse swap pages.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> [snip]
> 
> .
> 

