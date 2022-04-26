Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C0A510213
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352453AbiDZPm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352020AbiDZPmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:42:55 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5AD65408
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:39:47 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KnmD16VlrzCs4Z;
        Tue, 26 Apr 2022 23:35:13 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 23:39:45 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 23:39:45 +0800
Message-ID: <fc736a39-2c21-70ac-4244-4c5b24ba7974@huawei.com>
Date:   Tue, 26 Apr 2022 23:39:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] arm64: kcsan: Fix kcsan test_barrier fail and panic
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
CC:     <elver@google.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220426081700.1376542-1-wangkefeng.wang@huawei.com>
 <Ymfot/Le95Enuxqb@lakrids>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <Ymfot/Le95Enuxqb@lakrids>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/4/26 20:42, Mark Rutland wrote:
> Hi,
>
> On Tue, Apr 26, 2022 at 08:17:00AM +0000, Kefeng Wang wrote:
>> As "kcsan: Support detecting a subset of missing memory barriers"
>> introduced KCSAN_STRICT which make kcsan detects more missing memory
>> barrier, but arm64 don't have KCSAN instrumentation for barriers, so
>> the new selftest test_barrier() will fail, then panic.
>>
>> Let's prefix all barriers with __ on arm64, as asm-generic/barriers.h
>> defined the final instrumented version of these barriers, which will
>> fix the above issues.
>>
>> Fixes: dd03762ab608 ("arm64: Enable KCSAN")
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> I don't think the Fixes tag is necessary given this is a new feature
> which depends upon EXPERT, and I'm worried it encourages backporting
> this into a kernel where it would be broken, so I'd prefer we drop that
> tag.
>
> IIUC when we originially looked at this the instrumentation wasn't safe
> and would violate noinstr requirements. Looking at linux/kcsan-checks.h,
> the comments block for __KCSAN_BARRIER_TO_SIGNAL_FENCE() say that it
> will respect __nokcsan, so it looks like that might be safe now.
>
> It looks like that's the case as of commit:
>    
>    bd3d5bd1a0ad3864 ("kcsan: Support WEAK_MEMORY with Clang where no objtool support exists")
>
> ... which requires clang 14.0.0+.
>
> That looks to have gone in concurrently with dd03762ab608, but is
> clearly a prerequisite, so as above I'd strongly prefer we drop the
> Fixes tag.

Sure, the "kcsan: Support detecting a subset of missing memory 
barriers"[1] and

dd03762ab608 "arm64: Enable KCSAN" are both merged in v5.17.  I will 
drop the Fixes tag.

> It would be good if we could note that explicitly in the commit message.
I will add some message into v2.
>
> Have you eyeballed the generated assembly to verify that this works as
> expected for __no_kcsan ?
Look good,  will recheck it.
>
> Thanks,
> Mark.
[1] 
https://patchwork.kernel.org/project/linux-mm/cover/20211130114433.2580590-1-elver@google.com/ 

