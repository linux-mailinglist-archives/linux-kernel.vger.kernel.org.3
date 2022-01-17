Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9355C490B8F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240547AbiAQPjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:39:41 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4423 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237314AbiAQPjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:39:40 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JcwwL58s3z6F98b;
        Mon, 17 Jan 2022 23:35:46 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 17 Jan 2022 16:39:38 +0100
Received: from [10.47.92.236] (10.47.92.236) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Mon, 17 Jan
 2022 15:39:37 +0000
Subject: Re: [PATCH] perf test: Test 73 Sig_trap fails on s390
To:     Marco Elver <elver@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <acme@kernel.org>, <svens@linux.ibm.com>, <gor@linux.ibm.com>,
        <sumanthk@linux.ibm.com>, <hca@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20211216151454.752066-1-tmricht@linux.ibm.com>
 <CANpmjNNMWtjcKa961SjEvRbbPXyw5M5SkrXbb3tnyL3_XyniCw@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <90efb5a9-612a-919e-cf2f-c528692d61e2@huawei.com>
Date:   Mon, 17 Jan 2022 15:39:10 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CANpmjNNMWtjcKa961SjEvRbbPXyw5M5SkrXbb3tnyL3_XyniCw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.92.236]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/2021 15:48, Marco Elver wrote:

+

> On Thu, 16 Dec 2021 at 16:15, Thomas Richter<tmricht@linux.ibm.com>  wrote:
>> In Linux next kernel
>> Commit 5504f67944484 ("perf test sigtrap: Add basic stress test for sigtrap handling")
>> introduced the new test which uses breakpoint events.
>> These events are not supported on s390 and PowerPC and always fail:
>>
>>   # perf test -F 73
>>   73: Sigtrap                                                         : FAILED!
>>   #
>>
>> Fix it the same way as in the breakpoint tests in file
>> tests/bp_account.c where these type of tests are skipped on
>> s390 and PowerPC platforms.
>>
>> With this patch skip this test on both platforms.
>>
>> Output after:
>>   # ./perf test -F 73
>>   73: Sigtrap
>>
>> Fixes: 5504f67944484 ("perf test sigtrap: Add basic stress test for sigtrap handling")
>>
>> Cc: Marco Elver<elver@google.com>
>> Signed-off-by: Thomas Richter<tmricht@linux.ibm.com>
> Acked-by: Marco Elver<elver@google.com>
> 
> Thanks, and sorry for missing this case!
> 

I am finding that this test hangs on my arm64 machine:

john@debian:~/kernel-dev2/tools/perf$ sudo ./perf test -vvv 73
  73: Sigtrap:
--- start ---
test child forked, pid 45193

And fails on my x86 broadwell machine:

john@localhost:~/kernel-dev2/tools/perf> sudo ./perf test -v 73
73: Sigtrap                                                         :
--- start ---
test child forked, pid 22255
FAILED sys_perf_event_open(): Argument list too long
test child finished with -1
---- end ----
Sigtrap: FAILED!
john@localhost:~/kernel-dev2/tools/perf>

Are there more architectures+platforms for which we need to skip this test?

Thanks,
John
