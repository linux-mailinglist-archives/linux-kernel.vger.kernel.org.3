Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7C4497BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiAXJTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:19:45 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4444 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiAXJTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:19:32 -0500
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jj4854kSmz686qc;
        Mon, 24 Jan 2022 17:15:17 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 10:19:30 +0100
Received: from [10.47.89.21] (10.47.89.21) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Mon, 24 Jan
 2022 09:19:29 +0000
Subject: Test 73 Sig_trap fails on arm64 (was Re: [PATCH] perf test: Test 73
 Sig_trap fails on s390)
To:     Leo Yan <leo.yan@linaro.org>, Marco Elver <elver@google.com>,
        Will Deacon <will@kernel.org>
CC:     Thomas Richter <tmricht@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <acme@kernel.org>, <svens@linux.ibm.com>, <gor@linux.ibm.com>,
        <sumanthk@linux.ibm.com>, <hca@linux.ibm.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20211216151454.752066-1-tmricht@linux.ibm.com>
 <CANpmjNNMWtjcKa961SjEvRbbPXyw5M5SkrXbb3tnyL3_XyniCw@mail.gmail.com>
 <90efb5a9-612a-919e-cf2f-c528692d61e2@huawei.com>
 <20220118091827.GA98966@leoy-ThinkPad-X240s>
 <CANpmjNMPoU+1b1fKFuYDYwisW2YfjQHxGt5hgLp1tioG7C2jmg@mail.gmail.com>
 <20220118124343.GC98966@leoy-ThinkPad-X240s>
From:   John Garry <john.garry@huawei.com>
Message-ID: <bfa0af18-04ac-857d-d3d8-ad9290f912c8@huawei.com>
Date:   Mon, 24 Jan 2022 09:19:00 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220118124343.GC98966@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.89.21]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2022 12:43, Leo Yan wrote:

Hi Will,

Can you kindly check below the question from Leo on this issue?

You were cc'ed earlier in this thread so should be able to find more 
context, if needed.

Cheers,
John

> On Tue, Jan 18, 2022 at 12:40:04PM +0100, Marco Elver wrote:
> 
> [...]
> 
>>> Both Arm and Arm64 platforms cannot support signal handler with
>>> breakpoint, please see the details in [1].  So I think we need
>>> something like below:
>>>
>>> static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
>>> {
>>>          ...
>>>
>>>          if (!BP_SIGNAL_IS_SUPPORTED) {
>>>                  pr_debug("Test not supported on this architecture");
>>>                  return TEST_SKIP;
>>>          }
>>>
>>>          ...
>>> }
>>>
>>> Since we have defined BP_SIGNAL_IS_SUPPORTED, I think we can reuse it at
>>> here.
>>>
>>> [1]https://lore.kernel.org/lkml/157169993406.29376.12473771029179755767.tip-bot2@tip-bot2/
>> Does this limitation also exist for address watchpoints? The sigtrap
>> test does not make use of instruction breakpoints, but instead just
>> sets up a watchpoint on access to a data address.
> Yes, after reading the code, the flow for either instrution breakpoint
> or watchpoint both use the single step [1], thus the signal handler will
> take the single step execution and lead to the infinite loop.
> 
> I am not the best person to answer this question; @Will, could you
> confirm for this?  Thanks!
> 
> Leo
> 
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/kernel/hw_breakpoint.c

