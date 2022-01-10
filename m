Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3875B488EE6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 04:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238345AbiAJDVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 22:21:33 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:16696 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbiAJDVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 22:21:32 -0500
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JXJtD4Wt3zZf4c;
        Mon, 10 Jan 2022 11:17:56 +0800 (CST)
Received: from [10.67.110.136] (10.67.110.136) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Mon, 10 Jan 2022 11:20:39 +0800
Subject: Re: [PATCH] arm64: Make CONFIG_ARM64_PSEUDO_NMI macro wrap all the
 pseudo-NMI code
To:     Marc Zyngier <maz@kernel.org>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <marcan@marcan.st>, <joey.gouly@arm.com>,
        <pcc@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220107085536.214501-1-heying24@huawei.com>
 <87pmp2tmpg.wl-maz@kernel.org>
From:   He Ying <heying24@huawei.com>
Message-ID: <a010e8dd-428b-c295-b2db-020d8cc698c5@huawei.com>
Date:   Mon, 10 Jan 2022 11:20:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87pmp2tmpg.wl-maz@kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.136]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

I'm just back from the weekend and sorry for the delayed reply.


ÔÚ 2022/1/8 20:51, Marc Zyngier Ð´µÀ:
> On Fri, 07 Jan 2022 08:55:36 +0000,
> He Ying <heying24@huawei.com> wrote:
>> Our product has been updating its kernel from 4.4 to 5.10 recently and
>> found a performance issue. We do a bussiness test called ARP test, which
>> tests the latency for a ping-pong packets traffic with a certain payload.
>> The result is as following.
>>
>>   - 4.4 kernel: avg = ~20s
>>   - 5.10 kernel (CONFIG_ARM64_PSEUDO_NMI is not set): avg = ~40s
>>
>> I have been just learning arm64 pseudo-NMI code and have a question,
>> why is the related code not wrapped by CONFIG_ARM64_PSEUDO_NMI?
>> I wonder if this brings some performance regression.
>>
>> First, I make this patch and then do the test again. Here's the result.
>>
>>   - 5.10 kernel with this patch not applied: avg = ~40s
>>   - 5.10 kernel with this patch applied: avg = ~23s
>>
>> Amazing! Note that all kernel is built with CONFIG_ARM64_PSEUDO_NMI not
>> set. It seems the pseudo-NMI feature actually brings some overhead to
>> performance event if CONFIG_ARM64_PSEUDO_NMI is not set.
>>
>> Furthermore, I find the feature also brings some overhead to vmlinux size.
>> I build 5.10 kernel with this patch applied or not while
>> CONFIG_ARM64_PSEUDO_NMI is not set.
>>
>>   - 5.10 kernel with this patch not applied: vmlinux size is 384060600 Bytes.
>>   - 5.10 kernel with this patch applied: vmlinux size is 383842936 Bytes.
>>
>> That means arm64 pseudo-NMI feature may bring ~200KB overhead to
>> vmlinux size.
>>
>> Above all, arm64 pseudo-NMI feature brings some overhead to vmlinux size
>> and performance even if config is not set. To avoid it, add macro control
>> all around the related code.
> This obviously attracted my attention, and I took this patch for a
> ride on 5.16-rc8 on a machine that doesn't support GICv3 NMIs to make
> sure that any extra code would only result in pure overhead.
>
> There was no measurable difference with this patch applied or not,
> with CONFIG_ARM64_PSEUDO_NMI selected or not for the workloads I tried
> (I/O heavy virtual machines, hackbench).
Our test is some kind of network test.
>
> Mark already asked a number of questions (test case, implementation,
> test on a modern kernel). Please provide as many detail as you
> possibly can, because such a regression really isn't expected, and
> doesn't show up on the systems I have at hand. Some profiling numbers
> could also be interesting, in case this is a result of a particular
> resource being thrashed (TLB, cache...).

I replied to Mark a few moments ago and provided as many details as I can.

You mentioned TLB and cache could be thrashed. How can we check this?

By using perf tools?

>
> Thanks,
>
> 	M.
>
