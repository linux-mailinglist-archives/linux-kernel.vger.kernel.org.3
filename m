Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963B446FB29
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 08:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237337AbhLJHSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 02:18:40 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:29171 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbhLJHSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:18:38 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4J9MYf5c15z8vnk;
        Fri, 10 Dec 2021 15:12:54 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 15:15:02 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 15:15:01 +0800
Message-ID: <afde1574-23b6-a36a-445e-5fb03873fe86@huawei.com>
Date:   Fri, 10 Dec 2021 15:15:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v17 00/10] support reserving crashkernel above 4G on arm64
 kdump
Content-Language: en-US
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Chen Zhou <dingguo.cz@antgroup.com>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20211210065533.2023-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/12/10 14:55, Zhen Lei wrote:
> There are following issues in arm64 kdump:
> 1. We use crashkernel=X to reserve crashkernel below 4G, which
> will fail when there is no enough low memory.
> 2. If reserving crashkernel above 4G, in this case, crash dump
> kernel will boot failure because there is no low memory available
> for allocation.
>
> To solve these issues, change the behavior of crashkernel=X.
> crashkernel=X tries low allocation in DMA zone and fall back to high
> allocation if it fails.
>
> We can also use "crashkernel=X,high" to select a high region above
> DMA zone, which also tries to allocate at least 256M low memory in
> DMA zone automatically and "crashkernel=Y,low" can be used to allocate
> specified size low memory.
>
> When reserving crashkernel in high memory, some low memory is reserved
> for crash dump kernel devices. So there may be two regions reserved for
> crash dump kernel.
> In order to distinct from the high region and make no effect to the use
> of existing kexec-tools, rename the low region as "Crash kernel (low)",
> and pass the low region by reusing DT property
> "linux,usable-memory-range". We made the low memory region as the last
> range of "linux,usable-memory-range" to keep compatibility with existing
> user-space and older kdump kernels.
>
> Besides, we need to modify kexec-tools:
> arm64: support more than one crash kernel regions(see [1])
>
> Another update is document about DT property 'linux,usable-memory-range':
> schemas: update 'linux,usable-memory-range' node schema(see [2])
>
> This patchset contains the following 10 patches:
>
> 0001-0004 are some x86 cleanups which prepares for making functionsreserve_crashkernel[_low]() generic.
> 0005 makes functions reserve_crashkernel[_low]() generic.
> 0006-0007 reimplements arm64 crashkernel=X.
> 0008-0009 adds memory for devices by DT property linux,usable-memory-range.
> 0010 updates the doc.
>
> Changes since [v16]
> - Because no functional changes in this version, so add
>    "Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>" for patch 1-9
> - Add "Reviewed-by: Rob Herring <robh@kernel.org>" for patch 8
> - Update patch 9 based on the review comments of Rob Herring
> - As Catalin Marinas's suggestion, merge the implementation of
>    ARCH_WANT_RESERVE_CRASH_KERNEL into patch 5. Ensure that the
>    contents of X86 and ARM64 do not overlap, and reduce unnecessary
>    temporary differences.

An Internal review has been done, so for this series,

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

