Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658EE5389F9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 04:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243615AbiEaClD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 22:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237072AbiEaClB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 22:41:01 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585556470E
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 19:41:00 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LBxNJ5QpJzDqZ8;
        Tue, 31 May 2022 10:40:48 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 31 May 2022 10:40:58 +0800
Subject: Re: [PATCH 1/3] mm/swapfile: make security_vm_enough_memory_mm() work
 as expected
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220527092626.31883-1-linmiaohe@huawei.com>
 <20220527092626.31883-2-linmiaohe@huawei.com>
 <20220530160223.63ae3bdef7420f252d7366ed@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <cbcd5684-8bfd-46cd-c49c-8a3727cabf11@huawei.com>
Date:   Tue, 31 May 2022 10:40:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220530160223.63ae3bdef7420f252d7366ed@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/31 7:02, Andrew Morton wrote:
> On Fri, 27 May 2022 17:26:24 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> security_vm_enough_memory_mm() checks whether a process has enough memory
>> to allocate a new virtual mapping. And total_swap_pages is considered as
>> available memory while swapoff tries to make sure there's enough memory
>> that can hold the swapped out memory. But total_swap_pages contains the
>> swap space that is being swapoff. So security_vm_enough_memory_mm() will
>> success even if there's no memory to hold the swapped out memory because
>> total_swap_pages always greater than or equal to p->pages.
>>
>> In order to fix it, p->pages should be retracted from total_swap_pages
>> first and then check whether there's enough memory for inuse swap pages.
> 
> User-visible impact?

With this change, swapping in pages is not even tried if there's no enough memory.
But in user's view, swapoff() is failed just like before when there's no enough memory.

> 
> If I'm understanding correctly, there's a risk that this fix will cause
> existing setups to newly fail when attempting swapoff()?

IIUC, the previous behavior would be:
Failing swapoff() after swapping in many pages due to lacking of physical memory, though
security_vm_enough_memory_mm() always tell us there's enough memory.

The changed behavior will be:
Failing swapoff() *without* swapping in many pages according to the right conclusion
of security_vm_enough_memory_mm().

IMHO, The final result should be same, but security_vm_enough_memory_mm() can tell us
whether we could succeed to swapoff() with this patch. Or am I miss something?

Many thanks for comment and reply!

> 
> 
> 
> .
> 

