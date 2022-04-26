Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7A25101FB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352390AbiDZPjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346484AbiDZPjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:39:08 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B1EFD25
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:35:59 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Knljt5KSfzfb9P;
        Tue, 26 Apr 2022 23:12:34 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 23:13:27 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 23:13:27 +0800
Message-ID: <4c8acff0-38c5-4a4e-e216-c5252259b1f8@huawei.com>
Date:   Tue, 26 Apr 2022 23:13:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] arm64: kcsan: Fix kcsan test_barrier fail and panic
Content-Language: en-US
To:     Marco Elver <elver@google.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>
References: <20220426081700.1376542-1-wangkefeng.wang@huawei.com>
 <YmfhHuPDilwR/Wgp@elver.google.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <YmfhHuPDilwR/Wgp@elver.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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


On 2022/4/26 20:10, Marco Elver wrote:
> On Tue, Apr 26, 2022 at 08:17AM +0000, Kefeng Wang wrote:
>> As "kcsan: Support detecting a subset of missing memory barriers"
>> introduced KCSAN_STRICT which make kcsan detects more missing memory
>> barrier, but arm64 don't have KCSAN instrumentation for barriers, so
>> the new selftest test_barrier() will fail, then panic.
> Thanks for fixing this - did kcsan_test module pass as well?

Yes， selftest and kcsan_test  passed with gcc11 & clang 14.

...

>> +#ifdef __dma_mb
>> +#define dma_mb()	do { kcsan_mb(); __dma_mb(); } while (0)
>> +#endif
>> +
> So it looks like arm64 is the only arch that defines dma_mb(). By adding
> it to asm-generic, we'd almost be encouraging other architectures to add
> it, which I don't know we want.
>
> Documentation/memory-barriers.txt doesn't mention dma_mb() either - so
> perhaps dma_mb() doesn't belong in asm-generic/barrier.h, and you could
> only change arm64's definition of dma_mb() to add the kcsan_mb().
>
> Preferences? Maybe arch64 maintainers have more background on why arm64
> is an anomaly here.
> .
Let's wait to see aarch64 maintainers's suggestion.
