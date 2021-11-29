Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D6B461A7A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 15:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245256AbhK2PAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 10:00:44 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16321 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235992AbhK2O6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:58:40 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J2pKk4Sr1z91PK;
        Mon, 29 Nov 2021 22:54:50 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 22:55:21 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 22:55:21 +0800
Message-ID: <8a4dbf98-1ac0-d48d-98fa-c7392e6a4de1@huawei.com>
Date:   Mon, 29 Nov 2021 22:55:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH Resend v2 0/3] ARM: Support KFENCE feature
Content-Language: en-US
To:     <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <glider@google.com>, <elver@google.com>, <dvyukov@google.com>
References: <20211115134848.171098-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20211115134848.171098-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme706-chm.china.huawei.com (10.1.199.102) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell，

Could I send this to ARM patch system if no more comments,

what about your opinion, thanks.

On 2021/11/15 21:48, Kefeng Wang wrote:
> This patchset supports Kfence feature, tested the kfence_test on ARM QEMU
> with or without ARM_LPAE and all passed.
>
> V2 Resend:
> - adjust is_write_fault() position in patch2 not patch3, sugguested Alexander
> - Add ACKed from Marco
> - rebased on v5.16-rc1
>
> V2:
> - drop patch4 in v1, which is used a new way to skip kfence test
>    see commit c40c6e593bf9 ("kfence: test: fail fast if disabled at boot")
> - fix some issue about NO MMU
>    - drop useless set_memory_valid() under no mmu
>    - fix implicit declaration of function ‘is_write_fault’ if no mmu
> - make KFENCE depends on !XIP_KERNEL, no tested with xip
>
> v1:
> https://lore.kernel.org/linux-arm-kernel/20210825092116.149975-1-wangkefeng.wang@huawei.com/
>
> Kefeng Wang (3):
>    ARM: mm: Provide set_memory_valid()
>    ARM: mm: Provide is_write_fault()
>    ARM: Support KFENCE for ARM
>
>   arch/arm/Kconfig                  |  1 +
>   arch/arm/include/asm/kfence.h     | 53 +++++++++++++++++++++++++++++++
>   arch/arm/include/asm/set_memory.h |  1 +
>   arch/arm/mm/fault.c               | 16 ++++++++--
>   arch/arm/mm/pageattr.c            | 42 ++++++++++++++++++------
>   5 files changed, 100 insertions(+), 13 deletions(-)
>   create mode 100644 arch/arm/include/asm/kfence.h
>
