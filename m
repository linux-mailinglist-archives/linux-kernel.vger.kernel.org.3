Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD0D4BA73D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 18:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243764AbiBQRep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 12:34:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiBQReo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 12:34:44 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2337F16040B;
        Thu, 17 Feb 2022 09:34:29 -0800 (PST)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K01zl5F86z67Z2N;
        Fri, 18 Feb 2022 01:29:55 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Feb 2022 18:34:26 +0100
Received: from [10.47.86.67] (10.47.86.67) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Feb
 2022 17:34:25 +0000
Message-ID: <f7782f09-7f12-b957-a1b2-d0673ec1304c@huawei.com>
Date:   Thu, 17 Feb 2022 17:34:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] perf test: Skip Sigtrap test for arm+aarch64
To:     Marco Elver <elver@google.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <leo.yan@linaro.org>, <dvyukov@google.com>, <will@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux@armlinux.org.uk>,
        <irogers@google.com>, Thomas Richter <tmricht@linux.ibm.com>
References: <1645114959-119064-1-git-send-email-john.garry@huawei.com>
 <CANpmjNOO6yxF+xXoatR==uvSaEwsWyZ=n7ExEM_=OJaDYBCeSw@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <CANpmjNOO6yxF+xXoatR==uvSaEwsWyZ=n7ExEM_=OJaDYBCeSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.86.67]
X-ClientProxiedBy: lhreml714-chm.china.huawei.com (10.201.108.65) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2022 16:45, Marco Elver wrote:
> On Thu, 17 Feb 2022 at 17:28, John Garry <john.garry@huawei.com> wrote:

+ Ian, Thomas

>>
>> Skip the Sigtrap test for arm + arm64, same as was done for s390 in
>> commit a840974e96fd ("perf test: Test 73 Sig_trap fails on s390").
>>
>> As described by Will at [0], in the test we get stuck in a loop of handling
>> the HW breakpoint exception and never making progress. GDB handles this
>> by stepping over the faulting instruction, but with perf the kernel is
>> expected to handle the step (which it doesn't for arm).
>>
>> Dmitry made an attempt to get this work, also mentioned in the same thread
>> as [0], which was appreciated. But the best thing to do is skip the test
>> for now.
>>
>> [0] https://lore.kernel.org/linux-perf-users/20220118124343.GC98966@leoy-ThinkPad-X240s/T/#m13b06c39d2a5100d340f009435df6f4d8ee57b5a
>>
>> Fixes: Fixes: 5504f67944484 ("perf test sigtrap: Add basic stress test for sigtrap handling")
>> Signed-off-by: John Garry <john.garry@huawei.com>
>>
>> diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
>> index 1f147fe6595f..3f0b5c1398b5 100644
>> --- a/tools/perf/tests/sigtrap.c
>> +++ b/tools/perf/tests/sigtrap.c
>> @@ -29,7 +29,8 @@
>>    * Just disable the test for these architectures until these issues are
>>    * resolved.
>>    */
>> -#if defined(__powerpc__) || defined(__s390x__)
>> +#if defined(__powerpc__) || defined(__s390x__) || \
>> +       defined(__arm__) || defined(__aarch64__)
>>   #define BP_ACCOUNT_IS_SUPPORTED 0
>>   #else
>>   #define BP_ACCOUNT_IS_SUPPORTED 1
> 
> This is now equivalent to BP_SIGNAL_IS_SUPPORTED
> tools/perf/tests/tests.h -- and different from the original
> BP_ACCOUNT_IS_SUPPORTED (and makes me wonder why
> BP_SIGNAL_IS_SUPPORTED wasn't just used from the beginning). Perhaps
> just use BP_SIGNAL_IS_SUPPORTED.
> 

We currently have BP_ACCOUNT_IS_SUPPORTED defined now in 2x locations:

tests/sigtrap.c
tests/bp_account.c

bp_account works for arm64, and we don't want to skip that test. So, as 
long as the macro meaning is appropriate, we can reuse 
BP_SIGNAL_IS_SUPPORTED for sigtrap.c

Thanks,
John
