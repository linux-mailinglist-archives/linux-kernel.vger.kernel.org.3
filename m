Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934BC480F2C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 04:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238478AbhL2DLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 22:11:53 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:30121 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbhL2DLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 22:11:52 -0500
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JNxDw4bjZz1DKBt;
        Wed, 29 Dec 2021 11:08:32 +0800 (CST)
Received: from [10.174.179.106] (10.174.179.106) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 29 Dec 2021 11:11:49 +0800
Subject: Re: [PATCH] cache: Workaround HiSilicon Taishan DC CVAU
To:     Will Deacon <will@kernel.org>
CC:     <catalin.marinas@arm.com>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <20211126091139.358114-1-chenweilong@huawei.com>
 <20211213185643.GA12717@willie-the-truck>
From:   chenweilong <chenweilong@huawei.com>
Message-ID: <d8e62725-5597-7cc5-b862-db0cb5564bba@huawei.com>
Date:   Wed, 29 Dec 2021 11:11:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20211213185643.GA12717@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.179.106]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/14 2:56, Will Deacon wrote:
> On Fri, Nov 26, 2021 at 05:11:39PM +0800, Weilong Chen wrote:
>> Taishan's L1/L2 cache is inclusive, and the data is consistent.
>> Any change of L1 does not require DC operation to brush CL in L1 to L2.
>> It's safe that don't clean data cache by address to point of unification.
>>
>> Without IDC featrue, kernel needs to flush icache as well as dcache,
>> causes performance degradation.
>>
>> The flaw refers to V110/V200 variant 1.
>>
>> Signed-off-by: Weilong Chen <chenweilong@huawei.com>
>> ---
>>  Documentation/arm64/silicon-errata.rst |  2 ++
>>  arch/arm64/Kconfig                     | 11 +++++++++
>>  arch/arm64/include/asm/cputype.h       |  2 ++
>>  arch/arm64/kernel/cpu_errata.c         | 32 ++++++++++++++++++++++++++
>>  arch/arm64/tools/cpucaps               |  1 +
>>  5 files changed, 48 insertions(+)
> Hmm. We don't usually apply optimisations for specific CPUs on arm64, simply
> because the diversity of CPUs out there means it quickly becomes a
> fragmented mess.
>
> Is this patch purely a performance improvement? If so, please can you
> provide some numbers in an attempt to justify it?

Yes，it's a performance improvement. I have a test program like this:

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/time.h>

int main()
{
        void *tmp;
        int len = 200 * 1024 * 1024;
        struct timeval start, end;
        int interval;
        tmp = mmap(NULL, len, PROT_READ|PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
        if(tmp == MAP_FAILED) {
                perror("mmap failed");
                exit(errno);
        }
        memset(tmp, 0, len);

        gettimeofday(&start, NULL);
        if(mprotect(tmp, len, PROT_READ|PROT_EXEC)) {
                perror("Couldn’t mprotect");
                exit(errno);
        }
        gettimeofday(&end, NULL);
        interval = 1000000*(end.tv_sec - start.tv_sec) + (end.tv_usec - start.tv_usec);
        printf("interval = %fms\n", interval/1000.0);
}

Without this fix, the mprotect takes:

interval = 25.608000ms

And with this fix:

interval = 0.689000ms

Have better performance improvement.

If you think it is suitable, I will send a v2 patch as the original patch broken cpu hotplug checks.

>
> Thanks,
>
> Will
> .


