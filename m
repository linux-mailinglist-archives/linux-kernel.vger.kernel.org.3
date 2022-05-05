Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D4E51C2B3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380704AbiEEOh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353097AbiEEOh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:37:26 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC665AA67
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 07:33:46 -0700 (PDT)
Received: from kwepemi500003.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KvGPg0fVQz1JBgJ;
        Thu,  5 May 2022 22:32:39 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500003.china.huawei.com (7.221.188.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 22:33:43 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 22:33:41 +0800
Message-ID: <618afddc-7110-d6bd-57a4-b80777d560b6@huawei.com>
Date:   Thu, 5 May 2022 22:33:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next v4 4/7] arm64: add copy_{to, from}_user to machine
 check safe
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
References: <20220420030418.3189040-1-tongtiangen@huawei.com>
 <20220420030418.3189040-5-tongtiangen@huawei.com> <YnJU4NIrJmHLawgk@arm.com>
 <7da54d72-e5fa-41b5-67ea-a0b084e4c94a@huawei.com> <YnPUHC3GlZs6XHU4@arm.com>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <YnPUHC3GlZs6XHU4@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/5/5 21:41, Catalin Marinas 写道:
> On Thu, May 05, 2022 at 02:39:43PM +0800, Tong Tiangen wrote:
>> 在 2022/5/4 18:26, Catalin Marinas 写道:
>>> On Wed, Apr 20, 2022 at 03:04:15AM +0000, Tong Tiangen wrote:
>>>> Add copy_{to, from}_user() to machine check safe.
>>>>
>>>> If copy fail due to hardware memory error, only the relevant processes are
>>>> affected, so killing the user process and isolate the user page with
>>>> hardware memory errors is a more reasonable choice than kernel panic.
>>>
>>> Just to make sure I understand - we can only recover if the fault is in
>>> a user page. That is, for a copy_from_user(), we can only handle the
>>> faults in the source address, not the destination.
>>
>> At the beginning, I also thought we can only recover if the fault is in a
>> user page.
>> After discussion with a Mark[1], I think no matter user page or kernel page,
>> as long as it is triggered by the user process, only related processes will
>> be affected. According to this
>> understanding, it seems that all uaccess can be recovered.
>>
>> [1]https://patchwork.kernel.org/project/linux-arm-kernel/patch/20220406091311.3354723-6-tongtiangen@huawei.com/
> 
> We can indeed safely skip this copy and return an error just like
> pretending there was a user page fault. However, my point was more
> around the "isolate the user page with hardware memory errors". If the
> fault is on a kernel address, there's not much you can do about. You'll
> likely trigger it later when you try to access that address (maybe it
> was freed and re-allocated). Do we hope we won't get the same error
> again on that kernel address?

I think the page with memory error will be isolated by memory_failure(), 
generally, isolation will succeed, if isolate failure(we need to find 
out why), then maybe the same error will trigger it later.

Thanks.

> 
