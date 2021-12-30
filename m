Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B68481A09
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 07:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbhL3GqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 01:46:01 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15991 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhL3GqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 01:46:00 -0500
Received: from kwepemi100004.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JPdxW5nyDzZdsk;
        Thu, 30 Dec 2021 14:42:39 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi100004.china.huawei.com (7.221.188.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 30 Dec 2021 14:45:58 +0800
Received: from [10.174.179.79] (10.174.179.79) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 30 Dec 2021 14:45:58 +0800
Subject: Re: [PATCH -next 0/2] riscv/mm: Enable THP migration
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <palmerdabbelt@google.com>, <wangkefeng.wang@huawei.com>,
        <anup@brainfault.org>, <alex@ghiti.fr>, <jszhang@kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20211123140638.3852400-1-sunnanyong@huawei.com>
From:   Nanyong Sun <sunnanyong@huawei.com>
Message-ID: <3c9ba160-74b2-a933-e8e5-9fd5359dc2cc@huawei.com>
Date:   Thu, 30 Dec 2021 14:45:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211123140638.3852400-1-sunnanyong@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.79]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

This patchset has been sent for one month ago, I was wondering if you could

have a review and give a feedback please, thanks.

On 2021/11/23 22:06, Nanyong Sun wrote:
> This series enables THP migration on riscv via ARCH_ENABLE_THP_MIGRATION.
> But first this adjusts PAGE_PROT_NONE to satisfy generic memory semantics
> like the behavior of pmd_present() and pmd_trans_huge() when in
> THP splitting or migration.
>
> This feature can reduce the time of THP migration by not splits THP
> before migration and can guarantee the pages after migration are still
> contiguous.[1]
>
> I have tested the below test case on qemu based on riscv after
> enabling this feature, the throughput of THP migration gains 13x
> performance improvement:
> https://github.com/x-y-z/thp-migration-bench
>
> I also have tested and passed the test cases under
> tools/testing/selftests/vm.
>
> [1]: https://lwn.net/Articles/723764/
>
> Nanyong Sun (2):
>    riscv/mm: Adjust PAGE_PROT_NONE to comply with THP semantics
>    riscv/mm: Enable THP migration
>
>   arch/riscv/Kconfig                    |  1 +
>   arch/riscv/include/asm/pgtable-bits.h |  2 +-
>   arch/riscv/include/asm/pgtable.h      | 16 +++++++++++-----
>   3 files changed, 13 insertions(+), 6 deletions(-)
>
