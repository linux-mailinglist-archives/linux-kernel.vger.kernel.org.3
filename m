Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219BE4923B4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 11:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbiARKVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 05:21:13 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4425 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiARKVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 05:21:11 -0500
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JdPqG3ZTPz67PwS;
        Tue, 18 Jan 2022 18:18:02 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 18 Jan 2022 11:21:07 +0100
Received: from [10.47.94.101] (10.47.94.101) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 18 Jan
 2022 10:21:06 +0000
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] perf test: Test 73 Sig_trap fails on s390
To:     Leo Yan <leo.yan@linaro.org>
CC:     Marco Elver <elver@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <acme@kernel.org>, <svens@linux.ibm.com>, <gor@linux.ibm.com>,
        <sumanthk@linux.ibm.com>, <hca@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20211216151454.752066-1-tmricht@linux.ibm.com>
 <CANpmjNNMWtjcKa961SjEvRbbPXyw5M5SkrXbb3tnyL3_XyniCw@mail.gmail.com>
 <90efb5a9-612a-919e-cf2f-c528692d61e2@huawei.com>
 <20220118091827.GA98966@leoy-ThinkPad-X240s>
Message-ID: <46d27f58-7732-3359-e0aa-090468a1cb22@huawei.com>
Date:   Tue, 18 Jan 2022 10:20:37 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220118091827.GA98966@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.94.101]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

>> test child forked, pid 45193
> Both Arm and Arm64 platforms cannot support signal handler with
> breakpoint, please see the details in [1].  

Thanks for the info.

>So I think we need
> something like below:
> 

ok

> static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
> {
>          ...
> 
>          if (!BP_SIGNAL_IS_SUPPORTED) {
>                  pr_debug("Test not supported on this architecture");
>                  return TEST_SKIP;
>          }
> 
>          ...
> }
> 
> Since we have defined BP_SIGNAL_IS_SUPPORTED, I think we can reuse it at
> here.


Do you know any other architectures which would have this issue? Or a 
generic way to check for support?

It's better to not have to add to this list arch-by-arch..

> 
> [1]https://lore.kernel.org/lkml/157169993406.29376.12473771029179755767.tip-bot2@tip-bot2/
> 
>> And fails on my x86 broadwell machine:
>>
>> john@localhost:~/kernel-dev2/tools/perf> sudo ./perf test -v 73
>> 73: Sigtrap                                                         :
>> --- start ---
>> test child forked, pid 22255
>> FAILED sys_perf_event_open(): Argument list too long
>> test child finished with -1
>> ---- end ----
>> Sigtrap: FAILED!
>> john@localhost:~/kernel-dev2/tools/perf>
> It is a bit suprise for the failure on x86, as I remembered x86 platform
> can support signal handler with hw breakpoint.  And from the error
> "Argument list too long", it should be a different issue from other
> archs.

Yeah, I don't know what's going on here.

Thanks,
John
