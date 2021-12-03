Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901F0466FC4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 03:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378021AbhLCCct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 21:32:49 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15689 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbhLCCcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 21:32:48 -0500
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J4xXb5rHXzZdNW;
        Fri,  3 Dec 2021 10:26:39 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 10:29:23 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 10:29:23 +0800
Message-ID: <4cd6d815-aaf2-2d62-cff9-8fb4fae3781d@huawei.com>
Date:   Fri, 3 Dec 2021 10:29:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3] arm64: Enable KCSAN
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>, Marco Elver <elver@google.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <joey.gouly@arm.com>
References: <20211202143331.15259-1-wangkefeng.wang@huawei.com>
 <CANpmjNO5DUk=biDkfP9iepKYBeROO8wL58n8HziOTXuRMOXpvQ@mail.gmail.com>
 <Yajb4w6R4nqPpELq@lakrids>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <Yajb4w6R4nqPpELq@lakrids>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme712-chm.china.huawei.com (10.1.199.108) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/12/2 22:44, Mark Rutland wrote:
> On Thu, Dec 02, 2021 at 03:36:06PM +0100, Marco Elver wrote:
>> On Thu, 2 Dec 2021 at 15:23, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>> This patch enables KCSAN for arm64, with updates to build rules
>>> to not use KCSAN for several incompatible compilation units.
>>>
>>> Resent GCC version(at least GCC10) made outline-atomics as the
>> s/Resent/Recent/
>>
>>> default option(unlike Clang), which will cause linker errors
>>> for kernel/kcsan/core.o. Disables the out-of-line atomics by
>>> no-outline-atomics to fix the linker errors.
>>>
>>> Meanwhile, as Mark said[1], there is a specific issue on arm64
>>> about ARM64_BTI with Clang 11 if KCSAN enabled, which is fixed
>>> by Clang 12, add CLANG_VERSION check. And also some latent issues
>>> are need to be fixed which isn't just a KCSAN problem, we make
>>> the KCSAN depends on EXPERT for now.
>>>
>>> Tested selftest and kcsan_test(built with GCC11 and Clang 13),
>>> and all passed.
>>>
>>> [1] https://lkml.org/lkml/2021/12/1/354
>> Please use lore/kernel.org permalinks. For this one it'd be:
>> https://lkml.kernel.org/r/YadiUPpJ0gADbiHQ@FVFF77S0Q05N
>>
>> (But I think if this is the final version of the patch, hopefully a
>> maintainer can amend the commit message.)
>>
>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Acked-by: Marco Elver <elver@google.com> # kernel/kcsan
>>
>> is still valid, given nothing changed there. I leave the rest to Mark.
> I want to do some compiler / config testing before I ack this (just to
> make sure there isn't some latent issue I've forgotten about), but
> otherwise I think this should be fine.
>
> I'll try to have that done in the next few days.

I will wait for some time, thanks Marco/Mark.

>
> Any other review/testing would be appreciated!

As Nathan points, commit 8cdd23c23c3d ("arm64: Restrict ARM64_BTI_KERNEL

to clang 12.0.0 and newer"), so need to add Clang version check, which 
is v2 does.

is there some other requirement that we need this check, what's your option,

thanks.

>
> Thanks,
> Mark.
>
>
